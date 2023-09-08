//
//  BookingDetails.swift
//  BookingHotel
//
//  Created by Деним Мержан on 07.09.23.
//

import Foundation


enum BookingInfo {
    
    case bookingDetails([BookingDetails])
    case customerInfo
    case touristData(stateButton)
    
    mutating func changeSelectedState(){
        switch self {
        case .touristData(let state):
            switch state {
            case .selected:
                self = .touristData(.notSelected)
            case .notSelected:
                self = .touristData(.selected)
            case .notTouch:
                self = .touristData(.selected)
            }
        default: break
        }
    }
    
    func getState() -> stateButton? {
        switch self {
        case .touristData(let state): return state
        default: return nil
        }
    }
    
}


enum stateButton {
    
    case selected
    case notSelected
    case notTouch
}

struct BookingDetails {
    
    var deatails: String
    var descripiton: String
    
}

enum CustomerInfo {
    
    case phoneNumber(String)
    case email(String)
    
}

struct TouristData {
    
    var name: String
    var family: String
    var dateOfBirth: String
    var citizenship: String
    var numberPassport: String
    var validityPeriodPassport: String
    
}
