//
//  Pass.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/15/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

enum Enterant {
    case childGuest
    case classicGuest
    case vipGuest
    case foodServiceEmployee
    case rideServiceEmployee
    case maintenanceEmployee
    case managerEmployee
}

class Passes {
    let entrantType: Enterant
    let isVIP: Bool
    let firstName: String?
    let lastName: String?
    let DOB: Date?
    let streetAddress: String?
    let city: String?
    let zipcode: String?
    
    init (enterantType: Enterant, firstname: String?, lastName: String?, DOB: Date?, streetAddress: String?, city: String?, zipcode: String?) throws {
        self.entrantType = enterantType
        switch enterantType {
        case .vipGuest: isVIP = true
        default: isVIP = false
        }
        self.firstName = firstname
        self.lastName = lastName
        self.DOB = DOB
        self.streetAddress = streetAddress
        self.city = city
        self.zipcode = zipcode
        
        if enterantType == .childGuest && DOB == nil {
            throw ParkPassError.invalidBirthday
        } else if enterantType == .foodServiceEmployee || enterantType == .maintenanceEmployee || enterantType == .managerEmployee || enterantType == .rideServiceEmployee && streetAddress == nil || city == nil || zipcode == nil {
            throw ParkPassError.invalidAddress
        }
    }
}
