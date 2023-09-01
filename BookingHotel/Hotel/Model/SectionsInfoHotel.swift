//
//  File.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import Foundation
import UIKit


enum SectionsInfoHotel {
    
    case hotel(Hotel)
    case aboutHotel(AboutHotel)
    
}

struct AboutHotel {
    
    var aboutHotel: [String]
    var descriptionText: String
    var moreAboutHotel: [String]
}

struct Hotel {
    
    var imageArr: [UIImage?]
    
    var grade: Int
    var descripitonGrade: String
    var nameHotel: String
    var adressHotel: String
    var price: String
    
    
}

