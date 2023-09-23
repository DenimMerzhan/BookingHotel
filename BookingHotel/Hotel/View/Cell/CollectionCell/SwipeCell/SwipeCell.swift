//
//  SwipeCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 02.09.23.
//

import UIKit
import SkeletonView

class SwipeCell: UICollectionViewCell {

    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.cornerRadius = 10
        image.showAnimatedGradientSkeleton()
    }

}
