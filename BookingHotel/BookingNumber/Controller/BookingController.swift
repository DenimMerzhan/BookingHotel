//
//  BookingController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 06.09.23.
//

import UIKit

class BookingController: UITableViewController {

    var bookingInfo = [BookingInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        let fly = BookingDetails(deatails: "Вылет из", descripiton: "Санкт-Петерубрг")
       
        
        var details = [BookingDetails]()
        for _ in 0...8 {
            details.append(fly)
        }
        
        bookingInfo.append(.bookingDetails(details))
        bookingInfo.append(.customerInfo([.phoneNumber("+7 981 755 00 00"),.email("dagn456@mail.ru")]))
        
        
        
        tableView.register(UINib(nibName: "BookingDetailesCell", bundle: nil), forCellReuseIdentifier: "BookingDetailesCell")
        tableView.register(UINib(nibName: "InfoTouirist", bundle: nil), forCellReuseIdentifier: "InfoTouirist")
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none

        
    }

    

}

// MARK: - Table view data source


extension BookingController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return bookingInfo.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch bookingInfo[section] {
            
        case .bookingDetails(let bookingDetails):
            return bookingDetails.count
        case .customerInfo(_):
            return 2
        case .touristData(_):
            return 6
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch bookingInfo[indexPath.section] {
            
        case .bookingDetails(let bookingDetails):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDetailesCell") as! BookingDetailesCell
            let details = bookingDetails[indexPath.row]
            cell.details.text = details.deatails
            cell.descriptionDetails.text = details.descripiton
            
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
            let info = customerInfo[indexPath.row]
            switch info {
            case .phoneNumber(let text):
                cell.textField.text = text
                cell.upPlaceHolder.text = "Номер телефона"
            case .email(let text):
                cell.textField.text = text
                cell.upPlaceHolder.text = "Почта"
            }
            return cell
        case .touristData(_):
            print("wow")
        }
        
        return UITableViewCell()
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch bookingInfo[section] {
        case .bookingDetails(_):
            return 100
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch bookingInfo[section] {
        case .bookingDetails(_):
            return 20
        default: return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch bookingInfo[section] {
        case .bookingDetails(_):
            let view = UINib(nibName: "TitleHedear", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TitleHedear
            view.upSeparateView.isHidden = true
            return view
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch bookingInfo[section] {
        case .bookingDetails(_):
            let footer = createSeparateFooter()
            return footer
        default: return nil
        }
    }
    
    
}


extension BookingController {
    
    func createSeparateFooter() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
        footer.backgroundColor = UIColor(named: "SeparateCollectionView")
        return footer
    }
    
}
