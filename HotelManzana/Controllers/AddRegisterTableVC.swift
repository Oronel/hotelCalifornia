//
//  RegisterTableVC.swift
//  HotelManzana
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import UIKit

class AddRegisterTableVC: UITableViewController, SelectRommTypeDelegate {
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    var roomType : RoomType?

    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var checkInDateLbl: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLbl: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLbl: UILabel!
    
    
    
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
        
        updateDateView()
        updateNumberOfGuests()
        updateRoomType()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLbl.text = roomType.name
        }else{
            roomTypeLbl.text = "Not Set"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
            
        case (checkInDatePickerIndexPath.section, checkInDatePickerIndexPath.row):
            
            if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0
            }
        case (checkOutDatePickerIndexPath.section, checkOutDatePickerIndexPath.row):
           
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0
                }
        default:
            return 44.0
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
            
        case (checkInDatePickerIndexPath.section,checkInDatePickerIndexPath.row - 1):
            if isCheckInDatePickerShown{
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            }else{
                isCheckInDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (checkOutDatePickerIndexPath.section, checkOutDatePickerIndexPath.row - 1):
            if isCheckOutDatePickerShown{
                isCheckOutDatePickerShown = false
            }else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            }else{
                isCheckOutDatePickerShown = true
            }
                tableView.beginUpdates()
                tableView.endUpdates()
            
        default:
            break
        }
    }

    @IBAction func doneBarButton(_ sender: UIBarButtonItem) {
        let firstName = firstNameTxtField.text ?? ""
        let lastName = lastNameTxtField.text ?? ""
        let email = emailTxtField.text ?? ""
        
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        
        let wifiOn = wifiSwitch.isOn
        
        let roomChoice = roomType?.name ?? "Not Set"
        
        print("first name: \(firstName)")
        print("last name: \(lastName)")
        print("email: \(email)")
        
        print("check in date: \(checkInDate)")
        print("check out date: \(checkOutDate)")
        
        print("number of adults: \(numberOfAdults)")
        print("number of children: \(numberOfChildren)")
        
        print("has wifi: \(wifiOn)")
        
        print("RoomType: \(roomChoice)")
    }
    
    func updateDateView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLbl.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLbl.text = dateFormatter.string(from: checkOutDatePicker.date)
        
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    @IBAction func wifiChanged(_ sender: UISwitch) {
        
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        updateDateView()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }
}
