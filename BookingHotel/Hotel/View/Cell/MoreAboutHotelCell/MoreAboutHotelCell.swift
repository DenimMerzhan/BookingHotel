//
//  MoreAboutHotelCollectionViewCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class MoreAboutHotelCell: UICollectionViewCell {

    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorView.alpha = 0.2
    }

}
