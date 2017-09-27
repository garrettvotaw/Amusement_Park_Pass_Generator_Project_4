//
//  ViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/8/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    let clearColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DOBtextField.backgroundColor = clearColor
        ssnTextField.backgroundColor = clearColor
        projectTextField.backgroundColor = clearColor
        firstNameTextField.backgroundColor = clearColor
        lastNameTextField.backgroundColor = clearColor
        companyTextField.backgroundColor = clearColor
        streetAddressTextField.backgroundColor = clearColor
        cityTextField.backgroundColor = clearColor
        stateTextField.backgroundColor = clearColor
        zipTextField.backgroundColor = clearColor
//        //CHILD
//        do {
//            let child = try Guest(DOB: Date())
//            if let childPass = Pass(enterant: child, name: "Tommy", entrantType: .guest) {
//                print (childPass.swipePass(for: .amusement))
//                print (childPass.swipePass(for: .kitchen))   //Intentional failure case to test Access Denial
//            }
//        } catch ParkPassError.invalidBirthday {
//            print("Please Provide a valid birthday")
//        } catch {
//            print("\(error)")
//        }
        
        
        
//        //CLASSIC
//        let classicGuest = Guest(isVIP: false)
//        if let classicPass = Pass(enterant: classicGuest, name: "", entrantType: .guest) {
//            print (classicPass.swipePass(for: .allRides))
//            print (classicPass.swipePass(for: .amusement))
//        }
        
        
        
//        //VIP
//        let vipGuest = Guest(isVIP: true)
//        if let vipPass = Pass(enterant: vipGuest, name: "", entrantType: .guest) {
//            print (vipPass.swipePass(for: .allRides))
//            print (vipPass.swipePass(for: .skipLines))
//            print (vipPass.swipePass(forDiscount: (vipPass.shoppingDiscounts?.0)!))
//        }
        
        
        
//        //FOOD SERVICE
//        do {
//            let foodService = try Employee(employeeType: .foodService, firstName: "Bob", lastName: "", DOB: nil, streetAddress: "123 nowhere", city: "lalaLand", zipcode: "12345")
//            let foodPass = Pass(enterant: foodService, name: foodService.firstName, entrantType: .employee)
//            print(foodPass!.swipePass(for: .kitchen))
//            print(foodPass!.swipePass(for: .allRides))
//        } catch ParkPassError.invalidAddress {
//            print("Address Is Invalid")
//        } catch ParkPassError.invalidName {
//            print("Please Enter a valid name for both First and Last name")
//        } catch {
//            print("\(error)")
//        }
        
        
        
//        //RIDE SERVICE
//        do {
//            let rideService = try Employee(employeeType: .rideService, firstName: "Muffin", lastName: "Man", DOB: nil, streetAddress: "326 Dreary Ln", city: "Muffin Land", zipcode: "42683")
//            let ridePass = Pass(enterant: rideService, name: rideService.firstName, entrantType: .employee)
//            print(ridePass!.swipePass(for: .rideControl))
//            print(ridePass!.swipePass(for: .allRides))
//        } catch ParkPassError.invalidAddress {
//            print("Address Is Invalid")
//        } catch ParkPassError.invalidName {
//            print("Please Enter a valid name for both First and Last name")
//        } catch {
//            print("\(error)")
//        }
        
        
        
//        //MAINTENANCE
//        do {
//            let maintenance = try Employee(employeeType: .maintenance, firstName: "", lastName: "", DOB: nil, streetAddress: "091 Swifty Dr", city: "Cupertino", zipcode: "01923")
//            if let maintenancePass = Pass(enterant: maintenance, name: maintenance.firstName, entrantType: .employee) {
//                print(maintenancePass.swipePass(for: .allRides))
//                print(maintenancePass.swipePass(for: .maintenance))
//            }
//        } catch ParkPassError.invalidAddress {
//            print("Address Is Invalid")
//        } catch ParkPassError.invalidName {
//            print("Please Enter a valid name for both First and Last name")
//        } catch {
//            print("\(error)")
//        }
        
        
        
                //MANAGER
//        do {
//            let manager = try Employee(employeeType: .manager, firstName: "Tom", lastName: "Pickles", DOB: Date(), streetAddress: "1", city: "1", zipcode: "1", ssn: "1", managementTier: .generalManager)
//            if let managerPass = Pass(enterant: manager, name: manager.firstName, entrantType: .employee) {
//                print(managerPass.swipePass(for: .allRides))
//                print(managerPass.swipePass(for: .office))
//                print(managerPass.swipePass(forDiscount: managerPass.shoppingDiscounts!.1))
//            }
//        } catch ParkPassError.invalidAddress {
//            print("Address Is Invalid")
//        } catch ParkPassError.invalidName {
//            print("Please Enter a valid name for both First and Last name")
//        } catch ParkPassError.invalidSocial {
//            print("Please Enter a valid Social")
//        } catch {
//            print("\(error)")
//        }
        
        
    }

    
    @IBAction func guestButton(_ sender: Any) {
        guestStackview.isHidden = false
        employeeStackview.isHidden = true
        managerStackView.isHidden = true
        
    }
    @IBAction func employeeButton(_ sender: Any) {
        employeeStackview.isHidden = false
        guestStackview.isHidden = true
        managerStackView.isHidden = true
        firstNameTextField.backgroundColor = .white
        lastNameTextField.backgroundColor = .white
    }
    @IBAction func managerButton(_ sender: Any) {
        employeeStackview.isHidden = true
        guestStackview.isHidden = true
        managerStackView.isHidden = false
    }
    @IBAction func vendorButton(_ sender: Any) {
        employeeStackview.isHidden = true
        guestStackview.isHidden = true
        managerStackView.isHidden = true
    }
    
    @IBAction func createPass() {
        
    }
    
}
