//
//  Hotel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 22.09.23.
//

import Foundation
import UIKit


struct Hotel: Decodable {
    
    var id: Int
    var name: String
    var adress: String
    var minimal_price: Double
    var price_for_it: String
    var rating: Int
    var rating_name: String
    
    var image_urls: [URL]
    var about_the_hotel: AboutTheHotel
    
}

struct AboutTheHotel: Decodable {
    var description: String
    var peculiarities: [String]
}
