//
//  AboutHotelCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class TagCell: UICollectionViewCell {

    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 10
    }

}
