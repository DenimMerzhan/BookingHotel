//
//  BookingNetworkService.swift
//  BookingHotel
//
//  Created by Деним Мержан on 25.09.23.
//

import Foundation

class BookingNetworkService {
    
    static func getBookingInfo(completion: @escaping (_ bookingInfoJson: BookingInfoJson) -> ()){
        guard let url = URL(string: "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8") else {return}
        NetworkService.shared.getData(url: url) { data in
            if let bookingInfoJson = BookingModel.decodeJson(data: data) {
                completion(bookingInfoJson)
            }
        }
    }
}
