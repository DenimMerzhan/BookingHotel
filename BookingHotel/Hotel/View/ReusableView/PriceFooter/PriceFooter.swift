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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateTextlabel(textBold: String, textGray: String){
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 28)]
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.gray]

        let attributedString1 = NSMutableAttributedString(string:textBold, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:textGray, attributes:attrs2)

        attributedString1.append(attributedString2)
        priceLabel.text = ""
        priceLabel.attributedText = attributedString1
        
        
    }
    
}
