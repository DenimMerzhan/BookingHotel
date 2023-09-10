//
//  BookingController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 06.09.23.
//

import UIKit

class BookingController: UIViewController {

    var bookingInfo = [BookingInfo]()
    var detailInfo = [BookingDetails]()
    var indexPath: IndexPath?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fly = BookingDetails(deatails: "Вылет из", descripiton: "Санкт-Петербург")
        print(indexPath)
        
        var details = [BookingDetails]()
        for _ in 0...8 {
            details.append(fly)
        }
        
        bookingInfo.append(.bookingDetails(details))
        bookingInfo.append(.customerInfo(CustomerInfo()))
        bookingInfo.append(.touristData(.init(buttonState: .notTouch)))
        bookingInfo.append(.touristData(.init(buttonState: .notTouch)))
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UINib(nibName: "BookingDetailesCell", bundle: nil), forCellReuseIdentifier: "BookingDetailesCell")
        tableView.register(UINib(nibName: "InfoTouirist", bundle: nil), forCellReuseIdentifier: "InfoTouirist")
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none

        
    }

    

}

// MARK: - Table view data source


extension BookingController: UITableViewDataSource,UITableViewDelegate {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookingInfo.count
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch bookingInfo[section] {
            
        case .bookingDetails(let bookingDetails):
            return bookingDetails.count
        case .customerInfo:
            return BookingModel.customerInfoPlaceholder.count
        case .touristData (let touristData):
            switch touristData.buttonState {
            case .selected:
                return BookingModel.touristDataPlaceholder.count
            default: return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch bookingInfo[indexPath.section] {
            
        case .bookingDetails(let bookingDetails):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDetailesCell") as! BookingDetailesCell
            let details = bookingDetails[indexPath.row]
            cell.details.text = details.deatails
            cell.descriptionDetails.text = details.descripiton
            cell.selectionStyle = .none
            
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
            cell.textField.placeholder = BookingModel.customerInfoPlaceholder[indexPath.row]
            cell.selectionStyle = .none
            cell.indexPath = indexPath
            cell.delegate = self
            
            if indexPath.row == 0 {
                cell.textField.text = customerInfo.phoneNumber
                cell.isUsedMaskNumber = true
            }else {
                cell.textField.text = customerInfo.email
            }
            return cell
        case .touristData(let touristData):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTouirist") as! InfoTouirist
            cell.textField.placeholder = BookingModel.touristDataPlaceholder[indexPath.row]
            cell.selectionStyle = .none
            cell.indexPath = indexPath
            cell.delegate = self
            
            switch indexPath.row {
            case 0:cell.textField.text = touristData.name
            case 1: cell.textField.text = touristData.family
            case 2: cell.textField.text = touristData.dateOfBirth
            case 3: cell.textField.text = touristData.citizenship
            case 4: cell.textField.text = touristData.numberPassport
            default:cell.textField.text = touristData.validityPeriodPassport
            }
            if indexPath.row == BookingModel.touristDataPlaceholder.count - 1 {
                cell.contentView.layer.cornerRadius = 15
                cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch bookingInfo[section] {
        case .bookingDetails(_):
            return 100
        default: return 70
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch bookingInfo[section] {
        case .bookingDetails(_):return 20
        case .customerInfo(_): return 70
        default: return 10
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch bookingInfo[section] {
        case .bookingDetails(_):
            let view = UINib(nibName: "TitleHedear", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TitleHedear
            view.upSeparateView.isHidden = true
            let titleAction = UIAction { [weak self] action in
                self?.dismiss(animated: true)
            }
            view.backButton.addAction(titleAction, for: .touchUpInside)
            return view
        case .customerInfo:
            let state = bookingInfo[section].getState()
            let view = BookingHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100),stateButton: state)
            view.label.text = BookingModel.numberTouirist[section - 1] + " Турист"
            view.button.isHidden = true
            view.section = section
            view.delegate = self
            return view
        case .touristData:
            let state = bookingInfo[section].getState()
            let view = BookingHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100),stateButton: state)
            view.label.text = BookingModel.numberTouirist[section - 1] + " Турист"
            view.section = section
            view.delegate = self
            if section == 10 {
                view.button.isUserInteractionEnabled = false
            }
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UINib(nibName: "BookingFooter", bundle: nil).instantiate(withOwner: nil).first as! BookingFooter
        switch bookingInfo[section] {
        case .customerInfo(_):
            footer.descriptionText.isHidden = false
            footer.descriptionView.layer.cornerRadius = 15
            footer.descriptionView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        default: break
        }
        return footer
    }
    
    
}


extension BookingController: BookingHeaderDelegate, InfoTouristDelegate {
    func buttonPressed(section: Int) {
        bookingInfo[section].changeSelectedState()
        tableView.reloadData()
        
        let row = tableView.numberOfRows(inSection: section)
        if row > 0 {
            tableView.scrollToRow(at: IndexPath(row: row - 1, section: section), at: .middle, animated: true)
        }
    }
    
    
    func textDidChange(text: String?,indexPath:IndexPath) {
        if indexPath.section == 1 {
            bookingInfo[indexPath.section].changeCustomerInfoData(newValue: text, row: indexPath.row)
        }else {
            bookingInfo[indexPath.section].changeTouristData(newValue: text, row: indexPath.row)
        }
    }
}
