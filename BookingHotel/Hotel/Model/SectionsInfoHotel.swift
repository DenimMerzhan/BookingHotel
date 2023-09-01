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
    case hotelDescription(HotelDescription)
    case aboutHotel([String])
    case descriptionHotelText(String)
    case moreAboutHotel
    
    
}

struct HotelDescription {
    
    var grade: Int
    var descripitonGrade: String
    var nameHotel: String
    var adressHotel: String
    var price: String
}

