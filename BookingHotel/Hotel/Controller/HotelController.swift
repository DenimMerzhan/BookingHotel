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
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 10
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.backgroundStyle = .prominent
        
        return pageControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(pageControl)
        
        
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        constrainTopPageControl = pageControl.topAnchor.constraint(equalTo: view.topAnchor,constant: 320)
        constrainTopPageControl?.isActive = true
        
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            if let topPadding = window?.safeAreaInsets.top {
                topHeightSafeArea = topPadding
            }
        }
        
        
        
        var hotellArr = [UIImage?]()
        let hotelImage1 = UIImage(named: "Hotel")
        let hotelImage2 = UIImage(named: "Hotel")
        
        hotellArr.append(hotelImage1)
        hotellArr.append(hotelImage2)
        
        let hotelImage = SectionsInfoHotel.hotelImage(hotellArr)
        let hotelDescription = SectionsInfoHotel.hotelDescription(HotelDescription(grade: 5, descripitonGrade: "5 Превосходно", nameHotel: "Barbaris", adressHotel: "dik My dik", price: "134 00 00 р"))
        let moreAboutHotel = SectionsInfoHotel.moreAboutHotel
        let descrHot = SectionsInfoHotel.descriptionHotelText("dwwddw")
        let aboutHotel = SectionsInfoHotel.aboutHotel(["kek","Pek"])
        
        collectionView.isPagingEnabled = true
        sections.append(hotelImage)
        sections.append(hotelDescription)
        //        sections.append(moreAboutHotel)
        //        sections.append(descrHot)
        //        sections.append(aboutHotel)
        
        
        switch sections[0] {
        case .hotelImage(let imageArr):
            pageControl.numberOfPages = imageArr.count
        default: break
        }
        
        
        collectionView.register(UINib(nibName: "SwipeCell", bundle: nil), forCellWithReuseIdentifier: "SwipeCell")
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
            return imageArr.count
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeCell", for: indexPath) as! SwipeCell
        switch sections[indexPath.section] {
            
        case .hotelImage(let imageArr):
            cell.photoHotel.image = imageArr[indexPath.row]
            constrainTopPageControl?.constant = cell.frame.maxY - topHeightSafeArea / 2
            
        case .hotelDescription(let descriptionHotel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoHotelCell", for: indexPath) as! InfoHotelCell
            
            cell.descriptionGrade.text = descriptionHotel.descripitonGrade
            return cell
            break
        case .aboutHotel(_):
            break
        case .descriptionHotelText(_):
            break
        case .moreAboutHotel:
            break
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
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
                group.contentInsets.trailing = 15
                group.contentInsets.leading = 15
                
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
                
                let imageItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [imageItem])
                
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            }
            
            
            
            
        }
        
        layout.configuration = configuration
        return layout
    }
    
}


