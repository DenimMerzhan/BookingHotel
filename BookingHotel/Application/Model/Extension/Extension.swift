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


extension String? {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard let email = self else {return false}
        return emailPred.evaluate(with: email)
    }
    
    func isValidNumber() -> Bool {
        guard let number = self else {return false}
        if number.count < 18 {
            return false
        }else {return true}
    }
}
