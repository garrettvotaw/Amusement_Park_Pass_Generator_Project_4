//
//  Pass Model.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/8/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation






struct Pass {
    var rideAccess: [Access]
    var areaAccess: [Access]
    var discounts: Access
    var name: String
    
    mutating func createPass(for enterant: Enterable){
        // Check if the enterable person is a Guest
        if let enterant = enterant as? Guest {
            switch enterant.guestType {
            case .child: rideAccess.append(.allRides); areaAccess.append(.amusement)
            case .classic: rideAccess.append(.allRides); areaAccess.append(.amusement)
            case .vip: rideAccess.append(contentsOf: [.allRides, .skipLines]); discounts = .discount(0.1, 0.2)
            }
            // Check if they are an Employee
        } else if let enterant = enterant as? Employee {
            switch enterant.employeeType {
                
            case .foodService: rideAccess.append(.allRides)
            areaAccess.append(contentsOf: [.amusement, .kitchen])
            discounts = .discount(0.15, 0.25)
                
            case .maintenance: rideAccess.append(.allRides)
            areaAccess.append(contentsOf: [.amusement, .maintenance, .kitchen, .rideControl])
            discounts = .discount(0.15, 0.25)
                
            case .manager: rideAccess.append(.allRides)
            areaAccess.append(contentsOf: [.amusement, .kitchen, .maintenance, .office, .rideControl])
            discounts = .discount(0.25, 0.25)
                
            case .rideService: rideAccess.append(.allRides)
            areaAccess.append(contentsOf: [.amusement, .rideControl])
            discounts = .discount(0.15, 0.25)
                
            }
        }
    }
}

