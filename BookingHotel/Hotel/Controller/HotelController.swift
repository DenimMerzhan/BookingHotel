//
//  ViewController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class HotelController: UIViewController {
    
    var sections = [SectionsInfoHotel]()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var hotellArr = [UIImage?]()
        let hotelImage1 = UIImage(named: "Hotel")
        let hotelImage2 = UIImage(named: "bizFWYcxUsk")
        let hotelImage3 = UIImage(named: "photo_5418041419760782066_y")
        
        hotellArr.append(hotelImage1)
        hotellArr.append(hotelImage2)
        hotellArr.append(hotelImage3)
        
        let hotelImage = SectionsInfoHotel.hotelImage(hotellArr)
        let hotelDescription = SectionsInfoHotel.hotelDescription(HotelDescription(grade: 5, descripitonGrade: "5 Превосходно", nameHotel: "Barbaris", adressHotel: "dik My dik", price: "134 00 00 р"))
        let aboutHotel = SectionsInfoHotel.aboutHotel(["kek","Pek","mokkook","dwdwdw","drop menu left"])
        
        let moreAboutHotel = SectionsInfoHotel.moreAboutHotel([.init(description: "Удобства",image: UIImage(named: "FacilitiesMAH")),.init(description: "Что включено",image: UIImage(named: "IncludedMAH")),.init(description: "Что не включено",image: UIImage(named: "NotIncludedMAH"))])
        
        let descrHot = SectionsInfoHotel.descriptionHotelText("dwwdw dw dwdw wdw dw dw d wdw w ddw w dwd wd dwd wdw dw dw dw dw dw dw dw  dw dw dw dw dw wd ddw")
        
      
        sections.append(hotelImage)
        sections.append(hotelDescription)
        sections.append(aboutHotel)
        sections.append(descrHot)
        sections.append(moreAboutHotel)
        
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        heightScrollView.constant = collectionView.contentSize.height
    }
    
}


//MARK: - DataSource,Delegate

extension HotelController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .hotelImage(_):
            return 1
        case .hotelDescription(_):
            return 1
        case .aboutHotel(let aboutHotel):
            return aboutHotel.count
        case .descriptionHotelText(_):
            return 1
        case .moreAboutHotel(let moreAboutHotel):
            return moreAboutHotel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
        case .hotelImage(let imageArr):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
            cell.imageArr = imageArr
            cell.pageControl.numberOfPages = imageArr.count
            cell.collectionView?.reloadData()
            return cell
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
            cell.descriptionText.sizeToFit()
            return cell
        case .moreAboutHotel(let moreAboutHotel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreAboutHotelCell", for: indexPath) as! MoreAboutHotelCell
            cell.descriptionText.text = moreAboutHotel[indexPath.row].description
            cell.image.image = moreAboutHotel[indexPath.row].image
            
            if indexPath.row == 0 {
                cell.layer.cornerRadius = 10
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }else if indexPath.row == 2 {
                cell.layer.cornerRadius = 10
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.separatorView.isHidden = true
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let upHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UpFooter", for: indexPath) as! UpHeader
            
            switch sections[indexPath.section] {
                
            case .hotelImage(_):
                upHeader.label.textAlignment = .center
                upHeader.label.text = "Отель"
            case .aboutHotel(_):
                upHeader.label.textAlignment = .left
                upHeader.label.text = "Об отеле"
                upHeader.label.font = .systemFont(ofSize: 25, weight: .medium)
            default: break
            }
            return upHeader
        }else {
            let priceFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter", for: indexPath) as! PriceFooter
            priceFooter.button.isHidden = true
            priceFooter.updateTextlabel(textBold: "от 143 000р ", textGray: " за тур с перелетом")
            return priceFooter
        }
    }
    
}

//MARK: - UICollectionViewCompositionalLayout

extension HotelController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
            
            let section = self.sections[sectionNumber]
            
            switch section {
                
            case .hotelImage(_):
                
                let widthHotel = self.view.frame.width
                let imageItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(270)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(270)), subitems: [imageItem])
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                
                return section
                
            case .hotelDescription(_):
                
                let descriptionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [descriptionItem])
                group.contentInsets.leading = 15
                group.contentInsets.trailing = 15
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)]
                section.contentInsets.top = 15
                section.contentInsets.bottom = 10
                
                return section
                
            case .aboutHotel(_):
                
                let aboutHotelItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(100)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [aboutHotelItem])
                group.interItemSpacing = .fixed(8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.contentInsets.leading = 15
                section.contentInsets.trailing = 15
                
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                
                return section
                
            case .descriptionHotelText(_):
                
                let descriptionHotelText = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [descriptionHotelText])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 15
                section.contentInsets.trailing = 15
                section.contentInsets.top = 15
                
                return section
                
            case .moreAboutHotel(_):
                
                let aboutHotelItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(85)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(85)), subitems: [aboutHotelItem])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 15
                section.contentInsets.trailing = 15
                section.contentInsets.top = 20
                
                return section
                
            }
        }
        
        layout.configuration = configuration
        return layout
    }
    
}


