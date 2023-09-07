//
//  BookingDetails.swift
//  BookingHotel
//
//  Created by Деним Мержан on 07.09.23.
//

import Foundation


enum BookingInfo {
    
    case bookingDetails([BookingDetails])
    case customerInfo([CustomerInfo])
    case touristData(TouristData)
    
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
