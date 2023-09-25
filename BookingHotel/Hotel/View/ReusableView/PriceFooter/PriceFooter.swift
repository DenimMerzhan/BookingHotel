//
//  CollectionReusableView.swift
//  BookingHotel
//
//  Created by Деним Мержан on 03.09.23.
//

import UIKit

class PriceFooter: UICollectionReusableView {
  
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.layer.cornerRadius = 20
    }
    
}
