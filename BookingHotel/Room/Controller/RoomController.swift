//
//  RoomControllerTableViewController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 05.09.23.
//

import UIKit

class RoomController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var roomModel: RoomDataModel?
    var currentIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RoomNetworkService.funcGetDataRoom { [weak self] roomsJson in
            self?.roomModel = RoomDataModel(roomsJson: roomsJson)
            self?.collectionView.reloadData()
            self?.getImage(rooms: roomsJson)
        }
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = "Steingber Mask"
        
        collectionView.allowsSelection = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "RoomCell", bundle: nil), forCellWithReuseIdentifier: "RoomCell")
        collectionView.register(UINib(nibName: "PriceFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter")
        collectionView.register(UINib(nibName: "TitleHedear", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHedear")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destanationVC = segue.destination as? BookingController else {return}
        destanationVC.indexPath =  currentIndexPath
    }
    
}

extension RoomController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return roomModel?.numberOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomModel?.numberOfRowsInSection ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as! RoomCell
        guard let room = roomModel?.roomArr[indexPath.section] else {return cell}
        cell.room = room
        cell.pageControl.numberOfPages = room.roomImage.count
        cell.descriptionNumber.text = room.name
        cell.layer.cornerRadius = 15
        cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let room = roomModel?.roomArr[indexPath.section] else {return .zero}
        if let height =  RoomModel.calculateHeightTagCollectionView(tagArr: room.peculiarities, widthCollectionView: collectionView.frame.width,font: K.font.tagCell) {
            return CGSize(width: collectionView.frame.width, height: height + 300 + 70 + 20) /// 300 высота pageCollection 70 высота лейбла, 20 отступ от верха
        }
        return .zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let room = roomModel?.roomArr[indexPath.section] else {return UICollectionReusableView()}
        if kind == UICollectionView.elementKindSectionHeader {
            let headear = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHedear", for: indexPath) as! TitleHedear
            headear.label.isHidden = true
            return headear
        }else {
            let priceFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter", for: indexPath) as! PriceFooter
            priceFooter.priceLabel.attributedText =  HotelModel.shared.updatePriceFooterText(additionalText: "", price: room.price, descriptionText: " " + room.pricePer)
            priceFooter.indexPath = indexPath
            priceFooter.button.removeTarget(nil, action: nil, for: .allEvents)
            let buttonAction = UIAction { [weak self] action in
                self?.currentIndexPath = indexPath
                self?.performSegue(withIdentifier: "goToBooking", sender: self)
            }
            priceFooter.button.addAction(buttonAction, for: .touchUpInside)
            priceFooter.backgroundView.layer.cornerRadius = 15
            priceFooter.backgroundView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            return priceFooter
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 10)
        }
        return .zero
    }
    
}

//MARK: - GetImage

extension RoomController {
    
    func getImage(rooms: RoomsJson){
        for i in 0...rooms.rooms.count - 1 {
            let urlArr = rooms.rooms[i].image_urls
            RoomNetworkService.getImageRoom(urlArr: urlArr) { [weak self] image, imagePosition in
                self?.roomModel?.roomArr[i].roomImage[imagePosition] = image
                self?.collectionView.reloadData()
                self?.collectionView.reloadData()
            }
        }
    }
}
