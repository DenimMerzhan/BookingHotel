//
//  BookingFooter.swift
//  BookingHotel
//
//  Created by Деним Мержан on 10.09.23.
//

import UIKit

class BookingFooter: UICollectionReusableView {

    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
