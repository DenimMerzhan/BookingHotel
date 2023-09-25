//
//  BookingInfoJson.swift
//  BookingHotel
//
//  Created by Деним Мержан on 25.09.23.
//

import Foundation


struct BookingInfoJson: Decodable {
    
    let id: String, hotelName: String,hotelAdress: String
    let hotelRaiting: Int
    let raitingName,departure,avvivalCountry,tourDateStart,tourDateStop : String
    let numberOfNights: Int
    let roomDescription: String
    let nutrition: String
    
    let tourPrice: Double
    let fuelCharge: Double
    let serviceCharge: Double
    
}
