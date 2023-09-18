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
        guard let email = self else {return false}
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidNumber() -> Bool {
        guard let number = self else {return false}
        if number.count < 18 {
            return false
        }else {return true}
    }
    
    func isValidName() -> Bool {
        guard let name = self else {return false}
        let nameRegax = "[a-zA-Z\\_]{1,35}"
        let namePred = NSPredicate(format: "SELF MATCHES %@",nameRegax )
        return namePred.evaluate(with: name)
    }
    
    func isValidPassword() -> Bool {
        guard let password = self else {return false}
        let passwordRegax = "[0-9\\_]{10,10}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@",passwordRegax )
        return passwordPred.evaluate(with: password)
    }
    
    func isValidDateOfBirth() -> Bool {
        guard let dateOfBirth = self else {return false}
        let dateOfBirthRegax = "[0-9]{2}+.[0-9]{2}.[0-9]{4}"
        let dateOfBirthPred = NSPredicate(format: "SELF MATCHES %@",dateOfBirthRegax )
        return dateOfBirthPred.evaluate(with: dateOfBirth)
    }
    
    
    
}
