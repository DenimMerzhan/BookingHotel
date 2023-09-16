//
//  ActionCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 16.09.23.
//

import UIKit

class ActionCell: UITableViewCell {

    
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.layer.cornerRadius = 15
        separateView.alpha = 0.2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
