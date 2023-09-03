//
//  InfoHotelCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class InfoHotelCell: UICollectionViewCell {


    @IBOutlet weak var descriptionGrade: UILabel!  
    @IBOutlet weak var perfectView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        perfectView.layer.cornerRadius = 10
    }

}
