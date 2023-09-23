//
//  SwipeCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 02.09.23.
//

import UIKit
import SkeletonView

class SwipeCell: UICollectionViewCell {

    
    @IBOutlet weak var photoHotel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoHotel.layer.cornerRadius = 10
        photoHotel.showAnimatedGradientSkeleton()
    }

}
