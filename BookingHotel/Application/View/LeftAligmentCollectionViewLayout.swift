//
//  Test.swift
//  BookingHotel
//
//  Created by Деним Мержан on 05.09.23.
//

import Foundation
import UIKit

class LeftAligmentCollectionViewLayout: UICollectionViewFlowLayout {
    
    required override init() {super.init(); common()}
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); common()}
    
    private func common() {
        itemSize = itemSize
        minimumLineSpacing = 0
        minimumInteritemSpacing = 10
    }
    
    override func layoutAttributesForElements(
                    in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let att = super.layoutAttributesForElements(in:rect) else {return []}
        var x: CGFloat = sectionInset.left
        var y: CGFloat = -1.0
        
        for a in att {
            if a.representedElementCategory != .cell { continue }
            
            if a.frame.origin.y >= y { x = sectionInset.left }
            a.frame.origin.x = x
            x += a.frame.width + minimumInteritemSpacing
            y = a.frame.maxY
        }
        return att
    }
}
