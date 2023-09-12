//
//  MoreAboutHotelCollectionViewCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class MoreAboutHotelCell: UITableViewCell {

    
    
    @IBOutlet weak var imageDescription: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var separateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separateView.alpha = 0.2
    }

}
