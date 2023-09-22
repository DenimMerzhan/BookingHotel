//
//  BookingModel.swift
//  BookingHotel
//
//  Created by Деним Мержан on 08.09.23.
//

import Foundation


struct BookingModel {
    
    var bookingInfo = [BookingInfo]()
    
    let touristDataPlaceholder = ["Имя","Фамилия","Дата рождения","Гражданство","Номер загранпаспорта","Срок действия загран паспорта"]
    let customerInfoPlaceholder = ["Номер телефона","Почта"]
    let numberTouirist = ["Первый","Второй","Третий","Четвертый","Пятый","Шестой","Седьмой","Восьмой","Девятый","Десятый"]
    let descriptionPlacheholder = ["Вылет из","Cтрана,город","Даты","Кол-во ночей","Отель","Номер","Питание"]
    
    init(){
        fillBookingInfo()
    }
    
    
    
    mutating func fillBookingInfo(){
        
        let fly = BookingDetails(deatails: "Вылет из", descripiton: "Санкт-Петербург")
        var details = [BookingDetails]()
        for _ in 0...8 {
            details.append(fly)
        }
        
        var resultArr = [BookingDetails]()
        let detail = BookingDetails(deatails: "Тур", descripiton: "186 000р")
        for _ in 0...3 {
            resultArr.append(detail)
        }
        
        bookingInfo.append(.aboutHotel(HotelDescription(grade: 5, descripitonGrade: "Класс", nameHotel: "Осень", adressHotel: "dwwddw")))
        bookingInfo.append(.bookingDetails(details))
        bookingInfo.append(.customerInfo(CustomerInfo()))
        bookingInfo.append(.tourist(.init(buttonState: .notTouch)))
        bookingInfo.append(.tourist(.init(buttonState: .notTouch)))
        bookingInfo.append(.result(resultArr))
        bookingInfo.append(.pay)
    }
    
    func getDescriptionStatus(tourist: Tourist,row: Int) -> (description:String?,isValid: Bool) {
        var description: String?
        var isValid = Bool()
        switch row {
        case 0:
            description = tourist.name
            isValid = description.isValidName()
        case 1:
            description = tourist.family
            isValid = description.isValidName()
        case 2:
            description = tourist.dateOfBirth
            isValid = description.isValidDateOfBirth()
        case 3:
            description = tourist.citizenship
            isValid =  description.isValidName()
        case 4:
            description = tourist.numberPassport
            isValid = description.isValidPassport()
        default:
            description = tourist.validityPeriodPassport
            isValid = description.isValidDateOfBirth()
        }
        return (description,isValid)
    }
}

//MARK: - ValidateBooking

extension BookingModel {
    
    func validateBooking(tourist: Tourist,customerInfo: CustomerInfo) -> Bool {
        
        for i in 0...bookingInfo.count - 1 {
            switch bookingInfo[i] {
            case .tourist(let tourist):
                if validateTourist(tourist: tourist, indexTourist: i) == false {return false}
            default: break
            }
        }
        
        if customerInfo.email.isValidEmail() == false || customerInfo.phoneNumber.isValidPhoneNumber() == false {return false}
        
        return true
    }
    
    private func validateTourist(tourist: Tourist,indexTourist: Int) -> Bool {
        if tourist.isTouristEmpty() && indexTourist != 3 {
            return true
        }
        for i in 0...5 {
            let isValidDescription = getDescriptionStatus(tourist: tourist, row: i).isValid
            if isValidDescription == false {
                return false
            }
        }
        return true
    }
}
