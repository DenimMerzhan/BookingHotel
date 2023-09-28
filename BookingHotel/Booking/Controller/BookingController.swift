//
//  BookingController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 06.09.23.
//

import UIKit

class BookingController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bookingModel: BookingModel?
    var isVerificationBegan = Bool()
    
    var hotelDescription: HotelDescription?
    var room: Room?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Бронирование"
        
        BookingNetworkService.getBookingInfo() { [weak self] bookingInfoJson in
            if let hotelDescription = self?.hotelDescription, let room = self?.room {
                self?.bookingModel = BookingModel(bookingInfoJson: bookingInfoJson,hotelDescription: hotelDescription,room: room)
            }
            self?.tableView.reloadData()
        }
        
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "BookingDetailesCell", bundle: nil), forCellReuseIdentifier: "BookingDetailesCell")
        tableView.register(UINib(nibName: "InfoTouirist", bundle: nil), forCellReuseIdentifier: "InfoTouirist")
        tableView.register(UINib(nibName: "InfoHotelCell", bundle: nil), forCellReuseIdentifier: "InfoHotelCell")
        tableView.register(UINib(nibName: "ActionCell", bundle: nil), forCellReuseIdentifier: "ActionCell")

    }
    
    @objc func backButtonPressed(){
        self.dismiss(animated: true)
    }

    @objc func payPressed(){
        isVerificationBegan = true
        guard let bookingModel = bookingModel else {return}
        if bookingModel.isUserValidate() {
            performSegue(withIdentifier: "goToDoneScreen", sender: self)
        }else {
            switch bookingModel.bookingInfo[3].getState() {
            case .notTouch:
                self.bookingModel?.bookingInfo[3].changeSelectedState()
            default: break
            }
            tableView.reloadData()
        }
    }
    
    deinit {
        print("\(self) deinit")
    }
}

// MARK: - Table view data source


extension BookingController: UITableViewDataSource,UITableViewDelegate {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookingModel?.numberOfsection ?? 0
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingModel?.numberOfRowsInSection(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bookingModel = bookingModel else {return UITableViewCell()}
        switch bookingModel.bookingInfo[indexPath.section] {
        case .aboutHotel(let hotelDescription):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoHotelCell", for: indexPath) as! InfoHotelCell
            cell.nameHotel.text = hotelDescription.nameHotel
            cell.addresHotel.text = hotelDescription.adressHotel
            cell.descriptionGrade.text = String(hotelDescription.grade) +  hotelDescription.raitingName
            cell.contentView.layer.cornerRadius = 15
            return cell
        case .bookingDetails(let bookingDetails):
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDetailesCell") as! BookingDetailesCell
            let details = bookingDetails[indexPath.row]
            cell.details.text = details.deatails
            cell.descriptionDetails.text = details.descripiton
            cell.descriptionDetails.textAlignment = .left
            
            if indexPath.row == 0 {
                cell.contentView.layer.cornerRadius = 15
                cell.contentView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            }else if indexPath.row == bookingDetails.count - 1 {
                cell.contentView.layer.cornerRadius = 15
                cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            }
            return cell
        case .customerInfo(let customerInfo):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTouirist") as! InfoTouirist
            cell.textField.placeholder = bookingModel.customerInfoPlaceholder[indexPath.row]
            cell.upPlaceHolder.text = bookingModel.customerInfoPlaceholder[indexPath.row]
            cell.indexPath = indexPath
            cell.delegate = self

            if indexPath.row == 0 {
                cell.isUsedMaskNumber = true
                cell.textField.text = customerInfo.phoneNumber
                if customerInfo.phoneNumber.isValidPhoneNumber() == false && isVerificationBegan {
                    cell.view.backgroundColor = K.color.wrongDataColor?.withAlphaComponent(0.15)
                }
            }else {
                if customerInfo.email.isValidEmail() == false && isVerificationBegan {
                    cell.view.backgroundColor = K.color.wrongDataColor?.withAlphaComponent(0.15)
                }
                cell.textField.text = customerInfo.email
            }
            
            if let text = cell.textField.text {
                if text.isEmpty == false {
                    cell.upPlaceHolder.isHidden = false
                }
            }
            
            return cell
        case .tourist(let tourist):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTouirist") as! InfoTouirist
            let descriptionStatus = bookingModel.getDescriptionStatus(tourist: tourist, row: indexPath.row)
            cell.textField.placeholder = bookingModel.touristDataPlaceholder[indexPath.row]
            cell.upPlaceHolder.text = bookingModel.touristDataPlaceholder[indexPath.row]
            cell.textField.text = descriptionStatus.description
            cell.indexPath = indexPath
            cell.delegate = self
           
            if descriptionStatus.isValid == false && isVerificationBegan {
                cell.view.backgroundColor =  K.color.wrongDataColor?.withAlphaComponent(0.15)
            }
            if tourist.isTouristEmpty() && indexPath.section != 3 {
                cell.view.backgroundColor = K.color.separateColor
            }
            
            if indexPath.row == bookingModel.touristDataPlaceholder.count - 1 {
                cell.contentView.layer.cornerRadius = 15
                cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            }
            
            if let text = cell.textField.text {
                if text.isEmpty == false {
                    cell.upPlaceHolder.isHidden = false
                }
            }
            return cell
        case .result(let bookingDetails):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDetailesCell") as! BookingDetailesCell
            let details = bookingDetails[indexPath.row]
            cell.details.text = details.deatails
            cell.descriptionDetails.text = details.descripiton
            cell.descriptionDetails.textAlignment = .right
            
            if indexPath.row == 0 {
                cell.contentView.layer.cornerRadius = 15
                cell.contentView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            }else if indexPath.row == bookingDetails.count - 1 {
                cell.contentView.layer.cornerRadius = 15
                cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
                cell.descriptionDetails.textColor = K.color.buttonColor
            }
            return cell
        case .pay(let finalPrice):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as! ActionCell
            cell.button.addTarget(self, action: #selector(payPressed), for: .touchUpInside)
            cell.button.setTitle("Оплатить \(finalPrice)", for: .normal)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let bookingInfo = bookingModel?.bookingInfo else {return .leastNormalMagnitude}
        switch bookingInfo[section] {
        case .aboutHotel(_):
            return 10
        case .customerInfo(_),.tourist(_): return 70
        default: return .leastNormalMagnitude
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let bookingInfo = bookingModel?.bookingInfo else {return .leastNormalMagnitude}
        switch bookingInfo[section] {
        case .customerInfo(_): return 70
        case .pay: return .leastNormalMagnitude
        default: return 10
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let bookingModel = bookingModel else {return nil}
        switch bookingModel.bookingInfo[section] {
        case .aboutHotel(_):
            let view = UINib(nibName: "TitleHedear", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TitleHedear
            view.label.isHidden = true
            return view
        case .customerInfo:
            let state = bookingModel.bookingInfo[section].getState()
            let bookingHeader = BookingHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100),stateButton: state)
            bookingHeader.label.text = "Информация о покупателе"
            bookingHeader.button.isHidden = true
            bookingHeader.section = section
            bookingHeader.delegate = self
            return bookingHeader
        case .tourist:
            let state = bookingModel.bookingInfo[section].getState()
            let bookingHeader = BookingHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100),stateButton: state)
            bookingHeader.label.text = bookingModel.numberTouirist[section - 3] + " Турист"
            bookingHeader.section = section
            bookingHeader.delegate = self
            if section == tableView.numberOfSections - 3  {
                bookingHeader.isAddTourist = true
                bookingHeader.label.text = "Добавить туриста"
                if section - 3 == bookingModel.numberTouirist.count - 1 {
                    bookingHeader.button.isUserInteractionEnabled = false
                }
            }
            return bookingHeader
        case .result(_),.pay,.bookingDetails(_):
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let bookingInfo = bookingModel?.bookingInfo else {return nil}
        let footer = UINib(nibName: "BookingFooter", bundle: nil).instantiate(withOwner: nil).first as! BookingFooter
        switch bookingInfo[section] {
        case .customerInfo(_):
            footer.descriptionView.layer.cornerRadius = 15
            footer.descriptionView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        default:
            footer.descriptionView.isHidden = true
        }
        return footer
    }
}

//MARK: -  BookingHeaderDelegate, InfoTouristDelegate

extension BookingController: BookingHeaderDelegate, InfoTouristDelegate {
    
    func buttonPressed(section: Int,isAddTourist: Bool) {
        
        guard let bookingInfo = bookingModel?.bookingInfo else {return}
        
        if isAddTourist {
            let index = bookingInfo.count - 3
            bookingModel?.bookingInfo.insert((.tourist(.init(buttonState: .notTouch))), at: index)
            tableView.reloadData()
            return
        }
        bookingModel?.bookingInfo[section].changeSelectedState()
        tableView.reloadData()
        let row = tableView.numberOfRows(inSection: section)
        if row > 0 {
            tableView.scrollToRow(at: IndexPath(row: row - 1, section: section), at: .middle, animated: true)
        }
    }
    
    
    func textDidChange(text: String?,indexPath:IndexPath) {
        guard let bookingInfo = bookingModel?.bookingInfo else {return}
        switch bookingInfo[indexPath.section] {
        case .customerInfo(_):
            bookingModel?.bookingInfo[indexPath.section].changeCustomerInfoData(newValue: text, row: indexPath.row)
        case .tourist(_):
            bookingModel?.bookingInfo[indexPath.section].changeTouristData(newValue: text, row: indexPath.row)
        default: break
        }
    }
}

