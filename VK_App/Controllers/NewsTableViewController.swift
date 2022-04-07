

import UIKit

class NewsTableViewController: UITableViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(NewsTableHeader.self, forHeaderFooterViewReuseIdentifier: "newsTableHeader")
        tableView.register(UINib(nibName: "NewsTitleTableCell", bundle: nil), forCellReuseIdentifier: "newsTitleTableCell")
        tableView.register(UINib(nibName: "NewsTextTableCell", bundle: nil), forCellReuseIdentifier: "newsTextTableCell")
        tableView.register(UINib(nibName: "NewsPictureTableCell", bundle: nil), forCellReuseIdentifier: "newsPictureTableCell")
        tableView.register(UINib(nibName: "ManyPicturesTableCell", bundle: nil), forCellReuseIdentifier: "manyPicturesTableCell")
        tableView.register(NewsTableFooter.self, forHeaderFooterViewReuseIdentifier: "newsTableFooter")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let newsHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "newsTableHeader") as? NewsTableHeader
        else { return UIView() }
        
        newsHeaderView.configure(authorPic: news[section].authorPicture ?? UIImage(), authorName: news[section].author, time: news[section].postTime)
        return newsHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 74
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let newsFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "newsTableFooter") as? NewsTableFooter
        else { return UIView() }
        newsFooterView.configLikeView(
            count: 65,
            image: UIImage(systemName: "heart") ?? UIImage())
        newsFooterView.configCommentView(
            count: 145,
            image: UIImage(systemName: "text.bubble") ?? UIImage())
        newsFooterView.configRepostView(
            count: 3,
            image: UIImage(systemName: "arrowshape.turn.up.right") ?? UIImage())
        return newsFooterView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTitleTableCell", for: indexPath) as? NewsTitleTableCell
            else { return UITableViewCell() }
            
            cell.configure(text: news[indexPath.section].title)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsPictureTableCell") as? NewsPictureTableCell
            else { return UITableViewCell() }
            cell.configure(image: news[indexPath.section].picture ?? UIImage())
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextTableCell") as? NewsTextTableCell
            else { return UITableViewCell() }

            cell.configure(text: news[indexPath.section].newsText)
            return cell
        default:
            return UITableViewCell()
        }

    }
    
    // MARK: - Navigation

}
