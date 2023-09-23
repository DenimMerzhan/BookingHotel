//
//  RoomSection.swift
//  BookingHotel
//
//  Created by Деним Мержан on 05.09.23.
//

import Foundation
import UIKit


struct Room {
    
    var name: String
    var price: String
    var pricePer: String
    var roomImage : [UIImage?]
    var peculiarities: [String]

    init(name: String, price: String, pricePer: String, peculiarities: [String],roomImage: [UIImage?]) {
        self.name = name
        self.price = price
        self.pricePer = pricePer
        self.peculiarities = peculiarities
        self.roomImage = roomImage
    }
    
}

struct RoomsJson: Decodable {
    var rooms: [RoomJson]
}

struct RoomJson: Decodable {
    
    var id:Int
    var name:String
    var price: Double
    var price_per: String
    var peculiarities: [String]
    var image_urls : [URL]

}


