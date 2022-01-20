//
//  NewsTableFooter.swift
//  VK_App
//
//  Created by admin on 20.01.2022.
//

import UIKit

class NewsTableFooter: UITableViewHeaderFooterView {

    @IBOutlet weak var footerLabel: UILabel!
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(text: String) {
        footerLabel.text = text
    }

}
