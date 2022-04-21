

import UIKit
import Kingfisher

class NewsTableViewController: UITableViewController {

    private let networkService = NetworkService()
    private var sources: [(String, String)] = []
    private var news: [NewsData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var photoService: PhotoService?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY - HH:mm"
        return formatter
    }()
    
    enum typeOfCell {
        case titleCell
        case textCell
        case pictureCell
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = PhotoService(container: tableView)

        tableView.delegate = self
        tableView.dataSource = self
        
        self.networkService.fetchNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.news = news
            case .failure(let error):
                print(error)
            }
        }
        
        tableView.register(UINib(nibName: "NewsTitleTableCell", bundle: nil), forCellReuseIdentifier: "newsTitleTableCell")
        tableView.register(UINib(nibName: "NewsTextTableCell", bundle: nil), forCellReuseIdentifier: "newsTextTableCell")
        tableView.register(UINib(nibName: "NewsPictureTableCell", bundle: nil), forCellReuseIdentifier: "newsPictureTableCell")
        tableView.register(UINib(nibName: "NewsTableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "newsTableHeader")
        tableView.register(UINib(nibName: "NewsTableFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "newsTableFooter")
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let newsHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "newsTableHeader") as? NewsTableHeader
        else { return UIView() }

        let date = self.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self.news[section].date)))

        newsHeaderView.configure(authorName: "Я не знаю как получить автора", authorPicURL: "", dateOfPost: date)

        return newsHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 74
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let newsFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "newsTableFooter") as? NewsTableFooter
        else { return UIView() }
        newsFooterView.config(
            likes: news[section].likes.likes,
            comments: news[section].comments.commentsCount,
            reposts: news[section].reposts.count)
        return newsFooterView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
//        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTitleTableCell", for: indexPath) as? NewsTitleTableCell
//            else { return UITableViewCell() }
//
//            cell.configure(text: String(news[indexPath.section].sourceID ?? 0))
//            return cell
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextTableCell") as? NewsTextTableCell
            else { return UITableViewCell() }

            cell.configure(text: news[indexPath.section].text ?? "")
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsPictureTableCell") as? NewsPictureTableCell
            else { return UITableViewCell() }
            
            var photoLink = ""
            if let attachment = news[indexPath.section].attachments?.first {
                if attachment.type == "photo" {
                    photoLink = attachment.photo?.photoSizes.last?.photoURL ?? ""
                } else if attachment.type == "link" {
                    photoLink = attachment.link?.photo?.photoSizes.first?.photoURL ?? ""
                }
            }
            let photo = photoService?.photo(atIndexPath: indexPath, byURL: photoLink)
            cell.config(photo: photo ?? UIImage())
            return cell
        
        default:
            return UITableViewCell()
        }
    }
}
