//
//  ViewController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class HotelController: UICollectionViewController {
    
    var sections = [SectionsInfoHotel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        var hotel = SectionsInfoHotel.hotel([Hotel.imageArr(<#T##[UIImage?]#>)])
//        var imageArr = SectionsInfoHotel.hotel(.imageArr([UIImage(named: "Hotel")]))
//        var hotelDescripiton = SectionsInfoHotel.hotel(.hotelDescription(HotelDescription(grade: 5, descripitonGrade: "dwdwd", nameHotel: "dwwd", adressHotel: "dwwd", price: "dwddw")))
//        var aboutHotel = SectionsInfoHotel.aboutHotel(.aboutHotel(["dwddw","wddw"]))
//        var descriptionText = SectionsInfoHotel.aboutHotel(.descriptionText("dwwddwdw"))
//        var moreAboutHotel = SectionsInfoHotel.aboutHotel(.moreAboutHotel(["dwwd","wddw"]))
//
//        sections.append(imageArr)
//        sections.append(hotelDescripiton)
//        sections.append(aboutHotel)
//        sections.append(descriptionText)
//        sections.append(moreAboutHotel)
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    
    
}


extension HotelController {
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
            
        case .hotel(let hotel):
            return hotel.imageArr.count - 1 + 1
        case .aboutHotel(let aboutHotel):
            return aboutHotel.aboutHotel.count - 1 + 1 + aboutHotel.moreAboutHotel.count - 1
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
            
        case .hotel(let hotel):
            
            if indexPath.row < hotel.imageArr.count - 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipePhotoCell", for: indexPath) as! SwipePhotoCell
                return cell
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoHotelCell", for: indexPath) as! InfoHotelCell
                return cell
            }
            
        case .aboutHotel(let aboutHotel):
            
            if indexPath.row < aboutHotel.aboutHotel.count - 1 {
                
            }else if indexPath.row == aboutHotel.aboutHotel.count {
                
            }else {
                
            }
        }
    }
    
}

extension HotelController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        
        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
            
            let sections = self.sections[sectionNumber]
            
            
            switch sections {
                
            case .hotel(_):
                
                let photoItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)))
                let descriptionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)))
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalWidth(1))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [photoItem,descriptionItem])
                group.interItemSpacing = .fixed(10)
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
                
            case .aboutHotel(_):
                
                let aboutHotelItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(50)))
                
                let hotelDescriptionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150)))
                
                let moreAboutHotel = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90)))
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalWidth(1))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [aboutHotelItem,hotelDescriptionItem,moreAboutHotel])
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
                
            }
            
            
        }
        return layout
    }
    
}


