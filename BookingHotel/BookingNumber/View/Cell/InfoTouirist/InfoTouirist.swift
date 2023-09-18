//
//  InfoUserCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 07.09.23.
//

import UIKit

protocol InfoTouristDelegate {
    func textDidChange(text:String?,indexPath: IndexPath)
}

class InfoTouirist: UITableViewCell {
    
    
    @IBOutlet weak var upPlaceHolder: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var view: UIView!
    
    var delegate: InfoTouristDelegate?
    var isUsedMaskNumber = Bool()
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        view.layer.cornerRadius = 10
        textField.borderStyle = .none
        textField.delegate = self
        upPlaceHolder.isHidden = true
    }
    
    override func prepareForReuse() {
        upPlaceHolder.isHidden = true
        textField.text = ""
        isUsedMaskNumber = false
        view.backgroundColor = UIColor(named: "SeparateCollectionView")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func textChanged(_ sender: UITextField) {
        upPlaceHolder.text = textField.placeholder
        if sender.text?.count == 0 {
            upPlaceHolder.isHidden = true
        }else {
            upPlaceHolder.isHidden = false
        }
        delegate?.textDidChange(text: sender.text,indexPath: indexPath)
    }
    
}


extension InfoTouirist: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if isUsedMaskNumber == false {return true}
        guard let text = textField.text else {
            return false
        }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formatter(mask: "+X (XXX) XXX XX-XX", phoneNumber: newString)
        upPlaceHolder.text = textField.placeholder
        
        return false
    }
    
    func formatter(mask:String,phoneNumber: String) -> String {
        
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "",options: .regularExpression)
        
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
                
            }else {
                result.append(character)
            }
            
        }
        
        if result == "" {
            upPlaceHolder.isHidden = true
        }else {
            upPlaceHolder.isHidden = false
        }
        delegate?.textDidChange(text: result, indexPath: indexPath)
        return result
    }
}
