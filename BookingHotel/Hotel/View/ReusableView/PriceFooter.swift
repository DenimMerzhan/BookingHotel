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
        setupConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConfig(){
        self.addSubview(priceLabel)
        priceLabel.frame = CGRect(x: self.frame.origin.x + 10, y: 0, width: self.frame.width - 25, height: self.frame.height)
        priceLabel.numberOfLines = 2
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.font = UIFont(name: "Helvetica Neue Medium", size: 33)
        priceLabel.tintColor = .black
        priceLabel.text = "dwdw dwd wddw wd wd"
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    
    
}
