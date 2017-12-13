//
//  RegisterTableVC.swift
//  HotelManzana
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import UIKit

class RegisterTableVC: UITableViewController {

    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var checkInDateLbl: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLbl: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown : Bool = false {
        didSet{
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerShown : Bool = false{
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerIndexPath.section, checkInDatePickerIndexPath.row):
            return 0
        case (checkOutDatePickerIndexPath.section, checkOutDatePickerIndexPath.row):
            return 0
        default:
            return 44.0
        }
    }

    @IBAction func doneBarButton(_ sender: UIBarButtonItem) {
        let firstName = firstNameTxtField.text ?? ""
        let lastName = lastNameTxtField.text ?? ""
        let email = emailTxtField.text ?? ""
        
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        
        print("first name: \(firstName)")
        print("last name: \(lastName)")
        print("email: \(email)")
        
        print("check in date: \(checkInDate)")
        print("check out date: \(checkOutDate)")
    }
    
    func updateDateView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLbl.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLbl.text = dateFormatter.string(from: checkOutDatePicker.date)
        }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        updateDateView()
    }
    
}
