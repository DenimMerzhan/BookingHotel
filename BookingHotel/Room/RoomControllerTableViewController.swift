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

        var room1 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на бассейн", tagRoom: ["Все включено", "Кондиционер", "Подробнее о номере"])
        var room2 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на кухню", tagRoom: ["Все включено", "Кондиционер", "Подробнее о номере"])
        var room3 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на сад", tagRoom: ["Все включено", "Кондиционер", "Подробнее о номере"])
        roomArr = [room1,room2,room3]
        
        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
    }

}

extension RoomController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        let room = roomArr[indexPath.row]
        cell.imageArr = room.imageArr
        cell.tagArr = room.tagRoom
        cell.descriptionRoom.text = room.description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 500)
    }
    
    
}
