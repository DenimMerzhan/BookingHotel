//
//  Touirist.swift
//  BookingHotel
//
//  Created by Деним Мержан on 25.09.23.
//

import Foundation

struct Tourist {
    
    var name: String?
    var family: String?
    var dateOfBirth: String?
    var citizenship: String?
    var numberPassport: String?
    var validityPeriodPassport: String?
    
    var buttonState: ButtonTouiristState
}

enum ButtonTouiristState {
    
    case selected
    case notSelected
    case notTouch
    
}


extension Tourist {
    
    func isTouristEmpty() -> Bool {
        let mirror = Mirror(reflecting: self)
        for (_,value) in mirror.children {
            if let value = value as? String {
                if value.isEmpty ==  false {
                    return false
                }
            }
        }
        return true
    }
}
