//
//  HotelModel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 04.09.23.
//

import Foundation
import UIKit


struct HotelModel {
    
    static let shared = HotelModel()
    private init() {}
    
    func estimatedHeightForTagCell(widthTableView: CGFloat,withDescription description: String) -> CGFloat { 
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: widthTableView, height: 50))
        label.text = description
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label.sizeThatFits(CGSize(width: widthTableView, height: 50)).height
    }
    
    func createSeparateView(width: CGFloat) -> UIView {
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 35))
        backView.backgroundColor = UIColor(named: "SeparateCollectionView")
        let whiteView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        whiteView.layer.cornerRadius = 15
        whiteView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        whiteView.backgroundColor = .white
        backView.addSubview(whiteView)
        
        return backView
    }
    
    func decodeJson(data: Data) -> Hotel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(Hotel.self, from: data)
            return decodeData
        }catch{
            print("Ошибка декдоирования образца типа Hotel - \(error)")
            return nil
        }
    }
    
}
