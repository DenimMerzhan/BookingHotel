//
//  InfoUserCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 07.09.23.
//

import UIKit

class InfoTouirist: UITableViewCell {

    
    @IBOutlet weak var upPlaceHolder: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
        textField.borderStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
