//
//  NonSelectedCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 20.09.23.
//

import UIKit

class NoneSelectedCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
