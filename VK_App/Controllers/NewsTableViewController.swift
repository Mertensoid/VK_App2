

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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY - HH:mm"
        return formatter
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //DispatchQueue.global().async {
            self.networkService.fetchNews { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let news):
                    self.news = news
                case .failure(let error):
                    print(error)
                }
            }
        //}
        
        tableView.register(UINib(nibName: "NewsTitleTableCell", bundle: nil), forCellReuseIdentifier: "newsTitleTableCell")
        tableView.register(UINib(nibName: "NewsTextTableCell", bundle: nil), forCellReuseIdentifier: "newsTextTableCell")
        tableView.register(UINib(nibName: "NewsPictureTableCell", bundle: nil), forCellReuseIdentifier: "newsPictureTableCell")
        tableView.register(UINib(nibName: "ManyPicturesTableCell", bundle: nil), forCellReuseIdentifier: "manyPicturesTableCell")
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

//        var authorName = ""
//        var authorPicURL = ""
//        var date = ""
//        var sourceID = 0
//        //DispatchQueue.global().async {
//        if let source = self.news[section].sourceID {
//            sourceID = source
//        }
//            //guard let source = self.news[section].sourceID else { return }
//            if sourceID < 0 {
//                let source = sourceID*(-1)
//                self.networkService.searchGroupByID(id: source) { [weak self] result in
//                    switch result {
//                    case .success(let groups):
//                        print(groups)
//                        if let name = groups.first?.groupName {
//                            authorName = name
//                            print(name)
//                            print(authorName)
//                        }
//                        if let pic = groups.first?.groupPic {
//                            authorPicURL = pic
//                        }
//
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            } else {
//                self.networkService.searchUserByID(userID: sourceID) { [weak self] result in
//                    switch result {
//                    case .success(let users):
//                        if let author = users.first {
//                            authorName = author.surName + " " + author.name
//                        }
//                        if let url = users.first?.friendPhoto {
//                            authorPicURL = url
//                        }
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            }
//            let stringDate = Date(timeIntervalSince1970: TimeInterval(self.news[section].date ?? 0))
//            date = self.dateFormatter.string(from: stringDate)
        //}
        let date = self.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self.news[section].date)))
        print(date)
        print(self.news[section].date)
        
        //let source = networkService.getSource(id: news[section].sourceID ?? 0)
        newsHeaderView.configure(authorName: "Я не знаю как получить автора", authorPicURL: "", dateOfPost: date)

        //newsHeaderView.configure(source: news[section].sourceID!, date: date)
        //let stringDate =
        
        //newsHeaderView.configure(authorPic: UIImage(), authorName: "someAuthor", time: "someTime")

//        if currentNew.attachments.contains(where: {
//            $0?.photo != nil
//        }) {
//
//        }
//        newsHeaderView.configure(new: currentNew)


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
            
            cell.configure(stringURL: photoLink)
            return cell
        
        default:
            return UITableViewCell()
        }

    }
    
    // MARK: - Navigation

}
