//
//  Entrant Model.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/8/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

protocol Entrant {
    var entrantType: EntrantType { get }
    var rideAccess: [RideAccess] { get }
    var areaAccess: [AreaAccess] { get }
}


/******************
*GUEST DECLARATION*
*******************/
struct Guest: Entrant {
    // protocol conformance
    let entrantType: EntrantType = .guest
    let rideAccess: [RideAccess]
    let areaAccess: [AreaAccess]
    let discounts: (Double, Double)?
    //
    
    let isVIP: Bool
    let guestType: GuestType
    let firstName: String?
    let lastName: String?
    let DOB: Date?
    let streetAddress: String?
    let city: String?
    let zipcode: String?
    
    //Main init
    init(rideAccess: [RideAccess], areaAccess: [AreaAccess], discounts: (Double, Double)?, isVIP: Bool, guestType: GuestType, firstName: String?, lastName: String?, DOB: Date?, streetAddress: String?, city: String?, zipcode: String?) {
        self.rideAccess = rideAccess
        self.areaAccess = areaAccess
        self.discounts = discounts
        self.isVIP = isVIP
        self.guestType = guestType
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.streetAddress = streetAddress
        self.city = city
        self.zipcode = zipcode
    }
    
    //Child init
    init(DOB: Date) {
        self.rideAccess = [.allRides]
        self.areaAccess = [.amusement]
        self.DOB = DOB
        self.guestType = .child
        self.discounts = nil
        self.isVIP = false
        self.firstName = nil
        self.lastName = nil
        self.streetAddress = nil
        self.city = nil
        self.zipcode = nil
    }
    
    //Classic/VIP Guest init
    init(isVIP: Bool) {
        if isVIP {
            self.rideAccess = [.allRides, .skipLines]
        } else {
            self.rideAccess = [.allRides]
        }
        self.areaAccess = [.amusement]
        self.guestType = .classic
        self.discounts = nil
        self.isVIP = isVIP
        self.firstName = nil
        self.lastName = nil
        self.DOB = nil
        self.streetAddress = nil
        self.city = nil
        self.zipcode = nil
    }
}


/*********************
*EMPLOYEE DECLARATION*
*********************/
struct Employee: Entrant {
    // protocol conformance
    let entrantType: EntrantType = .employee
    let rideAccess: [RideAccess]
    let areaAccess: [AreaAccess]
    let discounts: (Double, Double)?
    //
    
    let employeeType: EmployeeType
    let firstName: String
    let lastName: String
    let DOB: Date?
    let streetAddress: String
    let city: String
    let zipcode: String
    
    init(rideAccess: [RideAccess], areaAccess: [AreaAccess], discounts: (Double, Double)?, employeeType: EmployeeType, firstName: String, lastName: String, DOB: Date?, streetAddress: String, city: String, zipcode: String) {
        self.rideAccess = rideAccess
        self.areaAccess = areaAccess
        self.discounts = discounts
        self.employeeType = employeeType
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.streetAddress = streetAddress
        self.city = city
        self.zipcode = zipcode
    }
    
    //convenient init
    init(employeeType: EmployeeType, firstName: String, lastName: String, DOB: Date?, streetAddress: String, city: String, zipcode: String) {
        self.employeeType = employeeType
        self.rideAccess = [.allRides]
        switch employeeType {
        case .foodService: self.areaAccess = [.amusement, .kitchen]; self.discounts = (15, 25)
        case .rideService: self.areaAccess = [.amusement, .rideControl]; self.discounts = (15, 25)
        case .maintenance: self.areaAccess = [.amusement, .rideControl, .kitchen, .maintenance]; self.discounts = (15, 25)
        case .manager: self.areaAccess = [.amusement, .kitchen, .maintenance, .office, .rideControl]; self.discounts = (25, 25)
        }
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.streetAddress = streetAddress
        self.city = city
        self.zipcode = zipcode
    }
}


/********************
 *ACCESS DECLARATION*
 ********************/
enum AreaAccess {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum RideAccess {
    case allRides
    case skipLines
}





















