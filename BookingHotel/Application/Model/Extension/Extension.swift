//
//  Extansion.swift
//  BookingHotel
//
//  Created by Деним Мержан on 05.09.23.
//

import Foundation
import UIKit


extension String {
    
    func contentSizeString(font: UIFont) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        label.text = self
        label.font = font
        return label.intrinsicContentSize
    }
    
}
