//
//  InfoUserCell.swift
//  BookingHotel
//
//  Created by Деним Мержан on 07.09.23.
//

import UIKit

class InfoTouirist: UITableViewCell {
    
    
    @IBOutlet weak var upPlaceHolder: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
        textField.borderStyle = .none
        textField.delegate = self
        upPlaceHolder.isHidden = true
    }
    
    override func prepareForReuse() {
        upPlaceHolder.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}


extension InfoTouirist: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
        
        return result
    }
}
