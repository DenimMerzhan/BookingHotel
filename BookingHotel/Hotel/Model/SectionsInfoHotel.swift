//
//  File.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import Foundation
import UIKit


enum SectionsInfoHotel {
    
    case hotelImage([UIImage?])
    case description(HotelDescription)
    case aboutHotel([String])
    case detailDescription(String)
    case moreAboutHotel([MoreAboutHotel])
    
    
}

struct HotelDescription {
    
    var grade: Int
    var descripitonGrade: String
    var nameHotel: String
    var adressHotel: String
    var price: String
}


struct MoreAboutHotel {
    
    var description: String
    var image: UIImage?
    
}
