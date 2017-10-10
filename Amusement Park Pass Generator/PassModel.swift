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
    case amusement = "Amusement"
    case kitchen = "Kitchen"
    case rideControl = "Ride Control"
    case maintenance = "Maintenance"
    case office = "Office"
    case allRides = "All Rides"
    case skipLines = "Skip Lines"
}



/******************
 *PASS DECLARATION*
 ******************/

class Pass {
    var passType: String
    var rideAccess: [Access]?
    var areaAccess: [Access]
    var shoppingDiscounts: (Double, Double)?
    var name: String
    var entrantType: EntrantType
    
    init? (enterant: Enterable, name: String, entrantType: EntrantType) throws {
        self.name = name
        self.entrantType = entrantType
        // Check if the enterable person is a Guest
        if let enterant = enterant as? Guest {
        
            switch enterant.guestType {
                
            case .child:
            self.passType = "Child Pass"
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = nil
                
            case .classic:
            self.passType = "Adult Pass"
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = nil
                
            case .vip:
            self.passType = "VIP"
            self.rideAccess = [.allRides, .skipLines]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = (0.1, 0.2)
                
            case .seasonPass:
            self.passType = "Season Pass"
            self.rideAccess = [.allRides, .skipLines]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = (0.1, 0.2)
                
            case .senior:
            self.passType = "Senior Pass"
            self.rideAccess = [.allRides, .skipLines]
            self.areaAccess = [.amusement]
            self.shoppingDiscounts = (0.1, 0.1)
                
            }
        // Check if they are an Employee
        } else if let enterant = enterant as? Employee {

            switch enterant.employeeType {

            case .foodService:
            self.passType = "Food Service"
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .kitchen]
            self.shoppingDiscounts = (0.15, 0.25)
                
            case .maintenance:
            self.passType = "Maintenance"
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .maintenance, .kitchen, .rideControl]
            self.shoppingDiscounts = (0.15, 0.25)
                
            case .rideService:
            self.passType = "Ride Service"
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .rideControl]
            self.shoppingDiscounts = (0.15, 0.25)
                
            case .manager:
            self.passType = "Manager"
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .kitchen, .maintenance, .office, .rideControl]
            self.shoppingDiscounts = (0.25, 0.25)
                
            case .contractor:
                self.passType = "Contractor"
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
                default: throw ParkPassError.invalidProjectNumber
                }
            }
        } else if let enterant = enterant as? Vendor {
            self.passType = "Vendor"
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
        var totalAccess: [Access] = []
        if let rideAccess = self.rideAccess {
            totalAccess = self.areaAccess + rideAccess
        } else {
            totalAccess = self.areaAccess
        }
        
        for anAccess in totalAccess {
            if anAccess == access {
                return true
            }
        }
        return false
    }
    
    func swipePass(forDiscount discount: Double) -> Bool {
        if shoppingDiscounts?.0 == discount || shoppingDiscounts?.1 == discount {
            return true
        }
        return false
    }
}

































