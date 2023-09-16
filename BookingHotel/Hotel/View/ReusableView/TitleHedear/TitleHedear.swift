//
//  UpFooter.swift
//  BookingHotel
//
//  Created by Деним Мержан on 04.09.23.
//

import Foundation
import UIKit

class TitleHedear: UICollectionReusableView {
    
    
    @IBOutlet weak var downSeparateView: UIView!
    @IBOutlet weak var upSeparateView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
}
