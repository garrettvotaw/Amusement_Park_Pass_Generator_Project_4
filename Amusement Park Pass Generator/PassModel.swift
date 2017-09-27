//
//  Pass Model.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/8/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

/********************
 *ACCESS DECLARATION*
 ********************/
enum Access: String {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
    case allRides
    case skipLines
}



/******************
 *PASS DECLARATION*
 ******************/

class Pass {
    var rideAccess: [Access]?
    var areaAccess: [Access]
    var shoppingDiscounts: (Double, Double)?
    var name: String
    var entrantType: EntrantType
    
    init? (enterant: Enterable, name: String, entrantType: EntrantType) {
        self.name = name
        self.entrantType = entrantType
        // Check if the enterable person is a Guest
        if let enterant = enterant as? Guest {
        
            switch enterant.guestType {
                
            case .child:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = nil
                
            case .classic:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = nil
                
            case .vip:
            self.rideAccess = [.allRides, .skipLines]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = (0.1, 0.2)
                
            case .seasonPass:
            self.rideAccess = [.allRides, .skipLines]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = (0.1, 0.2)
                
            case .senior:
            self.rideAccess = [.allRides, .skipLines]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = (0.1, 0.2)
                
            }
        // Check if they are an Employee
        } else if let enterant = enterant as? Employee {

            switch enterant.employeeType {

            case .foodService:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .kitchen]
            self.shoppingDiscounts = (0.15, 0.25)
                
            case .maintenance:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .maintenance, .kitchen, .rideControl]
            self.shoppingDiscounts = (0.15, 0.25)
                
            case .rideService:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .rideControl]
            self.shoppingDiscounts = (0.15, 0.25)
                
            case .manager:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .kitchen, .maintenance, .office, .rideControl]
            self.shoppingDiscounts = (0.25, 0.25)
                
            case .contractor:
                switch enterant.projectNumber {
                case "1001"?:
                    self.areaAccess = [.amusement, .rideControl]
                    self.rideAccess = [.allRides]
                    self.shoppingDiscounts = nil
                case "1002"?:
                    self.areaAccess = [.amusement, .rideControl, .maintenance]
                    self.rideAccess = [.allRides]
                    self.shoppingDiscounts = nil
                case "1003"?:
                    self.areaAccess = [.amusement, .rideControl, .kitchen, .maintenance, .office]
                    self.rideAccess = [.allRides]
                    self.shoppingDiscounts = nil
                case "2001"?:
                    self.areaAccess = [.office]
                    self.rideAccess = [.allRides]
                    self.shoppingDiscounts = nil
                case "2002"?:
                    self.areaAccess = [.maintenance, .kitchen]
                    self.rideAccess = [.allRides]
                    self.shoppingDiscounts = nil
                default: return nil
                }
            }
        } else if let enterant = enterant as? Vendor {
            switch enterant.company {
            case .acme:
                self.areaAccess = [.kitchen]
                self.rideAccess = nil
                self.shoppingDiscounts = nil
                
            case .fedex:
                self.areaAccess = [.maintenance, .office]
                self.rideAccess = nil
                self.shoppingDiscounts = nil
            case .orkin:
                self.areaAccess = [.amusement, .rideControl, .kitchen]
                self.rideAccess = nil
                self.shoppingDiscounts = nil
            case .nwElectrical:
                self.areaAccess = [.rideControl, .maintenance, .kitchen, .office, .amusement]
                self.rideAccess = nil
                self.shoppingDiscounts = nil
            }
        } else {
            return nil
        }
    }
}

extension Pass {
    func swipePass(for access: Access) -> Bool {
        let totalAccess = self.areaAccess + self.rideAccess!
        for anAccess in totalAccess {
            if anAccess == access {
                print("Access Granted for \(access.rawValue)")
                return true
            }
        }
        print("Access Denied for \(access)")
        return false
    }
    
    func swipePass(forDiscount discount: Double) -> Bool {
        if shoppingDiscounts?.0 == discount || shoppingDiscounts?.1 == discount {
            print("Discount Applied!")
            return true
        }
        print("Access Denied")
        return false
    }
}

































