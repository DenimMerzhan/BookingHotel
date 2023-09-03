//
//  CollectionReusableView.swift
//  BookingHotel
//
//  Created by Деним Мержан on 03.09.23.
//

import UIKit

class PriceFooter: UICollectionReusableView {
        
    static let identifier = "PriceFooter"
    var priceLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConfig(){
        self.addSubview(priceLabel)
        priceLabel.frame = self.bounds
        priceLabel.font = UIFont(name: "Helvetica Neue Medium", size: 33)
        priceLabel.tintColor = .black
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    
    
}
