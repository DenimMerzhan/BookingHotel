//
//  HotelModel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 04.09.23.
//

import Foundation
import UIKit


struct HotelDataModel {
    
    var sections = [SectionsInfoHotel]()
    var hotelImage =  [UIImage?]()
    
    var numberOfsections : Int {
        get {
            return sections.count
        }
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        switch sections[section] {
        case .moreAboutHotel(_):
            return hotelImage.count
        default: return 1
        }
    }
    
    init(hotel: Hotel) {
        fillSections(hotel: hotel)
    }
    
    mutating func fillSections(hotel:Hotel) {
        
        hotel.image_urls.forEach { url in
            self.hotelImage.append(nil)
        }
        
        let hotelImage = SectionsInfoHotel.hotelImage
        let hotelDescription = SectionsInfoHotel.description(HotelDescription(grade: hotel.rating, raitingName: hotel.rating_name, nameHotel: hotel.name, adressHotel: hotel.adress, price: hotel.minimal_price,priceForIt: hotel.price_for_it))
        let aboutHotel = SectionsInfoHotel.tagHotel(hotel.about_the_hotel.peculiarities)
        
        let moreAboutHotel = SectionsInfoHotel.moreAboutHotel([.init(description: "Удобства",image: UIImage(named: "FacilitiesMAH")),.init(description: "Что включено",image: UIImage(named: "IncludedMAH")),.init(description: "Что не включено",image: UIImage(named: "NotIncludedMAH"))])
        
        sections.append(hotelImage)
        sections.append(hotelDescription)
        sections.append(aboutHotel)
        sections.append(SectionsInfoHotel.detailDescription(hotel.about_the_hotel.description))
        sections.append(moreAboutHotel)
        sections.append(SectionsInfoHotel.selectNumber)
        
    }
    
}

