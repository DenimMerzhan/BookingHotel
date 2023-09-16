//
//  ViewController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class HotelController: UITableViewController {
    
    var sections = [SectionsInfoHotel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = HotelModel.fillSections()
        
        tableView.register(UINib(nibName: "HotelCollectionCell", bundle: nil), forCellReuseIdentifier: "HotelCollectionCell")
        tableView.register(UINib(nibName: "InfoHotelCell", bundle: nil), forCellReuseIdentifier: "InfoHotelCell")
        tableView.register(UINib(nibName: "TagCollectionCell", bundle: nil), forCellReuseIdentifier: "TagCollectionCell")
        tableView.register(DescriptionHotelCell.self, forCellReuseIdentifier: DescriptionHotelCell.identifier)
        tableView.register(UINib(nibName: "MoreAboutHotelCell", bundle: nil), forCellReuseIdentifier: "MoreAboutHotelCell")
        tableView.register(UINib(nibName: "ActionCell", bundle: nil), forCellReuseIdentifier: "ActionCell")
        
        tableView.layoutMargins = .zero
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
        case .moreAboutHotel(let moreAboutHotel):
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
            return cell
        case .moreAboutHotel(let moreAboutHotel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoreAboutHotelCell", for: indexPath) as! MoreAboutHotelCell
            cell.descriptionText.text = moreAboutHotel[indexPath.row].description
            cell.imageDescription.image = moreAboutHotel[indexPath.row].image
            
            if indexPath.row == 0 {
                cell.view.layer.cornerRadius = 10
                cell.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }else if indexPath.row == 2 {
                cell.view.layer.cornerRadius = 10
                cell.view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.separateView.isHidden = true
            }
            return cell
        case .selectNumber:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell") as! ActionCell
            let action = UIAction { [weak self] action in
                self?.performSegue(withIdentifier: "goToSelectNumber", sender: self)
            }
            cell.button.addAction(action, for: .touchUpInside)
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        switch sections[section] {
        case .description(_):
            let priceFooter = UINib(nibName: "PriceFooter", bundle: nil).instantiate(withOwner: self).first as! PriceFooter
            priceFooter.updateTextlabel(additionalText: "от ", priceText: "143 000р ", descriptionText: "За тур с перелетом")
            priceFooter.button.isHidden = true
            priceFooter.backgroundView.layer.cornerRadius = 15
            priceFooter.backgroundView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            priceFooter.separateView.isHidden = false
            return priceFooter
        case .moreAboutHotel(_):
            let separateView = createSepareteView()
            return separateView
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .description(_):
            return 80
        case .moreAboutHotel(_):
            return 35
        default: return .leastNormalMagnitude
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hedearView = UINib(nibName: "TitleHedear", bundle: nil).instantiate(withOwner: self).first as! TitleHedear
        hedearView.upSeparateView.isHidden = true
        hedearView.downSeparateView.isHidden = true
        hedearView.backButton.isHidden = true
        
        switch sections[section] {
        case .hotelImage(_):
            hedearView.label.textAlignment = .center
            hedearView.label.text = "Отель"
            return hedearView
        case .tagHotel(_):
            hedearView.label.textAlignment = .left
            hedearView.label.text = "Об отеле"
            hedearView.label.font = .systemFont(ofSize: 25, weight: .medium)
            hedearView.layer.cornerRadius = 15
            hedearView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            return hedearView
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        }else if section == 2 {return 70}
        return .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
            
        case .hotelImage(_):
            return 315
        case .description(_):
            return 120
        case .tagHotel(let tagHotel):
            if let height = RoomModel.calculateHeightTagCollectionView(tagArr: tagHotel, widthCollectionView: tableView.frame.width,font: .systemFont(ofSize: 18, weight: .medium)) {return height}
            return 0
        case .detailDescription(let descriptionText):
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 30, height: 50))
            label.text = descriptionText
            label.font = .systemFont(ofSize: 17)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            return label.sizeThatFits(CGSize(width: tableView.frame.width, height: 50)).height + 30
        case .moreAboutHotel(_):
            return 90
        case .selectNumber:
            return 100
        }
    }
}


extension HotelController {
    
    func createSepareteView() -> UIView{
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
        backView.backgroundColor = UIColor(named: "SeparateCollectionView")
        let whiteView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
        whiteView.layer.cornerRadius = 15
        whiteView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        whiteView.backgroundColor = .white
        
        backView.addSubview(whiteView)
        
        return backView
    }
    
}


