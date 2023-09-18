//
//  BookingDetailesCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 06.09.23.
//

import UIKit

class BookingDetailesCell: UITableViewCell {

    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var descriptionDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionDetails.textColor = .black
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
