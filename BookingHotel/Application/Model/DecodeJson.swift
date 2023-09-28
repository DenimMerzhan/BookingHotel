//
//  DecodeJson.swift
//  BookingHotel
//
//  Created by Деним Мержан on 28.09.23.
//

import Foundation


struct DecodeJson {
    
    private init(){}
    
    static func decodeJson<T: Decodable>(data: Data,decodingType:T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(T.self, from: data)
            return decodeData
        }catch{
            print("Ошибка декдоирования образца типа \(T.self) - \(error)")
            return nil
        }
    }
    
}
