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
    

    func updatePriceFooterText(additionalText: String, price: Double, descriptionText: String) -> NSMutableAttributedString {
        
        let price = String(Int(price))
        var newPriceText = formatPriceLabelText(text: price)
        newPriceText += " ₽"
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26)]
        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)]
        let attrs3 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.gray]

        let attributedString1 = NSMutableAttributedString(string:additionalText, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:newPriceText, attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string:descriptionText, attributes:attrs3)

        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        
        return attributedString1
        
    }
    
    private func formatPriceLabelText(text: String) -> String {
        var text = text
        switch text.count {
        case 4: text.insert(" ", at: text.index(text.startIndex, offsetBy: 1))
        case 5: text.insert(" ", at: text.index(text.startIndex, offsetBy: 2))
        case 6: text.insert(" ", at: text.index(text.startIndex, offsetBy: 3))
        case 7: text.insert(" ", at: text.index(after: text.startIndex))
            text.insert(" ", at: text.index(text.endIndex, offsetBy: -3))
        default: break
        }
        return text
    }
    
}
