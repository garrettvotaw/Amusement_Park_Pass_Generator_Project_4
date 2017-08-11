//
//  Pass Model.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/8/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

struct Pass {
    var rideAccess: [Access]?
    var areaAccess: [Access]?
    var discounts: Access?
    var name: String
    
    init? (enterant: Enterable, name: String) throws {
        self.name = name
        // Check if the enterable person is a Guest
        if let enterant = enterant as? Guest {
            
            switch enterant.guestType {
                
            case .child:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement]
            self.discounts = nil
                
            case .classic:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement]
            self.discounts = nil
                
            case .vip:
            self.rideAccess = [.allRides, .skipLines]
            self.areaAccess = [.amusement]
            self.discounts = .discount(0.1, 0.2)
                
            }
        // Check if they are an Employee
        } else if let enterant = enterant as? Employee {

            switch enterant.employeeType {
                
            case .foodService:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .kitchen]
            self.discounts = .discount(0.15, 0.25)
                
            case .maintenance:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .maintenance, .kitchen, .rideControl]
            self.discounts = .discount(0.15, 0.25)
                
            case .manager:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .kitchen, .maintenance, .office, .rideControl]
            self.discounts = .discount(0.25, 0.25)
                
            case .rideService:
            self.rideAccess = [.allRides]
            self.areaAccess = [.amusement, .rideControl]
            self.discounts = .discount(0.15, 0.25)
                
            }
        }  else {
            // Your entrant is neither a guest nor an employee.
            throw ParkPassError.invalidEntrant
        }
    }
}

