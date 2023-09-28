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
            if let rooms = DecodeJson.decodeJson(data: data, decodingType: RoomsJson.self) {
                completion(rooms)
            }
        }
    }
    
    static func getImageRoom(urlArr: [URL],completion: @escaping(UIImage,_ imagePosition: Int) -> ()){
        for i in 0...urlArr.count - 1 {
            let url = urlArr[i]
            NetworkService.shared.getData(url: url) { data in
                if let image = UIImage(data: data) {
                    completion(image,i)
                }
            }
        }
    }
    
}
