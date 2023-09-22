//
//  HotelNetworkService.swift
//  BookingHotel
//
//  Created by Деним Мержан on 22.09.23.
//

import Foundation

class HotelNetworkService {
    private init(){}
    
    static func getHotel(completion: @escaping(Hotel) -> ()){
        guard let url = URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3") else {return}
        NetworkService.shared.getData(url: url) { data in
            if let data = data {
                if let hotel = HotelModel.shared.decodeJson(data: data) {
                    completion(hotel)
                }
            }
        }
    }
}
