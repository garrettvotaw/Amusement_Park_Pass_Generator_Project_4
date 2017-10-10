//
//  ViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/8/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var vendorStackView: UIStackView!
    @IBOutlet weak var guestStackview: UIStackView!
    @IBOutlet weak var employeeStackview: UIStackView!
    @IBOutlet weak var managerStackView: UIStackView!
    @IBOutlet weak var DOBtextField: UITextField!
    @IBOutlet weak var ssnTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    let nextVC = SecondViewController()
    var arrayOfTextFields: [UITextField] = []
    var selectedButton: Button? = nil
    var selectedCompany: Company? = nil
    var pass: Pass? = nil
    
    let clearColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfTextFields.append(contentsOf: [DOBtextField, ssnTextField, projectTextField, firstNameTextField, lastNameTextField, companyTextField, stateTextField, streetAddressTextField, cityTextField, zipTextField])
        resetDisplay()
    }

    // MARK: UI Buttons for Showing Hiding
    @IBAction func guestButton(_ sender: Any) {
        guestStackview.isHidden = false
        employeeStackview.isHidden = true
        managerStackView.isHidden = true
        vendorStackView.isHidden = true
        
    }
    @IBAction func employeeButton(_ sender: Any) {
        employeeStackview.isHidden = false
        guestStackview.isHidden = true
        managerStackView.isHidden = true
        vendorStackView.isHidden = true
    }
    @IBAction func managerButton(_ sender: Any) {
        employeeStackview.isHidden = true
        guestStackview.isHidden = true
        managerStackView.isHidden = false
        vendorStackView.isHidden = true
    }
    @IBAction func vendorButton(_ sender: Any) {
        employeeStackview.isHidden = true
        guestStackview.isHidden = true
        managerStackView.isHidden = true
        vendorStackView.isHidden = false
    }
    
    @IBAction func guestButtons(_ sender: UIButton) {
        resetDisplay()
        switch sender.tag {
        case 0:
            DOBtextField.isEnabled = true
            DOBtextField.backgroundColor = .white
            selectedButton = .child
        case 1: selectedButton = .adult
        case 2:
            firstNameTextField.isEnabled = true
            firstNameTextField.backgroundColor = .white
            lastNameTextField.isEnabled = true
            lastNameTextField.backgroundColor = .white
            DOBtextField.isEnabled = true
            DOBtextField.backgroundColor = .white
            selectedButton = .senior
        case 3: selectedButton = .vip
        case 4:
            firstNameTextField.isEnabled = true
            firstNameTextField.backgroundColor = .white
            lastNameTextField.isEnabled = true
            lastNameTextField.backgroundColor = .white
            DOBtextField.isEnabled = true
            DOBtextField.backgroundColor = .white
            streetAddressTextField.isEnabled = true
            streetAddressTextField.backgroundColor = .white
            cityTextField.isEnabled = true
            cityTextField.backgroundColor = .white
            stateTextField.isEnabled = true
            stateTextField.backgroundColor = .white
            zipTextField.isEnabled = true
            zipTextField.backgroundColor = .white
            selectedButton = .seasonPass
        default: break
        }
    }
    
    @IBAction func employeeButtons(_ sender: UIButton) {
        resetDisplay()
        enableEmployeeFields()
        switch sender.tag {
        case 0: selectedButton = .foodEmployee
        case 1: selectedButton = .rideEmployee
        case 2: selectedButton = .maintenanceEmployee
        case 3:
            projectTextField.isEnabled = true
            projectTextField.backgroundColor = .white
            selectedButton = .contractorEmployee
        default: break
        }
    }
    
    @IBAction func managerButtons(_ sender: UIButton) {
        resetDisplay()
        enableEmployeeFields()
        switch sender.tag {
        case 0: selectedButton = .shiftManager
        case 1: selectedButton = .generalManager
        case 2: selectedButton = .seniorManager
        default: break
        }
    }
    
    @IBAction func vendorButtons(_ sender: UIButton) {
        selectedButton = .vendor
        resetDisplay()
        firstNameTextField.isEnabled = true
        firstNameTextField.backgroundColor = .white
        lastNameTextField.isEnabled = true
        lastNameTextField.backgroundColor = .white
        DOBtextField.isEnabled = true
        DOBtextField.backgroundColor = .white
        companyTextField.isEnabled = true
        companyTextField.backgroundColor = .white
        switch sender.tag {
        case 0: selectedCompany = Company.acme
        case 1: selectedCompany = Company.orkin
        case 2: selectedCompany = Company.fedex
        case 3: selectedCompany = Company.nwElectrical
        default: break
        }
    }
    
    
    
    
    // MARK: Create Pass Button
    @IBAction func createPass() {
        do {
            let birthday = try getBirthday()
            if selectedButton == .child {
                do {
                    let guest = try Guest(DOB: birthday!)
                    ConnectionHandler.pass = Pass(enterant: guest, name: "Child Pass", entrantType: .guest)
                    presentNextView()
                } catch ParkPassError.invalidBirthday {
                    print("Please Provide a valid birthday")
                } catch {
                    print(error)
                }
            } else if selectedButton == .adult {
                let guest = Guest(isVIP: false)
                ConnectionHandler.pass = Pass(enterant: guest, name: firstNameTextField.text!, entrantType: .guest)
                presentNextView()
            } else if selectedButton == .senior {
                do {
                    let guest = try Guest(isVIP: false, guestType: .senior, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday, streetAddress: nil, city: nil, zipcode: nil)
                    ConnectionHandler.pass = Pass(enterant: guest, name: guest.firstName! + " " + guest.lastName!, entrantType: .guest)
                    presentNextView()
                } catch {
                    print(error)
                }
            } else if selectedButton == .vip {
                let guest = Guest(isVIP: true)
                ConnectionHandler.pass = Pass(enterant: guest, name: "VIP Pass", entrantType: .guest)
                presentNextView()
            } else if selectedButton == .seasonPass {
                do {
                    let guest = try Guest(isVIP: false, guestType: .seasonPass, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday, streetAddress: streetAddressTextField.text!, city: cityTextField.text!, zipcode: zipTextField.text!)
                    ConnectionHandler.pass = Pass(enterant: guest, name: guest.firstName! + " " + guest.lastName!, entrantType: .guest)
                    presentNextView()
                } catch {
                    print(error)
                }
            } else if selectedButton == .foodEmployee {
                do {
                    let employee = try Employee(employeeType: .foodService, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday!, streetAddress: streetAddressTextField.text!, city: cityTextField.text!, zipcode: zipTextField.text!, ssn: ssnTextField.text!, managementTier: nil , projectNumber: nil)
                    ConnectionHandler.pass = Pass(enterant: employee, name: firstNameTextField.text! + " " + lastNameTextField.text!, entrantType: .employee)
                    presentNextView()
                } catch ParkPassError.invalidAddress {
                    print("Address Is Invalid")
                } catch ParkPassError.invalidName {
                    print("Please Enter a valid name for both First and Last name")
                } catch {
                    print("\(error)")
                }
            } else if selectedButton == .rideEmployee {
                do {
                    let employee = try Employee(employeeType: .rideService, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday!, streetAddress: streetAddressTextField.text!, city: cityTextField.text!, zipcode: zipTextField.text!, ssn: ssnTextField.text!, managementTier: nil, projectNumber: nil)
                    ConnectionHandler.pass = Pass(enterant: employee, name: "\(firstNameTextField.text!) \(lastNameTextField.text!)", entrantType: .employee)
                    presentNextView()
                } catch ParkPassError.invalidAddress {
                    print("Address Is Invalid")
                } catch ParkPassError.invalidName {
                    print("Please Enter a valid name for both First and Last name")
                } catch {
                    print("\(error)")
                }
            } else if selectedButton == .maintenanceEmployee {
                do {
                    let employee = try Employee(employeeType: .maintenance, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday!, streetAddress: streetAddressTextField.text!, city: cityTextField.text!, zipcode: zipTextField.text!, ssn: ssnTextField.text!, managementTier: nil, projectNumber: nil)
                    ConnectionHandler.pass = Pass(enterant: employee, name: "\(firstNameTextField.text!) \(lastNameTextField.text!)", entrantType: .employee)
                    presentNextView()
                } catch ParkPassError.invalidAddress {
                    print("Address Is Invalid")
                } catch ParkPassError.invalidName {
                    print("Please Enter a valid name for both First and Last name")
                } catch {
                    print("\(error)")
                }
            } else if selectedButton == Button.contractorEmployee {
                do {
                    let employee = try Employee(employeeType: .contractor, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday!, streetAddress: streetAddressTextField.text!, city: cityTextField.text!, zipcode: zipTextField.text!, ssn: ssnTextField.text!, managementTier: nil, projectNumber: nil)
                    ConnectionHandler.pass = Pass(enterant: employee, name: "\(firstNameTextField.text!) \(lastNameTextField.text!)", entrantType: .employee)
                    presentNextView()
                } catch ParkPassError.invalidAddress {
                    print("Address Is Invalid")
                } catch ParkPassError.invalidName {
                    print("Please Enter a valid name for both First and Last name")
                } catch {
                    print("\(error)")
                }
            } else if selectedButton == Button.shiftManager {
                do {
                    let employee = try Employee(employeeType: .manager, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday!, streetAddress: streetAddressTextField.text!, city: cityTextField.text!, zipcode: zipTextField.text!, ssn: ssnTextField.text!, managementTier: .shiftManager, projectNumber: nil)
                    ConnectionHandler.pass = Pass(enterant: employee, name: "\(firstNameTextField.text!) \(lastNameTextField.text!)", entrantType: .employee)
                    presentNextView()
                } catch ParkPassError.invalidAddress {
                    print("Address Is Invalid")
                } catch ParkPassError.invalidName {
                    print("Please Enter a valid name for both First and Last name")
                } catch {
                    print("\(error)")
                }
            } else if selectedButton == Button.generalManager {
                do {
                    let employee = try Employee(employeeType: .manager, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday!, streetAddress: streetAddressTextField.text!, city: cityTextField.text!, zipcode: zipTextField.text!, ssn: ssnTextField.text!, managementTier: .generalManager, projectNumber: nil)
                    ConnectionHandler.pass = Pass(enterant: employee, name: "\(firstNameTextField.text!) \(lastNameTextField.text!)", entrantType: .employee)
                    presentNextView()
                } catch ParkPassError.invalidAddress {
                    print("Address Is Invalid")
                } catch ParkPassError.invalidName {
                    print("Please Enter a valid name for both First and Last name")
                } catch {
                    print("\(error)")
                }
            } else if selectedButton == Button.seniorManager {
                do {
                    let employee = try Employee(employeeType: .manager, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday!, streetAddress: streetAddressTextField.text!, city: cityTextField.text!, zipcode: zipTextField.text!, ssn: ssnTextField.text!, managementTier: .seniorManager, projectNumber: nil)
                    ConnectionHandler.pass = Pass(enterant: employee, name: "\(firstNameTextField.text!) \(lastNameTextField.text!)", entrantType: .employee)
                    presentNextView()
                } catch ParkPassError.invalidAddress {
                    print("Address Is Invalid")
                } catch ParkPassError.invalidName {
                    print("Please Enter a valid name for both First and Last name")
                } catch {
                    print("\(error)")
                }
            } else if selectedButton == Button.vendor {
                let vendor = Vendor(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, DOB: birthday!, dateOfVisit: Date(), company: selectedCompany!)
                ConnectionHandler.pass = Pass(enterant: vendor, name: "\(firstNameTextField.text!) \(lastNameTextField.text!)", entrantType: .vendor)
                presentNextView()
            }
        } catch ParkPassError.invalidBirthday {
            print("Please enter a valid Birthday")
        } catch ParkPassError.invalidName {
            print("Please Enter a valid name for both First and Last name")
        } catch {
            print(error)
        }
    }
    
    @IBAction func populateData() {
        for field in arrayOfTextFields {
            if field.isEnabled {
                switch field.tag {
                case 0: if selectedButton == .child { field.text = "10/20/2014" } else { field.text = "10/10/1940" }
                case 1: field.text = "123-456-7890"
                case 2: field.text = "1001"
                case 3: field.text = "Joe"
                case 4: field.text = "Smith"
                case 5: field.text = "Orkin"
                case 6: field.text = "1234 Developers St"
                case 7: field.text = "Cupertino"
                case 8: field.text = "CA"
                case 9: field.text = "12345"
                default: break
                }
            }
        }
    }
    
    // Helper function
    
    func resetDisplay() {
        DOBtextField.isEnabled = false
        DOBtextField.backgroundColor = clearColor
        DOBtextField.text = ""
        ssnTextField.isEnabled = false
        ssnTextField.backgroundColor = clearColor
        ssnTextField.text = ""
        projectTextField.isEnabled = false
        projectTextField.backgroundColor = clearColor
        projectTextField.text = ""
        firstNameTextField.isEnabled = false
        firstNameTextField.backgroundColor = clearColor
        firstNameTextField.text = ""
        lastNameTextField.isEnabled = false
        lastNameTextField.backgroundColor = clearColor
        lastNameTextField.text = ""
        companyTextField.isEnabled = false
        companyTextField.backgroundColor = clearColor
        companyTextField.text = ""
        streetAddressTextField.isEnabled = false
        streetAddressTextField.backgroundColor = clearColor
        streetAddressTextField.text = ""
        cityTextField.isEnabled = false
        cityTextField.backgroundColor = clearColor
        cityTextField.text = ""
        stateTextField.isEnabled = false
        stateTextField.backgroundColor = clearColor
        stateTextField.text = ""
        zipTextField.isEnabled = false
        zipTextField.backgroundColor = clearColor
        zipTextField.text = ""
    }
    
    func enableEmployeeFields() {
        firstNameTextField.isEnabled = true
        firstNameTextField.backgroundColor = .white
        lastNameTextField.isEnabled = true
        lastNameTextField.backgroundColor = .white
        DOBtextField.isEnabled = true
        DOBtextField.backgroundColor = .white
        streetAddressTextField.isEnabled = true
        streetAddressTextField.backgroundColor = .white
        cityTextField.isEnabled = true
        cityTextField.backgroundColor = .white
        stateTextField.isEnabled = true
        stateTextField.backgroundColor = .white
        zipTextField.isEnabled = true
        zipTextField.backgroundColor = .white
        ssnTextField.isEnabled = true
        ssnTextField.backgroundColor = .white
    }
    
    func getBirthday() throws -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        if selectedButton == .adult || selectedButton == .vip {
            return nil
        } else if DOBtextField.text == ""{
            throw ParkPassError.invalidBirthday
        }
        guard let birthday = formatter.date(from: DOBtextField.text!) else {
            throw ParkPassError.invalidBirthday
        }
        return birthday
    }
    
    func presentNextView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "secondView")
        present(nextView, animated: true, completion: nil)
    }
}

enum Button {
    case child
    case adult
    case senior
    case vip
    case seasonPass
    case foodEmployee
    case rideEmployee
    case maintenanceEmployee
    case contractorEmployee
    case shiftManager
    case generalManager
    case seniorManager
    case vendor
}
