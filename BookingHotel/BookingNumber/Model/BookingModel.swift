//
//  BookingModel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 08.09.23.
//

import Foundation


struct BookingModel {
    
    static let touristDataPlaceholder = ["Имя","Фамилия","Дата рождения","Гражданство","Номер загранпаспорта","Срок действия загран паспорта"]
    static let customerInfoPlaceholder = ["Номер телефона","Почта"]
    static let numberTouirist = ["Первый","Второй","Третий","Четвертый","Пятый","Шестой","Седьмой","Восьмой","Девятый","Десятый"]
    static let descriptionPlacheholder = ["Вылет из","Cтрана,город","Даты","Кол-во ночей","Отель","Номер","Питание"]
    
    
    static func getDescriptionStatus(tourist: Tourist,row: Int) -> (description:String?,isValid: Bool) {
        var description: String?
        var isValid = Bool()
        switch row {
        case 0:
            description = tourist.name
            isValid = description.isValidName()
        case 1:
            description = tourist.family
        case 2:
            description = tourist.dateOfBirth
        case 3:
            description = tourist.citizenship
        case 4:
            description = tourist.numberPassport
        default:
            description = tourist.validityPeriodPassport
        }
        return (description,isValid)
    }
}
