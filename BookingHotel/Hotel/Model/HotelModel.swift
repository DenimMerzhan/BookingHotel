//
//  HotelModel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 04.09.23.
//

import Foundation
import UIKit


struct HotelModel {
    
    var sections = [SectionsInfoHotel]()
    
    var numberOfsections : Int {
        get {
            return sections.count
        }
    }
    
    func numberOfRowsInsection(section: Int) -> Int {
        switch sections[section] {
        case .moreAboutHotel(let moreAboutHotel):
            return moreAboutHotel.count
        default: return 1
        }
    }
    
    func estimatedHeightForTagCell(widthTableView: CGFloat,withDescription description: String) -> CGFloat { 
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: widthTableView, height: 50))
        label.text = description
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label.sizeThatFits(CGSize(width: widthTableView, height: 50)).height
    }
    
    init() {
        fillSections()
    }
    
    mutating func fillSections() {
        
        var hotellArr = [UIImage?]()
        let hotelImage1 = UIImage(named: "Hotel1")
        let hotelImage2 = UIImage(named: "Hotel2")
        let hotelImage3 = UIImage(named: "Hotel3")
        
        hotellArr.append(hotelImage1)
        hotellArr.append(hotelImage2)
        hotellArr.append(hotelImage3)
        
        let hotelImage = SectionsInfoHotel.hotelImage(hotellArr)
        let hotelDescription = SectionsInfoHotel.description(HotelDescription(grade: 5, descripitonGrade: "5 Превосходно", nameHotel: "Barbaris", adressHotel: "dik My dik"))
        let aboutHotel = SectionsInfoHotel.tagHotel(["kek","Pek","mokkook","dwdwdw","drop menu left"])
        
        let moreAboutHotel = SectionsInfoHotel.moreAboutHotel([.init(description: "Удобства",image: UIImage(named: "FacilitiesMAH")),.init(description: "Что включено",image: UIImage(named: "IncludedMAH")),.init(description: "Что не включено",image: UIImage(named: "NotIncludedMAH"))])
        
        let descrHot = SectionsInfoHotel.detailDescription("dwwdw dw dwdw wdw dw dw d wdw w ddw w dwd wd dwd wdw dw dw dw dw dw dw dw  dw dw dw dw dw wd ddw эй тыы в вывы ")
        
        sections.append(hotelImage)
        sections.append(hotelDescription)
        sections.append(aboutHotel)
        sections.append(descrHot)
        sections.append(moreAboutHotel)
        sections.append(SectionsInfoHotel.selectNumber)
        
    }
    
    func createSeparateView(width: CGFloat) -> UIView {
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 35))
        backView.backgroundColor = UIColor(named: "SeparateCollectionView")
        let whiteView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        whiteView.layer.cornerRadius = 15
        whiteView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        whiteView.backgroundColor = .white
        backView.addSubview(whiteView)
        
        return backView
    }
    
}
