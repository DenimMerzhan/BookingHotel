//
//  ViewController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class HotelController: UICollectionViewController {
    
    var sections = [SectionsInfoHotel]()
    private var topHeightSafeArea = CGFloat()
    private var constrainTopPageControl: NSLayoutConstraint?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var hotellArr = [UIImage?]()
        let hotelImage1 = UIImage(named: "Hotel")
        let hotelImage2 = UIImage(named: "Hotel")
        hotellArr.append(hotelImage1)
        hotellArr.append(hotelImage2)
        
        let hotelImage = SectionsInfoHotel.hotelImage(hotellArr)
        let hotelDescription = SectionsInfoHotel.hotelDescription(HotelDescription(grade: 5, descripitonGrade: "5 Превосходно", nameHotel: "Barbaris", adressHotel: "dik My dik", price: "134 00 00 р"))
        let aboutHotel = SectionsInfoHotel.aboutHotel(["kek","Pek"])
        let moreAboutHotel = SectionsInfoHotel.moreAboutHotel
        let descrHot = SectionsInfoHotel.descriptionHotelText("dwwddw")
       
        
        sections.append(hotelImage)
        sections.append(hotelDescription)
      
        
        
        

        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
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
        case .hotelImage(let imageArr):
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
        case .aboutHotel(_):
            break
        case .descriptionHotelText(_):
            break
        case .moreAboutHotel:
            break
        }
        
        return cell
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
                let imageItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [imageItem])
//                group.contentInsets.trailing = 15
//                group.contentInsets.leading = 15
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                return section
                
            case .hotelDescription(_):
                
                let descriptionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(300), heightDimension: .estimated(200)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [descriptionItem])
                group.contentInsets.trailing = 15
                group.contentInsets.leading = 15
                group.contentInsets.top = 20
                
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            case .aboutHotel(_),.descriptionHotelText(_),.moreAboutHotel:
                
                let aboutHotelItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), subitems: [aboutHotelItem])
                
                group.contentInsets.top = 15
                
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            }
        }
        
        layout.configuration = configuration
        return layout
    }
    
}


