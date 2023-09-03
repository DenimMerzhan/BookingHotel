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
        
        var hotellArr = [UIImage?]()
        let hotelImage1 = UIImage(named: "Hotel")
        let hotelImage2 = UIImage(named: "Hotel")
        hotellArr.append(hotelImage1)
        hotellArr.append(hotelImage2)
        
        let hotelImage = SectionsInfoHotel.hotelImage(hotellArr)
        let hotelDescription = SectionsInfoHotel.hotelDescription(HotelDescription(grade: 5, descripitonGrade: "5 Превосходно", nameHotel: "Barbaris", adressHotel: "dik My dik", price: "134 00 00 р"))
        let aboutHotel = SectionsInfoHotel.aboutHotel(["kek","Pek","mokkook","dwdwdw","drop menu left"])
        let moreAboutHotel = SectionsInfoHotel.moreAboutHotel
        let descrHot = SectionsInfoHotel.descriptionHotelText("dwwdw dw dwdw wdw dw dw d wdw w ddw w dwd wd dwd wdw dw dw dw dw dw dw dw  dw dw dw dw dw wd ddw")
        
      
        sections.append(hotelImage)
        sections.append(hotelDescription)
        sections.append(aboutHotel)
        sections.append(descrHot)
        
        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        collectionView.register(UINib(nibName: "InfoHotelCell", bundle: nil), forCellWithReuseIdentifier: "InfoHotelCell")
        collectionView.register(UINib(nibName: "AboutHotelCell", bundle: nil), forCellWithReuseIdentifier: "AboutHotelCell")
        collectionView.register(DescriptionHotelCell.self, forCellWithReuseIdentifier: DescriptionHotelCell.identifier)
        collectionView.register(UINib(nibName: "MoreAboutHotelCell", bundle: nil), forCellWithReuseIdentifier: "MoreAboutHotelCell")
        
        collectionView.register(UpHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UpHeader.identifier)
        collectionView.register(UINib(nibName: "PriceFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter")
        
        collectionView.collectionViewLayout = createLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}


extension HotelController: UICollectionViewDelegateFlowLayout {
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .hotelImage(_):
            return 1
        case .hotelDescription(_):
            return 1
        case .aboutHotel(let aboutHotel):
            return aboutHotel.count
        case .descriptionHotelText(_):
            return 1
        case .moreAboutHotel:
            return 3
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        switch sections[indexPath.section] {
            
        case .hotelImage(let imageArr):
            cell.imageArr = imageArr
            cell.pageControl.numberOfPages = imageArr.count
            cell.collectionView?.reloadData()
        case .hotelDescription(let descriptionHotel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoHotelCell", for: indexPath) as! InfoHotelCell
            cell.descriptionGrade.text = descriptionHotel.descripitonGrade
            return cell
        case .aboutHotel(let aboutHotel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutHotelCell", for: indexPath) as! AboutHotelCell
            cell.descriptionText.text = aboutHotel[indexPath.row]
            return cell
        case .descriptionHotelText(let descriptionHotel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionHotelCell.identifier, for: indexPath) as! DescriptionHotelCell
            cell.descriptionText.text = descriptionHotel
            return cell
        case .moreAboutHotel:
            break
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let upHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UpFooter", for: indexPath) as! UpHeader
            
            switch sections[indexPath.section] {
                
            case .hotelImage(_):
                upHeader.label.textAlignment = .center
                upHeader.label.text = "Отель"
            case .aboutHotel(_):
                upHeader.label.textAlignment = .left
                upHeader.label.text = "Об отеле"
            default: break
            }
            return upHeader
        }else {
            let priceFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter", for: indexPath) as! PriceFooter
            priceFooter.button.isHidden = true
            return priceFooter
        }
    }
    
}

extension HotelController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
            
            let section = self.sections[sectionNumber]
            
            switch section {
                
            case .hotelImage(_):
                
                let imageItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [imageItem])
                group.contentInsets.bottom = 20
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                return section
                
            case .hotelDescription(_):
                
                let descriptionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [descriptionItem])
                group.contentInsets.leading = 15
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)]
                return section
                
            case .aboutHotel(_):
                
                let aboutHotelItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(100)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [aboutHotelItem])
                group.interItemSpacing = .fixed(10)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.contentInsets.leading = 15
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                
                return section
                
            case .descriptionHotelText(_):
                
                let descriptionHotelText = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [descriptionHotelText])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 15
                section.contentInsets.top = 5
                
                return section
                
            case .moreAboutHotel:
                
                let aboutHotelItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), subitems: [aboutHotelItem])
                
                group.contentInsets.top = 15
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                
                
                return section
                
            }
        }
        
        layout.configuration = configuration
        return layout
    }
    
}


