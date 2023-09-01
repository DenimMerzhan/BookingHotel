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
        
        let hotel = SectionsInfoHotel.hotel(Hotel(imageArr: [UIImage(named: "Hotel")], grade: 5, descripitonGrade: "dwdwdw", nameHotel: "dwwd", adressHotel: "dwdw", price: "dwdw"))
        
        let aboutHotel = SectionsInfoHotel.aboutHotel(AboutHotel(aboutHotel: ["dwwd"], descriptionText: "dwdwd", moreAboutHotel: ["dwdw"]))
        
        sections.append(hotel)
        sections.append(aboutHotel)
        collectionView.register(UINib(nibName: "SwipeCell", bundle: nil), forCellWithReuseIdentifier: "SwipePhotoCell")
        collectionView.register(UINib(nibName: "InfoHotelCell", bundle: nil), forCellWithReuseIdentifier: "InfoHotelCell")
        collectionView.register(UINib(nibName: "AboutHotelCell", bundle: nil), forCellWithReuseIdentifier: "AboutHotelCell")
        collectionView.register(UINib(nibName: "DescriptionHotelCell", bundle: nil), forCellWithReuseIdentifier: "DescriptionHotelCell")
        collectionView.register(UINib(nibName: "MoreAboutHotelCell", bundle: nil), forCellWithReuseIdentifier: "MoreAboutHotelCell")
        
        
        
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
            return hotel.imageArr.count + 1
        case .aboutHotel(let aboutHotel):
            return aboutHotel.aboutHotel.count - 1 + 1 + aboutHotel.moreAboutHotel.count - 1
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch sections[indexPath.section] {
            
        case .hotel(let hotel):
            
            if indexPath.row <= hotel.imageArr.count - 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipePhotoCell", for: indexPath) as! SwipeCell
                
                return cell
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoHotelCell", for: indexPath) as! InfoHotelCell
                cell.gradeHotel.text = String(hotel.grade)
                cell.descriptionGrade.text = hotel.descripitonGrade
                return cell
            }
            
        case .aboutHotel(let aboutHotel):
            
            if indexPath.row < aboutHotel.aboutHotel.count - 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutHotelCell", for: indexPath) as! AboutHotelCell
                return cell
            }else if indexPath.row == aboutHotel.aboutHotel.count {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionHotelCell", for: indexPath) as! DescriptionHotelCell
                return cell
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreAboutHotelCell", for: indexPath) as! MoreAboutHotelCell
                return cell
            }
        }
    }
    
}

extension HotelController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
            
            let sections = self.sections[sectionNumber]
            
            switch sections {
                
            case .hotel(_):
                
                let photoItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
                let descriptionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)))
                
                let photoGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
                let photoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: photoGroupSize, subitems: [photoItem])
                
                let groupSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(500))
                let group1 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize1, subitems: [photoGroup,descriptionItem])
                
                
                let section = NSCollectionLayoutSection(group: group1)
                section.orthogonalScrollingBehavior = .paging
                return section
                
            case .aboutHotel(_):
                
                let aboutHotelItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(50)))
                
                let hotelDescriptionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150)))
                
                let moreAboutHotel = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90)))
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalWidth(1))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [aboutHotelItem,hotelDescriptionItem,moreAboutHotel])
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
                
            }
            
            
        }
       
        layout.configuration = configuration
        return layout
    }
    
}


