//
//  BookingFooter.swift
//  BookingHotel
//
//  Created by Деним Мержан on 07.09.23.
//

import Foundation
import UIKit

protocol BookingHeaderDelegate {
    
    func buttonPressed(section: Int, isAddTourist: Bool)
}

class BookingHeader: UIView {
    
    var button = UIButton()
    var label = UILabel()
    var section =  Int()
    var delegate: BookingHeaderDelegate?
    var isAddTourist = false
    
    
    
    init(frame: CGRect,stateButton: ButtonTouiristState?) {
        super.init(frame: frame)
        setupView()
        if let state = stateButton {
            setupButton(stateButton: state)
        }else {setupWithoutButton()}
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(){
        
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.axis = .horizontal
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 15).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -15).isActive = true
        label.font = .systemFont(ofSize: 25, weight: .medium)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
    }
    
    func setupWithoutButton(){
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    func setupButton(stateButton:ButtonTouiristState){
        
        button.layer.cornerRadius = 10
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        let largeConfing = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium, scale: .medium)
        var image: UIImage?
        
        switch stateButton {
            
        case .selected:
            button.backgroundColor = UIColor(named: "LastTagColor")
            image = UIImage(systemName: "chevron.up",withConfiguration: largeConfing)
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        case .notSelected:
            button.backgroundColor = UIColor(named: "LastTagColor")
            image = UIImage(systemName: "chevron.down",withConfiguration: largeConfing)
        case .notTouch:
            image = UIImage(systemName: "plus",withConfiguration: largeConfing)?.withRenderingMode(.alwaysTemplate)
            button.tintColor = .white
            button.backgroundColor = UIColor(named: "ButtonColor")
        }
        
        button.setImage(image, for: .normal)
        
    }
    
    @objc func buttonPressed(){
        delegate?.buttonPressed(section: section,isAddTourist: isAddTourist)
    }
    
}
