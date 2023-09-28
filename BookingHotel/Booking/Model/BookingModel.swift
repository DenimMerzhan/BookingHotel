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
    
    
    var numberOfsection: Int {
        get {
            return bookingInfo.count
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        switch bookingInfo[section] {
        case .aboutHotel(_),.pay: return 1
        case .bookingDetails(let bookingDetails):
            return bookingDetails.count
        case .customerInfo:
            return customerInfoPlaceholder.count
        case .tourist (let touristData):
            switch touristData.buttonState {
            case .selected:
                return touristDataPlaceholder.count
            default: return 0
            }
        case .result(let bookingDetails): return bookingDetails.count
        }
    }
    
    
    init(bookingInfoJson: BookingInfoJson,hotelDescription: HotelDescription, room: Room) {
        fillBookingInfo(bookingInfoJson: bookingInfoJson, hotelDescription: hotelDescription, room: room)
    }
    
    mutating func fillBookingInfo(bookingInfoJson: BookingInfoJson,hotelDescription: HotelDescription, room: Room) {
        
        let departure = BookingDetails(deatails: "Вылет из",descripiton: bookingInfoJson.departure)
        let arrivalCountry = BookingDetails(deatails: "Страна, город",descripiton: bookingInfoJson.arrival_country)
        let dates = BookingDetails(deatails: "Даты",descripiton: bookingInfoJson.tour_date_start + "-" + bookingInfoJson.tour_date_stop)
        let numberOfNights = BookingDetails(deatails: "Кол-Во ночей",descripiton: String(bookingInfoJson.number_of_nights))
        let hotelName = BookingDetails(deatails: "Отель",descripiton: hotelDescription.nameHotel)
        let roomDescription = BookingDetails(deatails: "Номер",descripiton: room.name)
        let nutrition = BookingDetails(deatails: "Питание",descripiton: bookingInfoJson.nutrition)
        
        let flyDetails = [departure,arrivalCountry,dates,numberOfNights,hotelName,roomDescription,nutrition]
        
        let tourPrice = BookingDetails(deatails: "Тур",descripiton: HotelModel.shared.formatPrice(text: String(Int(room.price))) + " ₽")
        let fuelCharge = BookingDetails(deatails: "Тур",descripiton: HotelModel.shared.formatPrice(text: String(Int(room.fuelCharge))) + " ₽")
        let serviceCharge = BookingDetails(deatails: "Тур",descripiton: HotelModel.shared.formatPrice(text: String(Int(room.serviceCharge))) + " ₽")
        let finalPrice = room.price + room.fuelCharge + room.serviceCharge
        let finalPriceString = BookingDetails(deatails: "Тур",descripiton: HotelModel.shared.formatPrice(text: String(Int(finalPrice))) + " ₽")
        
        let priceArr = [tourPrice,fuelCharge,serviceCharge,finalPriceString]
        
        bookingInfo.append(.aboutHotel(HotelDescription(grade: hotelDescription.grade, raitingName: hotelDescription.raitingName, nameHotel: hotelDescription.nameHotel, adressHotel: hotelDescription.adressHotel, price: 0, priceForIt: " ")))
        
        bookingInfo.append(.bookingDetails(flyDetails))
        bookingInfo.append(.customerInfo(CustomerInfo()))
        bookingInfo.append(.tourist(.init(buttonState: .notTouch)))
        bookingInfo.append(.tourist(.init(buttonState: .notTouch)))
        bookingInfo.append(.result(priceArr))
        bookingInfo.append(.pay(HotelModel.shared.formatPrice(text: String(Int(finalPrice))) + " ₽"))
        
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
    
    func validateBooking(tourist: Tourist,customerInfo: CustomerInfo, bookingInfo: [BookingInfo]) -> Bool {
        
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

//MARK: - ValidateUser

extension BookingModel {
    
    func isUserValidate() -> Bool {
        switch bookingInfo[2] {
        case .customerInfo(let customerInfo):
            switch bookingInfo[3] {
            case .tourist(let tourist):
                if validateBooking(tourist: tourist, customerInfo: customerInfo,bookingInfo: bookingInfo) {
                    return true
                }else {
                    return false
                }
            default: break
            }
        default: break
        }
        return false
    }
}
