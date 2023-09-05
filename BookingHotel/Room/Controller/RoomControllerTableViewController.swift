//
//  RoomControllerTableViewController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 05.09.23.
//

import UIKit

class RoomController: UICollectionViewController {

    var roomArr = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var room1 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на бассейн", tagRoom: ["Все включено", "Кондиционер","Djn", "Подробнее о номере"])
        var room2 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на кухню", tagRoom: ["Все включено", "Кондиционер", "Подробнее о номере"])
        var room3 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на сад", tagRoom: ["Все включено", "Кондиционер", "Подробнее о номере"])
        roomArr = [room1,room2,room3]
        
        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        collectionView.register(UINib(nibName: "PriceFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter")
        
    }

}

extension RoomController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return roomArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        let room = roomArr[indexPath.section]
        cell.room = room
        cell.layer.cornerRadius = 15
        cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let room = roomArr[indexPath.section]
        if let height =  RoomModel.calculateHeightTagCollectionView(tagArr: room.tagRoom, widthCollectionView: collectionView.frame.width) {
            return CGSize(width: collectionView.frame.width, height: height + 310 + 70) /// 270 высота pageCollection 70 высота лейбла
        }
        return CGSize(width: collectionView.frame.width, height: 500)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return UICollectionReusableView()
        }else {
            let priceFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter", for: indexPath) as! PriceFooter
            priceFooter.updateTextlabel(additionalText: "", priceText: "186 000р ", descriptionText: "За 7 ночей с перелетом")
            return priceFooter
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
}
