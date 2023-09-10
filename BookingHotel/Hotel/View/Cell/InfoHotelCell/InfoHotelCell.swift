//
//  InfoHotelCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class InfoHotelCell: UITableViewCell {


    @IBOutlet weak var addresHotel: UILabel!
    @IBOutlet weak var nameHotel: UILabel!
    @IBOutlet weak var descriptionGrade: UILabel!
    @IBOutlet weak var perfectView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        perfectView.layer.cornerRadius = 10
    }

}
