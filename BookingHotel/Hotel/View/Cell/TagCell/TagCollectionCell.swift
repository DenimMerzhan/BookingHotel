//
//  TagCollectionCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 10.09.23.
//

import UIKit

class TagCollectionCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var tagArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
    }
    
    override func prepareForReuse() {
        collectionView.reloadData()
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
        cell.button.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tagArr[indexPath.row]
        var cellWidth = tag.contentSizeString(font: K.font.tagCell).width + 20
        if cellWidth > collectionView.frame.width {
            cellWidth = collectionView.frame.width
        }
        return CGSize(width: cellWidth, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
