//
//  HotelNetworkService.swift
//  BookingHotel
//
//  Created by Деним Мержан on 22.09.23.
//

import Foundation
import UIKit

class HotelNetworkService {
    private init(){}
    
    static func getHotel(completion: @escaping(Hotel) -> ()){
        guard let url = URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3") else {return}
        NetworkService.shared.getData(url: url) { data in
            if let hotel = DecodeJson.decodeJson(data: data, decodingType: Hotel.self) {
                completion(hotel)
            }
        }
    }
    
    static func getImage(urlArr: [URL],completion: @escaping(UIImage,_ imagePosition: Int) -> ()){
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

