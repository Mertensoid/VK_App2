//
//  PhotoService.swift
//  VK_App
//
//  Created by admin on 17.04.2022.
//

import Foundation
import Alamofire

class PhotoService {
    //Время, в течение которого кэш остается актуальным
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    //Словарь, в котором будут хранится изображения (кэш в оперативной памяти)
    private var images = [String: UIImage]()
    
    //Название папки для хранения кэшированных файлов
    private static let pathName: String = {
        let pathName = "images"
        
        guard
            let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cachesDirectory.appendingPathComponent(
            pathName,
            isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil)
        }
        return pathName
    }()
    
    //Берем имя файла из URL и добавляем его в путь для сохранения или загрузки
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    //Сохраняем картинку по полученному пути
    private func saveImageToCache(url: String, image: UIImage) {
        guard
            let fileName = getFilePath(url: url),
            let data = image.pngData()
        else { return }
        FileManager.default.createFile(
            atPath: fileName,
            contents: data,
            attributes: nil)
    }
    
    //Загружаем изображение из папки, проверяем дату сохранения. Если дата слишком старая, не загружаем из кэша.
    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName)
        else { return nil }
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
    
    //Загрузка фото из сети
    private func loadPhoto(atIndexPath indexPath: IndexPath, byURL url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                if self?.container != nil {
                    self?.container!.reloadRow(atIndexPath: indexPath)
                }
            }
        }
    }
    
    //Загрузка фото из сети без обновления ячейки таблицы
    private func loadPhoto(byURL url: String) -> UIImage? {
        var loadedImage: UIImage?
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data
            else { return }
            loadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self?.images[url] = loadedImage
            }
            if loadedImage != nil {
                self?.saveImageToCache(url: url, image: loadedImage!)
            }
        }
        return loadedImage
    }
    
    //Ищем фото по URL в
    //1.В оперативной памяти
    //2.В файловой системе
    //3.В сети
    func photo(atIndexPath indexPath: IndexPath, byURL url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexPath: indexPath, byURL: url)
        }
        return image
    }
    
    //Ищем одиночное фото
    func photo(byURL url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            image = loadPhoto(byURL: url)
        }
        return image
    }
    
    //Контейнер для хранения обертки
    private let container: DataReloadable?
    
    //Конструктор для таблицы
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    //Конструктор для коллекции
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    init() {
        self.container = nil
    }
    
}

//Протокол, необходимый для создания единого способа обновления ячейки таблиц и коллекций
fileprivate protocol DataReloadable {
    func reloadRow(atIndexPath indexPath: IndexPath)
}

extension PhotoService {
    //Обертка для таблиц, реализующая метод обновления
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    //Обертка для коллекций, реализующая метод обновления
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
