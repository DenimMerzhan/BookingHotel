//
//  BookingController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 06.09.23.
//

import UIKit

class BookingController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bookingInfo = [BookingInfo]()
    var bookingModel = BookingModel()
    var isVerificationBegan = Bool()
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Бронирование"
        bookingInfo = bookingModel.bookingInfo
        
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
        
        switch bookingInfo[2] {
        case .customerInfo(let customerInfo):
            switch bookingInfo[3] {
            case .tourist(let tourist):
                if bookingModel.validateBooking(tourist: tourist, customerInfo: customerInfo) {
                    self.performSegue(withIdentifier: "goToDoneScreen", sender: self)
                }else {
                    tableView.reloadData()
                }
            default: break
            }
        default: break
        }
    }
}

// MARK: - Table view data source


extension BookingController: UITableViewDataSource,UITableViewDelegate {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookingInfo.count
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch bookingInfo[section] {
        case .aboutHotel(_),.pay: return 1
        case .bookingDetails(let bookingDetails):
            return bookingDetails.count
        case .customerInfo:
            return bookingModel.customerInfoPlaceholder.count
        case .tourist (let touristData):
            switch touristData.buttonState {
            case .selected:
                return bookingModel.touristDataPlaceholder.count
            default: return 0
            }
        case .result(let bookingDetails): return bookingDetails.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch bookingInfo[indexPath.section] {
        case .aboutHotel(let hotelDescription):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoHotelCell", for: indexPath) as! InfoHotelCell
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
        case .pay:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as! ActionCell
            cell.button.addTarget(self, action: #selector(payPressed), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch bookingInfo[section] {
        case .aboutHotel(_):
            return 10
        case .customerInfo(_),.tourist(_): return 70
        default: return .leastNormalMagnitude
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch bookingInfo[section] {
        case .customerInfo(_): return 70
        case .pay: return .leastNormalMagnitude
        default: return 10
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch bookingInfo[section] {
        case .aboutHotel(_):
            let view = UINib(nibName: "TitleHedear", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TitleHedear
            view.label.isHidden = true
            return view
        case .customerInfo:
            let state = bookingInfo[section].getState()
            let bookingHeader = BookingHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100),stateButton: state)
            bookingHeader.label.text = "Информация о покупателе"
            bookingHeader.button.isHidden = true
            bookingHeader.section = section
            bookingHeader.delegate = self
            return bookingHeader
        case .tourist:
            let state = bookingInfo[section].getState()
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
        if isAddTourist {
            let index = bookingInfo.count - 3
            bookingInfo.insert((.tourist(.init(buttonState: .notTouch))), at: index)
            tableView.reloadData()
            return
        }
        bookingInfo[section].changeSelectedState()
        tableView.reloadData()
        let row = tableView.numberOfRows(inSection: section)
        if row > 0 {
            tableView.scrollToRow(at: IndexPath(row: row - 1, section: section), at: .middle, animated: true)
        }
    }
    
    
    func textDidChange(text: String?,indexPath:IndexPath) {
        switch bookingInfo[indexPath.section] {
        case .customerInfo(_):
            bookingInfo[indexPath.section].changeCustomerInfoData(newValue: text, row: indexPath.row)
        case .tourist(_):
            bookingInfo[indexPath.section].changeTouristData(newValue: text, row: indexPath.row)
        default: break
        }
    }
}

