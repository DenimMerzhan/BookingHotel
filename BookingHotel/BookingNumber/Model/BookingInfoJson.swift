//
//  BookingInfoJson.swift
//  BookingHotel
//
//  Created by Деним Мержан on 25.09.23.
//

import Foundation


struct BookingInfoJson: Decodable {
    
    let id: Int
    let hotel_name: String,hotel_adress: String
    let horating: Int
    let rating_name,departure,arrival_country,tour_date_start,tour_date_stop : String
    let number_of_nights: Int
    let room: String
    let nutrition: String
    
    let tour_price: Double
    let fuel_charge: Double
    let service_charge: Double
    
}
