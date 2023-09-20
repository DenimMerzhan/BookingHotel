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
    case tourist(Tourist)
    case result([BookingDetails])
    case pay
    
    func getState() -> ButtonTouiristState? {
        switch self {
        case .tourist(let touristData):
            return touristData.buttonState
        default: return nil
        }
    }
    
    mutating func changeSelectedState(){
        
        switch self {
        case .tourist(var touristData):
            switch touristData.buttonState {
            case .selected:
                touristData.buttonState = .notSelected
                self = .tourist(touristData)
            default:
                touristData.buttonState = .selected
                self = .tourist(touristData)
            }
        default: break
        }
    }
    
    mutating func changeTouristData(newValue:String?,row:Int){
        
        switch self {
        case .tourist(var touristData):
            switch row {
            case 0: touristData.name = newValue
                self = .tourist(touristData)
            case 1: touristData.family = newValue
                self = .tourist(touristData)
            case 2: touristData.dateOfBirth = newValue
                self = .tourist(touristData)
            case 3: touristData.citizenship = newValue
                self = .tourist(touristData)
            case 4: touristData.numberPassport = newValue
                self = .tourist(touristData)
            default: touristData.validityPeriodPassport = newValue
                self = .tourist(touristData)
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
