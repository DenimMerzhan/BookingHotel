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
        
        tableView.register(UINib(nibName: "HotelCollectionCell", bundle: nil), forCellReuseIdentifier: "HotelCollectionCell")
        tableView.register(UINib(nibName: "InfoHotelCell", bundle: nil), forCellReuseIdentifier: "InfoHotelCell")
        tableView.register(UINib(nibName: "TagCollectionCell", bundle: nil), forCellReuseIdentifier: "TagCollectionCell")
        tableView.register(DescriptionHotelCell.self, forCellReuseIdentifier: DescriptionHotelCell.identifier)
        tableView.register(UINib(nibName: "MoreAboutHotelCell", bundle: nil), forCellReuseIdentifier: "MoreAboutHotelCell")
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
    }
    
    
    @IBAction func selectNumberPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "goToSelectRoomNumber", sender: self)
    }
    
}


//MARK: - DataSource,Delegate

extension HotelController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .aboutHotel(let moreAboutHotel):
            return moreAboutHotel.count
        default: return 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
            
        case .hotelImage(let imageArr):
            let cell = tableView.dequeueReusableCell(withIdentifier: "HotelCollectionCell", for: indexPath) as! HotelCollectionCell
            cell.imageArr = imageArr
            cell.pageControl.numberOfPages = imageArr.count
            return cell
        case .description(let descriptionHotel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoHotelCell", for: indexPath) as! InfoHotelCell
            cell.descriptionGrade.text = descriptionHotel.descripitonGrade
            return cell
        case .tagHotel(let aboutHotel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TagCollectionCell", for: indexPath) as! TagCollectionCell
            cell.tagArr = aboutHotel
            return cell
        case .detailDescription(let descriptionHotel):
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionHotelCell.identifier, for: indexPath) as! DescriptionHotelCell
            cell.descriptionText.text = descriptionHotel
//            cell.descriptionText.sizeToFit()
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
            return 300
        case .description(_):
            return 100
        case .tagHotel(let tagHotel):
            if let height = RoomModel.calculateHeightTagCollectionView(tagArr: tagHotel, widthCollectionView: tableView.frame.width,font: .systemFont(ofSize: 18, weight: .medium)) {return height}
            return 0
        case .detailDescription(let descriptionText):
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 30, height: 50))
            label.text = descriptionText
            label.font = .systemFont(ofSize: 17)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            return label.sizeThatFits(CGSize(width: tableView.frame.width, height: 50)).height + 15
        case .aboutHotel(_):
            return 100
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



