//
//  DescriptionHotel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class DescriptionHotelCell: UICollectionViewCell {

    static let identifier = "DescriptionHotelCell"
    
    var descriptionText = UITextView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        descriptionText.frame = self.bounds
        descriptionText.font = .systemFont(ofSize: 17)
        
        self.addSubview(descriptionText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
