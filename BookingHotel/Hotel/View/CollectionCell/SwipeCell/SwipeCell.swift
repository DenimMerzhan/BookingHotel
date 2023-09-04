//
//  SwipeCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 02.09.23.
//

import UIKit

class SwipeCell: UICollectionViewCell {

    
    @IBOutlet weak var photoHotel: UIImageView!
    let label = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.frame = self.bounds
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 25)
        self.addSubview(label)
        // Initialization code
    }

}
