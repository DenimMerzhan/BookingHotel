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
    var price: Double
    var pricePer: String
    var roomImage : [UIImage?]
    var peculiarities: [String]

    var fuelCharge: Double {
        get {
            return price * 0.03
        }
    }
    
    var serviceCharge: Double {
        get {
            return price * 0.07
        }
    }
    
    init(name: String, price: Double, pricePer: String, peculiarities: [String],roomImage: [UIImage?]) {
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


