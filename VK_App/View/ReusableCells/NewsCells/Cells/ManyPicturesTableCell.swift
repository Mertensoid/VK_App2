//
//  ManyPicturesTableCell.swift
//  VK_App
//
//  Created by admin on 06.02.2022.
//

import UIKit

class ManyPicturesTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var newsPicturesCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.newsPicturesCollection.dataSource = self
        self.newsPicturesCollection.delegate = self
        

        
        self.newsPicturesCollection.register(UINib(nibName: "NewsPhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "newsPhotoCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsPicturesCollection.dequeueReusableCell(withReuseIdentifier: "newsPhotoCollectionCell", for: indexPath as IndexPath) as! NewsPhotoCollectionCell
        
        return cell
    }
    
    
}
