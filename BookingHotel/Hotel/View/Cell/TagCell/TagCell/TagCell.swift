//
//  Tag.swift
//  BookingHotel
//
//  Created by Деним Мержан on 10.09.23.
//

import UIKit

class TagCell: UICollectionViewCell {

    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.isHidden = true
        backView.layer.cornerRadius = 10
        descriptionText.minimumScaleFactor = 0.5
        descriptionText.adjustsFontSizeToFitWidth = true
    }
    
    override func prepareForReuse() {
        button.isHidden = true
        descriptionText.textColor = K.color.tintTextTagColor
        backView.backgroundColor =  K.color.separateColor
    }

}
