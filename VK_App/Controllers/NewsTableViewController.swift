

import UIKit

class NewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(NewsTableHeader.self, forHeaderFooterViewReuseIdentifier: "newsTableHeader")
        tableView.register(UINib(nibName: "NewsTitleTableCell", bundle: nil), forCellReuseIdentifier: "newsTitleTableCell")
        tableView.register(UINib(nibName: "NewsTextTableCell", bundle: nil), forCellReuseIdentifier: "newsTextTableCell")
        tableView.register(UINib(nibName: "NewsPictureTableCell", bundle: nil), forCellReuseIdentifier: "newsPictureTableCell")
        //tableView.clipsToBounds = false
        tableView.register(UINib(nibName: "NewsTableFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "newsTableFooter")
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
        
        newsFooterView.configure(text: "Возможно, здесь будет рабочий футер, но не сегодня...")
        return newsFooterView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
