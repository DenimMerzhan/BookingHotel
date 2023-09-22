//
//  NetworkService.swift
//  BookingHotel
//
//  Created by Деним Мержан on 22.09.23.
//

import Foundation


class NetworkService {
    
    private init(){}
    static let shared = NetworkService()
    
    func getData(url:URL,completion:@escaping (Data?) -> ()){
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, err in
            guard let data = data else {return}
            DispatchQueue.main.async {
                completion(data)
            }
            if let error = err {
                print("Ошибка получения данных с сервера - \(error)")
            }
        }.resume()
    }
    
}
