//
//  HotelModel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 04.09.23.
//

import Foundation
import UIKit


struct HotelModel {
    
    static func fillSections() -> [SectionsInfoHotel] {
        
        var sections = [SectionsInfoHotel]()
        
        var hotellArr = [UIImage?]()
        let hotelImage1 = UIImage(named: "Hotel")
        let hotelImage2 = UIImage(named: "bizFWYcxUsk")
        let hotelImage3 = UIImage(named: "photo_5418041419760782066_y")
        
        hotellArr.append(hotelImage1)
        hotellArr.append(hotelImage2)
        hotellArr.append(hotelImage3)
        
        let hotelImage = SectionsInfoHotel.hotelImage(hotellArr)
        let hotelDescription = SectionsInfoHotel.description(HotelDescription(grade: 5, descripitonGrade: "5 Превосходно", nameHotel: "Barbaris", adressHotel: "dik My dik", price: "134 00 00 р"))
        let aboutHotel = SectionsInfoHotel.aboutHotel(["kek","Pek","mokkook","dwdwdw","drop menu left"])
        
        let moreAboutHotel = SectionsInfoHotel.moreAboutHotel([.init(description: "Удобства",image: UIImage(named: "FacilitiesMAH")),.init(description: "Что включено",image: UIImage(named: "IncludedMAH")),.init(description: "Что не включено",image: UIImage(named: "NotIncludedMAH"))])
        
        let descrHot = SectionsInfoHotel.detailDescription("dwwdw dw dwdw wdw dw dw d wdw w ddw w dwd wd dwd wdw dw dw dw dw dw dw dw  dw dw dw dw dw wd ddw")
        
      
        sections.append(hotelImage)
        sections.append(hotelDescription)
        sections.append(aboutHotel)
        sections.append(descrHot)
        sections.append(moreAboutHotel)
        
        return sections
        
    }
    
}
