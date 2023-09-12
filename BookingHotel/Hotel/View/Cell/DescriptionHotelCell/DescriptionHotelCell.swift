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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConfig(){
        self.addSubview(descriptionText)
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 15).isActive = true
        descriptionText.topAnchor.constraint(equalTo: self.topAnchor,constant: 15).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15).isActive = true
        descriptionText.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -15).isActive = true
        
        descriptionText.font = .systemFont(ofSize: 17)
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.numberOfLines = 0
        
    }

}
