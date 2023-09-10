//
//  MoreAboutHotelCollectionViewCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class MoreAboutHotelCell: UITableViewCell {

    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var imageDescription: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorView.alpha = 0.2
    }

}
