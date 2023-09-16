//
//  RoomControllerTableViewController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 05.09.23.
//

import UIKit

class RoomController: UICollectionViewController {

    var roomArr = [Room]()
    var currentIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInsetAdjustmentBehavior = .never

        var room1 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на бассейн", tagRoom: ["Все включено", "Кондиционер","Djn", "Подробнее о номере"])
        var room2 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на кухню", tagRoom: ["Все включено", "Кондиционер", "Подробнее о номере"])
        var room3 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на сад", tagRoom: ["Все включено", "Кондиционер", "Подробнее о номере"])
        roomArr = [room1,room2,room3]
        
       
        collectionView.register(UINib(nibName: "RoomCell", bundle: nil), forCellWithReuseIdentifier: "RoomCell")
        collectionView.register(UINib(nibName: "PriceFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter")
        collectionView.register(UINib(nibName: "TitleHedear", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHedear")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destanationVC = segue.destination as? BookingController else {return}
        destanationVC.indexPath =  currentIndexPath
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as! RoomCell
        let room = roomArr[indexPath.section]
        cell.room = room
        cell.layer.cornerRadius = 15
        cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let room = roomArr[indexPath.section]
        if let height =  RoomModel.calculateHeightTagCollectionView(tagArr: room.tagRoom, widthCollectionView: collectionView.frame.width,font: .systemFont(ofSize: 18, weight: .medium)) {
            return CGSize(width: collectionView.frame.width, height: height + 300 + 70 + 20) /// 300 высота pageCollection 70 высота лейбла, 20 отступ от верха
        }
        return CGSize(width: collectionView.frame.width, height: 500)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let titleHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHedear", for: indexPath) as! TitleHedear
            titleHeader.upSeparateView.isHidden = true
            titleHeader.label.text = "Steigreheber Mainksols"
            let action = UIAction { [weak self] action in
                self?.dismiss(animated: true)
            }
            titleHeader.backButton.addAction(action, for: .touchUpInside)
            return titleHeader
        }else {
            let priceFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter", for: indexPath) as! PriceFooter
            priceFooter.updateTextlabel(additionalText: "", priceText: "186 000р ", descriptionText: "За 7 ночей с перелетом")
            priceFooter.indexPath = indexPath
            let buttonAction = UIAction { [weak self] action in
                self?.currentIndexPath = indexPath
                self?.performSegue(withIdentifier: "roomToBooking", sender: self)
            }
            priceFooter.button.addAction(buttonAction, for: .touchUpInside)
            priceFooter.backgroundView.layer.cornerRadius = 15
            priceFooter.backgroundView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            return priceFooter
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 120)
        }else {
            return .zero
        }
    }
    
}
