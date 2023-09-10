//
//  TagCollectionCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 10.09.23.
//

import UIKit

class TagCollectionCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var tagArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension TagCollectionCell: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        cell.descriptionText.text = tagArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let tag = tagArr[indexPath.row]
            return CGSize(width: tag.contentSizeString().width, height: 45)
    }
    
    
}
