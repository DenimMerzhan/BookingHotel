//
//  ViewController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class HotelController: UITableViewController {
    
    var sections = [SectionsInfoHotel]()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var selectNumberButton: UIButton!
    @IBOutlet weak var separateViewSelectNumber: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = HotelModel.fillSections()
        
        tableView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellReuseIdentifier: "CollectionCell")
        tableView.register(UINib(nibName: "InfoHotelCell", bundle: nil), forCellReuseIdentifier: "InfoHotelCell")
        tableView.register(UINib(nibName: "TagCell", bundle: nil), forCellReuseIdentifier: "TagCell")
        tableView.register(DescriptionHotelCell.self, forCellReuseIdentifier: "DescriptionHotelCell")
        tableView.register(UINib(nibName: "MoreAboutHotelCell", bundle: nil), forCellReuseIdentifier: "MoreAboutHotelCell")
        
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        heightScrollView.constant = collectionView.contentSize.height + 100
    }
    
    
    @IBAction func selectNumberPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSelectRoomNumber", sender: self)
    }
    
}


//MARK: - DataSource,Delegate

extension HotelController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .hotelImage(_):
            return 1
        case .description(_):
            return 1
        case .tagHotel(let aboutHotel):
            return aboutHotel.count
        case .detailDescription(_):
            return 1
        case .aboutHotel(let moreAboutHotel):
            return moreAboutHotel.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
            
        case .hotelImage(let imageArr):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as! HotelCollectionCell
            cell.imageArr = imageArr
            cell.pageControl.numberOfPages = imageArr.count
            return cell
        case .description(let descriptionHotel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoHotelCell", for: indexPath) as! InfoHotelCell
            cell.descriptionGrade.text = descriptionHotel.descripitonGrade
            return cell
        case .tagHotel(let aboutHotel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as! TagCell
           
            return cell
        case .detailDescription(let descriptionHotel):
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionHotelCell.identifier, for: indexPath) as! DescriptionHotelCell
            cell.descriptionText.text = descriptionHotel
            cell.descriptionText.sizeToFit()
            return cell
        case .aboutHotel(let moreAboutHotel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoreAboutHotelCell", for: indexPath) as! MoreAboutHotelCell
            cell.descriptionText.text = moreAboutHotel[indexPath.row].description
            cell.imageDescription.image = moreAboutHotel[indexPath.row].image
            
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
    
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
            
        case .hotelImage(_):
            <#code#>
        case .description(_):
            <#code#>
        case .tagHotel(_):
            <#code#>
        case .detailDescription(_):
            <#code#>
        case .aboutHotel(_):
            <#code#>
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let titleHedear = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHedear", for: indexPath) as! TitleHedear
            
            titleHedear.upSeparateView.isHidden = true
            titleHedear.downSeparateView.isHidden = true
            titleHedear.backButton.isHidden = true
            
            switch sections[indexPath.section] {
                
            case .hotelImage(_):
                titleHedear.label.textAlignment = .center
                titleHedear.label.text = "Отель"
            case .tagHotel(_):
                titleHedear.label.textAlignment = .left
                titleHedear.label.text = "Об отеле"
                titleHedear.label.font = .systemFont(ofSize: 25, weight: .medium)
            default: break
            }
            return titleHedear
        }else {
            let priceFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter", for: indexPath) as! PriceFooter
            priceFooter.button.isHidden = true
            switch sections[indexPath.section] {
            case .description(_):
                priceFooter.updateTextlabel(additionalText: "от ", priceText: "143 000р ", descriptionText: "За тур с перелетом")
            case .aboutHotel(_):
                priceFooter.priceLabel.isHidden = true
            default: break
            }
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
                
                let imageItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300)), subitems: [imageItem])
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                
                return section
                
            case .description(_):
                
                let descriptionItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [descriptionItem])
                group.contentInsets.leading = 15
                group.contentInsets.trailing = 15
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)]
                section.contentInsets.top = 15
                section.contentInsets.bottom = 10
                
                return section
                
            case .tagHotel(_):
                
                let aboutHotelItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(100)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [aboutHotelItem])
                group.interItemSpacing = .fixed(8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 5
                section.contentInsets.leading = 15
                section.contentInsets.trailing = 15
                
                section.boundarySupplementaryItems = [.init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                
                return section
                
            case .detailDescription(_):
                
                let descriptionHotelText = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [descriptionHotelText])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 15
                section.contentInsets.trailing = 15
                section.contentInsets.top = 15
                
                return section
                
            case .aboutHotel(_):
                
                let aboutHotelItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(85)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(85)), subitems: [aboutHotelItem])
                group.contentInsets.leading = 15
                group.contentInsets.trailing = 15
                
                let section = NSCollectionLayoutSection(group: group)
              
                section.contentInsets.top = 20
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)]
                
                return section
                
            }
        }
        
        layout.configuration = configuration
        return layout
    }
    
}


