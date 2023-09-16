//
//  BookingDetails.swift
//  BookingHotel
//
//  Created by Деним Мержан on 07.09.23.
//

import Foundation


enum BookingInfo {
    
    case aboutHotel(HotelDescription)
    case bookingDetails([BookingDetails])
    case customerInfo(CustomerInfo)
    case touristData(TouristData)
    case result([BookingDetails])
    
    func getState() -> ButtonTouiristState? {
        switch self {
        case .touristData(let touristData):
            return touristData.buttonState
        default: return nil
        }
    }
    
    mutating func changeSelectedState(){
        
        switch self {
        case .touristData(var touristData):
            switch touristData.buttonState {
            case .selected:
                touristData.buttonState = .notSelected
                self = .touristData(touristData)
            default:
                touristData.buttonState = .selected
                self = .touristData(touristData)
            }
        default: break
        }
    }
    
    mutating func changeTouristData(newValue:String?,row:Int){
        
        switch self {
        case .touristData(var touristData):
            switch row {
            case 0: touristData.name = newValue
                self = .touristData(touristData)
            case 1: touristData.family = newValue
                self = .touristData(touristData)
            case 2: touristData.dateOfBirth = newValue
                self = .touristData(touristData)
            case 3: touristData.citizenship = newValue
                self = .touristData(touristData)
            case 4: touristData.numberPassport = newValue
                self = .touristData(touristData)
            default: touristData.validityPeriodPassport = newValue
                self = .touristData(touristData)
            }
        default: break
        }
    }
    
    mutating func changeCustomerInfoData(newValue:String?,row:Int){
        switch self {
        case.customerInfo(var customerInfo):
            if row == 0 {
                customerInfo.phoneNumber = newValue
            }else {
                customerInfo.email = newValue
            }
            self = .customerInfo(customerInfo)
        default:break
        }
    }
    
}

struct BookingDetails {
    
    var deatails: String?
    var descripiton: String?
    
}

struct CustomerInfo {
    
    var phoneNumber: String?
    var email: String?
    
}

struct TouristData {
    
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
