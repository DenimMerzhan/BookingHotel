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
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var separateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startSetup()
    }
    
    func startSetup(){
        button.layer.cornerRadius = 20
    }
    
    func updateTextlabel(additionalText: String, priceText: String, descriptionText: String){
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 26)]
        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 32)]
        let attrs3 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.gray]

        let attributedString1 = NSMutableAttributedString(string:additionalText, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:priceText, attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string:descriptionText, attributes:attrs3)

        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        
        priceLabel.text = ""
        priceLabel.attributedText = attributedString1
        
        
    }
    
}
