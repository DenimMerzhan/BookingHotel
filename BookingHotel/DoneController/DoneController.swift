//
//  DoneController.swift
//  BookingHotel
//
//  Created by Деним Мержан on 20.09.23.
//

import UIKit

class DoneController: UIViewController {

    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var separateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        separateView.alpha = 0.2
        doneButton.layer.cornerRadius = 15
    }
    

    @IBAction func doneButtonPressed(_ sender: UIButton) {
//        let main = UIStoryboard(name: "Main", bundle: nil)
//        let hotelController = main.instantiateViewController(withIdentifier: "HotelController") as! HotelController
//        self.navigationController?.pushViewController(hotelController, animated: true)

        
        
        guard let navigationController = self.navigationController else { return }
        let navigationArray = navigationController.viewControllers
        guard let hotelController = navigationArray.first else {return}
        self.navigationController?.popToViewController(hotelController, animated: true)
    }
    
}
