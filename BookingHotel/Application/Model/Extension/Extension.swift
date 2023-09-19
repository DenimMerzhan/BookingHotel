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
    
    mutating func deleteSpacesAtTheEnd() {
        let pattern = "\\s+$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(self.startIndex..., in: self)
        let trimmed = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        self = trimmed
    }
}


extension String? {
    
    func isValidEmail() -> Bool {
        guard var email = self else {return false}
        email.deleteSpacesAtTheEnd()
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidNumber() -> Bool {
        guard var number = self else {return false}
        if number.count < 18 {
            return false
        }else {return true}
    }
    
    func isValidName() -> Bool {
        guard var name = self else {return false}
        name.deleteSpacesAtTheEnd()
        let nameRegax = "[а-яА-Я]{1,35}"
        let namePred = NSPredicate(format: "SELF MATCHES %@",nameRegax )
        return namePred.evaluate(with: name)
    }
    
    func isValidPassport() -> Bool {
        guard var password = self else {return false}
        password.deleteSpacesAtTheEnd()
        let passwordRegax = "[0-9]{10,10}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@",passwordRegax )
        return passwordPred.evaluate(with: password)
    }
    
    func isValidDateOfBirth() -> Bool {
        guard var dateOfBirth = self else {return false}
        dateOfBirth.deleteSpacesAtTheEnd()
        let dateOfBirthRegax = "[0-9]{2}+.[0-9]{2}.[0-9]{4}"
        let dateOfBirthPred = NSPredicate(format: "SELF MATCHES %@",dateOfBirthRegax )
        return dateOfBirthPred.evaluate(with: dateOfBirth)
    }
    
    
}
