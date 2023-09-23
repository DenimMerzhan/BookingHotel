//
//  RoomNetworkService.swift
//  BookingHotel
//
//  Created by Деним Мержан on 23.09.23.
//

import Foundation
import UIKit


struct RoomNetworkService {
    
    static func funcGetDataRoom(completion: @escaping(RoomsJson) -> ()){
        guard let url = URL(string: "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd") else {return}
        NetworkService.shared.getData(url: url) { data in
            if let rooms = RoomModel.decodeJsonRoom(data: data) {
                completion(rooms)
            }
        }
    }
    
    static func getImageRoom(rooms: RoomsJson,completion: @escaping(UIImage,_ roomPostition: Int,_ imagePosition: Int) -> ()){
        
        for i in 0...rooms.rooms.count - 1{
            let urlArr = rooms.rooms[i].image_urls
            NetworkService.shared.getImageRoom(urlArr: urlArr) { image, imagePosition in
                completion(image,i,imagePosition)
            }
        }
    }
}
