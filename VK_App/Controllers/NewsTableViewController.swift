

import UIKit
import Kingfisher

class NewsTableViewController: UITableViewController {

    private let headerHeight: CGFloat = 74
    private let footerHeight: CGFloat = 40
    private let networkService = NetworkService()
    private var sources: [(String, String)] = []
    private var news: [NewsData] = []
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    private var photoService: PhotoService?
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY - HH:mm"
        return formatter
    }()
    private var nextFrom = ""
    private var isLoading = false
    enum typeOfCell {
        case titleCell
        case textCell
        case pictureCell
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService = PhotoService(container: tableView)

        tableView.prefetchDataSource = self
        
        registerCells()
        setupRefreshControl()
        loadNews()
    }

    // MARK: - Private methods
    
    fileprivate func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl?.tintColor = .green
        refreshControl?.addTarget(
            self,
            action: #selector(refreshNews),
            for: .valueChanged)
    }
    
    fileprivate func loadNews() {
        self.refreshControl?.beginRefreshing()
        self.networkService.fetchNews() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.news = news.items
                self.nextFrom = news.nextFrom
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func registerCells() {
        tableView.register(UINib(nibName: "NewsTitleTableCell", bundle: nil), forCellReuseIdentifier: "newsTitleTableCell")
        tableView.register(UINib(nibName: "NewsTextTableCell", bundle: nil), forCellReuseIdentifier: "newsTextTableCell")
        tableView.register(UINib(nibName: "NewsPictureTableCell", bundle: nil), forCellReuseIdentifier: "newsPictureTableCell")
        tableView.register(UINib(nibName: "NewsTableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "newsTableHeader")
        tableView.register(UINib(nibName: "NewsTableFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "newsTableFooter")
    }
    
    @objc func refreshNews() {
        self.refreshControl?.beginRefreshing()
        let freshNewsDate = self.news.first?.date ?? Date().timeIntervalSince1970
        self.networkService.fetchNews(startTime: freshNewsDate + 1) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
            }
            switch result {
            case .success(let news):
                guard news.items.count > 0 else { return }
                self.news = news.items + self.news
                self.nextFrom = news.nextFrom
                let indexSet = IndexSet(integersIn: 0..<news.items.count)
                DispatchQueue.main.async {
                    self.tableView.insertSections(indexSet, with: .automatic)
                }
            case .failure(let error):
                print(error)
            }
        }
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
        return headerHeight
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
        return footerHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            let tableWidth = tableView.bounds.width
            let new = self.news[indexPath.section]
            if let aspectRatio = new.attachments?.first?.photo?.photoSizes[0].aspectRatio {
                let tableHeight = tableWidth * aspectRatio
                return tableHeight
            } else {
                return UITableView.automaticDimension
            }
        default:
            return UITableView.automaticDimension
        }
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

// MARK: - Prefetching data source extension
extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        if maxSection > news.count - 3,
           !isLoading {
            isLoading = true
            networkService.fetchNews(startFrom: self.nextFrom) { result in
                switch result {
                case .success(let news):
                    guard news.items.count > 0 else { return }
                    let indexSet = IndexSet(integersIn: self.news.count ..< self.news.count + news.items.count)
                    self.news.append(contentsOf: news.items)
                    DispatchQueue.main.async {
                        self.tableView.insertSections(indexSet, with: .automatic)
                    }
                    self.nextFrom = news.nextFrom
                    self.isLoading = false
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    
}
