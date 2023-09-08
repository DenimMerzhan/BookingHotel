//
//  BookingController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 06.09.23.
//

import UIKit

class BookingController: UIViewController {

    var bookingInfo = [BookingInfo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
        
        let fly = BookingDetails(deatails: "Вылет из", descripiton: "Санкт-Петербург")
       
        
        var details = [BookingDetails]()
        for _ in 0...8 {
            details.append(fly)
        }
        
        bookingInfo.append(.bookingDetails(details))
        bookingInfo.append(.customerInfo)
        bookingInfo.append(.touristData(.notTouch))
        bookingInfo.append(.touristData(.notTouch))
        
        
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
            return BookingModel.customerInfo.count
        case .touristData (let state):
            switch state {
            case .selected:
                return BookingModel.touristData.count
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
        case .customerInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTouirist") as! InfoTouirist
            let placeHolderText = BookingModel.customerInfo[indexPath.row]
            cell.textField.placeholder = placeHolderText
            cell.selectionStyle = .none
            if indexPath.row == 1 {
                cell.contentView.layer.cornerRadius = 15
                cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            }
            return cell
        case .touristData(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTouirist") as! InfoTouirist
            cell.textField.placeholder = BookingModel.touristData[indexPath.row]
            cell.selectionStyle = .none
            if indexPath.row == BookingModel.touristData.count - 1 {
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
        case .bookingDetails(_):
            return 20
        default: return 10
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch bookingInfo[section] {
        case .bookingDetails(_):
            let view = UINib(nibName: "TitleHedear", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TitleHedear
            view.upSeparateView.isHidden = true
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
        switch bookingInfo[section] {
        case .bookingDetails(_):
            let footer = createSeparateFooter()
            return footer
        default: let footer = createSeparateFooter()
            return footer
        }
    }
    
    
}


extension BookingController {
    
    func createSeparateFooter() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 10))
        footer.backgroundColor = UIColor(named: "SeparateCollectionView")
        return footer
    }
    
}

extension BookingController: BookingHeaderDelegate {
    func buttonPressed(section: Int) {
        bookingInfo[section].changeSelectedState()
        tableView.reloadData()
    
        
        let row = tableView.numberOfRows(inSection: section)
        if row > 0 {
            tableView.scrollToRow(at: IndexPath(row: row - 1, section: section), at: .middle, animated: true)
        }
    }
    
}
