//
//  RoomModel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 05.09.23.
//

import Foundation
import UIKit

struct RoomModel {
    
    var roomArr = [Room]()
    
    var numberOfSections: Int {
        get {return roomArr.count}
    }
    
    var numberOfRowsInSection: Int {
        get {return 1}
    }
    
    init(){
        fillRoomArr()
    }
    
    mutating func fillRoomArr(){
        var room1 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на бассейн", tagRoom: ["Все включено", "Кондиционер","Djn", "Подробнее о номере"])
        var room2 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на кухню", tagRoom: ["Все включено", "Кондиционер", "Подробнее о номере"])
        var room3 = Room(imageArr: [UIImage(named: "Hotel1"),UIImage(named: "Hotel2"),UIImage(named: "Hotel3")], description: "Cтандартный номер с видом на сад", tagRoom: ["Все включено", "Кондиционер", "Подробнее о номере"])
        roomArr = [room1,room2,room3]
    }
    
    func calculateHeightTagCollectionView(tagArr: [String],widthCollectionView: CGFloat,font: UIFont) -> CGFloat? {
        
        let indentTagCollectionView: CGFloat = 15 * 2
        let itemSpacingTagCollection: CGFloat = 10
        let indentTagCell: CGFloat = 10 * 2 /// Отступы от краев ячейки
        let heightTagCell: CGFloat = 45
        
        var sumWidth: CGFloat = 1
        let widthTagCollection = widthCollectionView - indentTagCollectionView
        
        tagArr.forEach { tag in
            var widthTagCell: CGFloat = tag.contentSizeString(font: font).width + itemSpacingTagCollection + indentTagCell /// + spacingTagView
            if tag == tagArr.last {
                widthTagCell += 25
            }
            sumWidth += widthTagCell
        }
        
        let numberOfRows = sumWidth / widthTagCollection
        let heightTagCollection = round(numberOfRows) * heightTagCell
        
        return heightTagCollection
    }
    
}
