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
        let heightTagetCell: CGFloat = 45
        
        
        let tagArr = tagArr
        
        var countRow: CGFloat = 1
        var widthTagCollection = widthCollectionView - indentTagCollectionView
        var i = 0
        
        while i <= tagArr.count - 1 {
            
            let tag = tagArr[i]
            var widthTagCell: CGFloat = tag.contentSizeString(font: font).width + itemSpacingTagCollection + indentTagCell /// + spacingTagView
            if i == tagArr.count - 1 {widthTagCell += 25} /// На последнем теге есть кнопка у которой ширина = 20
            print(widthTagCell)
            widthTagCollection -= widthTagCell
            if widthTagCollection < 0 {
                countRow += 1
                widthTagCollection = widthCollectionView - indentTagCollectionView
                i -= 1
            }
            if i < 0 {
                return nil
            }
            i += 1
        }
        
        let heightCollectionView = countRow * heightTagetCell
        
        return heightCollectionView
    }
    
}




