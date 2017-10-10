//
//  SecondViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 10/5/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var rideAccessLabel: UILabel!
    @IBOutlet weak var foodDiscountLabel: UILabel!
    @IBOutlet weak var shopDiscountLabel: UILabel!
    
    @IBOutlet weak var discountsLabel: UILabel!
    @IBOutlet weak var rideControlLabel: UILabel!
    @IBOutlet weak var officeLabel: UILabel!
    @IBOutlet weak var maintenanceLabel: UILabel!
    @IBOutlet weak var kitchenLabel: UILabel!
    @IBOutlet weak var amusementLabel: UILabel!
    @IBOutlet weak var skipLinesLabel: UILabel!
    @IBOutlet weak var allRidesLabel: UILabel!
    
    var currentPass: Pass? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetAccessTesting()
        nameLabel.text = "bob"
        rideAccessLabel.text = ""
        nameLabel.text = ConnectionHandler.pass?.name
        passTypeLabel.text = ConnectionHandler.pass?.passType
        if let pass = ConnectionHandler.pass {
            currentPass = pass
            if let rideAccess = pass.rideAccess {
                for ride in rideAccess {
                    rideAccessLabel.text = rideAccessLabel.text! + "\(ride.rawValue) "
                }
            } else {
                rideAccessLabel.text = "No Access"
            }
            if let foodDiscount = pass.shoppingDiscounts?.0, let shopDiscount = pass.shoppingDiscounts?.1 {
                foodDiscountLabel.text = "Food: \(Int(foodDiscount * 100))%"
                shopDiscountLabel.text = "Shopping: \(Int(shopDiscount * 100))%"
            } else {
                foodDiscountLabel.text = "No Discount"
                shopDiscountLabel.text = "No Discount"
            }
        } else {print("no pass to show")}
    }
    
    
    @IBAction func createNewPass(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkRideAccess() {
        allRidesLabel.isHidden = false
        skipLinesLabel.isHidden = false
        guard let currentPass = currentPass else {return}
        if let rideAccess = currentPass.rideAccess {
            for access in rideAccess {
                switch access {
                case .allRides: if currentPass.swipePass(for: access) { allRidesLabel.backgroundColor = .green }
                case .skipLines: if currentPass.swipePass(for: access) { skipLinesLabel.backgroundColor = .green }
                default: break
                }
            }
        }
    }


    @IBAction func checkAreaAccess() {
        amusementLabel.isHidden = false
        kitchenLabel.isHidden = false
        maintenanceLabel.isHidden = false
        officeLabel.isHidden = false
        rideControlLabel.isHidden = false
        guard let currentPass = currentPass else {return}
        for access in currentPass.areaAccess {
            switch access {
            case .amusement: if currentPass.swipePass(for: access) { amusementLabel.backgroundColor = .green }
            case .kitchen: if currentPass.swipePass(for: access) { kitchenLabel.backgroundColor = .green }
            case .maintenance: if currentPass.swipePass(for: access) { maintenanceLabel.backgroundColor = .green }
            case .office: if currentPass.swipePass(for: access) { officeLabel.backgroundColor = .green }
            case .rideControl: if currentPass.swipePass(for: access) { rideControlLabel.backgroundColor = .green }
            default: break
            }
        }
        
    }
    
    @IBAction func checkDiscounts() {
        discountsLabel.isHidden = false
        guard let currentPass = currentPass else {return}
        if let discounts = currentPass.shoppingDiscounts {
            if currentPass.swipePass(forDiscount: discounts.0) {
                discountsLabel.backgroundColor = .green
            }
        } else {
            discountsLabel.backgroundColor = .red
        }
    }
    
    func resetAccessTesting() {
        discountsLabel.backgroundColor = .red
        discountsLabel.isHidden = true
        rideControlLabel.backgroundColor = .red
        rideControlLabel.isHidden = true
        officeLabel.backgroundColor = .red
        officeLabel.isHidden = true
        maintenanceLabel.backgroundColor = .red
        maintenanceLabel.isHidden = true
        kitchenLabel.backgroundColor = .red
        kitchenLabel.isHidden = true
        amusementLabel.backgroundColor = .red
        amusementLabel.isHidden = true
        skipLinesLabel.backgroundColor = .red
        skipLinesLabel.isHidden = true
        allRidesLabel.backgroundColor = .red
        allRidesLabel.isHidden = true
    }
    
}
