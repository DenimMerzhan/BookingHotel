//
//  RoomModel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 05.09.23.
//

import Foundation
import UIKit

struct RoomModel {
    
    static func calculateHeightTagCollectionView(tagArr: [String],widthCollectionView: CGFloat,font: UIFont) -> CGFloat? {
        
        let indentTagCollectionView: CGFloat = 15 * 2 /// Отступы коллекции от краев ячейки
        let itemSpacingTagCollection: CGFloat = 10
        let indentTagCell: CGFloat = 10 * 2 /// Отступы ячейки коллекции от краев
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
        let heightTagCollection = ceil(numberOfRows) * heightTagCell
        
        return heightTagCollection
    }
    
    static func decodeJsonRoom(data: Data) -> RoomsJson? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(RoomsJson.self, from: data)
            return decodeData
        }catch{
            print("Ошибка декдоирования образца типа Hotel - \(error)")
            return nil
        }
    }
}
