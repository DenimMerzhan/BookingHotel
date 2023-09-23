//
//  ViewController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 31.08.23.
//

import UIKit

class HotelController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var hotelDataModel: HotelDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HotelNetworkService.getHotel { [weak self] hotel in
            self?.hotelDataModel = HotelDataModel(hotel: hotel)
            self?.tableView.reloadData()
            HotelNetworkService.getImage(urlArr: hotel.image_urls) { image, imagePosition in
                self?.hotelDataModel?.hotelImage[imagePosition] = image
                self?.tableView.reloadData()
            }
        }
    
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HotelCollectionCell", bundle: nil), forCellReuseIdentifier: "HotelCollectionCell")
        tableView.register(UINib(nibName: "InfoHotelCell", bundle: nil), forCellReuseIdentifier: "InfoHotelCell")
        tableView.register(UINib(nibName: "TagCollectionCell", bundle: nil), forCellReuseIdentifier: "TagCollectionCell")
        tableView.register(DescriptionHotelCell.self, forCellReuseIdentifier: DescriptionHotelCell.identifier)
        tableView.register(UINib(nibName: "MoreAboutHotelCell", bundle: nil), forCellReuseIdentifier: "MoreAboutHotelCell")
        tableView.register(UINib(nibName: "ActionCell", bundle: nil), forCellReuseIdentifier: "ActionCell")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    @objc func selectNumberPressed(){
        self.performSegue(withIdentifier: "goToSelectNumber", sender: self)
    }
    
}


//MARK: - DataSource,Delegate

extension HotelController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return hotelDataModel?.numberOfsections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelDataModel?.numberOfRowsInsection(section: section) ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataModel = hotelDataModel else {return UITableViewCell()}
        switch dataModel.sections[indexPath.section] {
            
        case .hotelImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HotelCollectionCell", for: indexPath) as! HotelCollectionCell
            cell.imageArr = dataModel.hotelImage
            cell.pageControl.numberOfPages = dataModel.hotelImage.count
            return cell
        case .description(let descriptionHotel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoHotelCell", for: indexPath) as! InfoHotelCell
            cell.descriptionGrade.text = descriptionHotel.raitingName
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
            cell.button.addTarget(self, action: #selector(selectNumberPressed), for: .touchUpInside)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let sections = hotelDataModel?.sections else {return nil}
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
            let separateView = HotelModel.shared.createSeparateView(width: tableView.frame.width)
            return separateView
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let sections = hotelDataModel?.sections else {return .leastNormalMagnitude}
        switch sections[section] {
        case .description(_):
            return 80
        case .moreAboutHotel(_):
            return 35
        default: return .leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sections = hotelDataModel?.sections else {return nil}
        let hedearView = UINib(nibName: "TitleHedear", bundle: nil).instantiate(withOwner: self).first as! TitleHedear
        switch sections[section] {
        case .tagHotel(_):
            hedearView.separateView.isHidden = true
            hedearView.label.textAlignment = .left
            hedearView.label.text = "Об отеле"
            hedearView.label.font = .systemFont(ofSize: 25, weight: .medium)
            hedearView.layer.cornerRadius = 15
            hedearView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            return hedearView
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {return 60}
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sections = hotelDataModel?.sections else {return .leastNormalMagnitude}
        switch sections[indexPath.section] {
            
        case .hotelImage:
            return 315
        case .description(_):
            return 130
        case .tagHotel(let tagHotel):
            let roomModel = RoomModel()
            if let height = roomModel.calculateHeightTagCollectionView(tagArr: tagHotel, widthCollectionView: tableView.frame.width,font: K.font.tagCell) {return height}
            return 0
        case .detailDescription(let descriptionText):
            return HotelModel.shared.estimatedHeightForTagCell(widthTableView: tableView.frame.width, withDescription: descriptionText) + 30
        case .moreAboutHotel(_):
            return 90
        case .selectNumber:
            return 85
        }
    }
}


