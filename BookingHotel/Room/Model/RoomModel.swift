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
        
        let indentTagCollectionView: CGFloat = 15 * 2
        let itemSpacingTagCollection: CGFloat = 10
//        let indentTagCell: CGFloat = 10 * 2
//        let spacinStackViewTagCell: CGFloat = 10
        let heighTargetCell: CGFloat = 45

       
        let tagArr = tagArr
        
        var countRow: CGFloat = 1
        var widthTagCollection = widthCollectionView - indentTagCollectionView
        var i = 0
        
        while i <= tagArr.count - 1 {
            
            let tag = tagArr[i]
            var widthTagCell: CGFloat = tag.contentSizeString(font: font).width + itemSpacingTagCollection /// + spacingTagView
            if i == tagArr.count - 1 {widthTagCell += 20} /// На последнем теге есть кнопка у которой ширина = 20
            
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
        
        let heightCollectionView = countRow * heighTargetCell
        
        return heightCollectionView
    }
    
}




