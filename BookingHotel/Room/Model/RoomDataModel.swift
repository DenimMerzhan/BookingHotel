//
//  RoomModel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 05.09.23.
//

import Foundation
import UIKit

struct RoomDataModel {
    
    var roomArr = [Room]()
    
    var numberOfSections: Int {
        get {return roomArr.count}
    }
    
    var numberOfRowsInSection: Int {
        get {return 1}
    }
    
    init(roomsJson: RoomsJson){
        fillRoomArr(roomsJson: roomsJson)
    }
    
    mutating func fillRoomArr(roomsJson: RoomsJson){
        roomsJson.rooms.forEach { roomJson in
            var roomImage = [UIImage?]()
            roomJson.image_urls.forEach { url in
                roomImage.append(nil)
            }
            let room = Room(name: roomJson.name, price: roomJson.price, pricePer: roomJson.price_per, peculiarities: roomJson.peculiarities,roomImage: roomImage)
            self.roomArr.append(room)
        }
    }
}

