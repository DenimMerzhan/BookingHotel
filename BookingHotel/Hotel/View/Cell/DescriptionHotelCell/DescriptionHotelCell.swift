//
//  DescriptionHotel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class DescriptionHotelCell: UITableViewCell {

    static let identifier = "DescriptionHotelCell"
    
    var descriptionText = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConfig()
    }
    

    func setupConfig(){
        self.addSubview(descriptionText)
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        descriptionText.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        descriptionText.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        descriptionText.font = .systemFont(ofSize: 17)
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.numberOfLines = 0
        
    }
    
    

}
