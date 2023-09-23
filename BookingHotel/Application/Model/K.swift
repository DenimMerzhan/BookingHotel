//
//  Constant.swift
//  BookingHotel
//
//  Created by Деним Мержан on 18.09.23.
//

import Foundation
import UIKit

struct K {
    
    static let color = Color()
    static let font = Font()
    
}


struct Color {
    
    let wrongDataColor = UIColor(named: "WrongDataColor")
    let separateColor = UIColor(named: "SeparateColor")
    let buttonColor = UIColor(named: "ButtonColor")
    let tintTextTagColor = UIColor(named: "TintAboutHotel")
}

struct Font {
    
    let tagCell = UIFont.systemFont(ofSize: 16, weight: .medium)
    
}
