//
//  Entrant Model.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/8/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

protocol Enterable {
    var entrantType: EntrantType { get }
}

/******************
*GUEST DECLARATION*
*******************/
struct Guest: Enterable {
    let entrantType: EntrantType = .guest
    let isVIP: Bool
    let guestType: GuestType
    let firstName: String?
    let lastName: String?
    let DOB: Date?
    let streetAddress: String?
    let city: String?
    let zipcode: String?
    
    //Main init
    init(isVIP: Bool, guestType: GuestType, firstName: String?, lastName: String?, DOB: Date?, streetAddress: String?, city: String?, zipcode: String?) throws {
        
        self.isVIP = isVIP
        self.guestType = guestType
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.streetAddress = streetAddress
        self.city = city
        self.zipcode = zipcode
        
        if guestType == .child && DOB == nil {
            throw ParkPassError.invalidBirthday
        }
    }
    
    //Child init
    init(DOB: Date) {
        self.DOB = DOB
        self.guestType = .child
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
            self.guestType = .vip
        } else {
            self.guestType = .classic
        }
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
struct Employee: Enterable {
    let entrantType: EntrantType = .employee
    let employeeType: EmployeeType
    let firstName: String
    let lastName: String
    let DOB: Date?
    let streetAddress: String
    let city: String
    let zipcode: String
    
    init(employeeType: EmployeeType, firstName: String, lastName: String, DOB: Date?, streetAddress: String, city: String, zipcode: String) throws {
        self.employeeType = employeeType
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.streetAddress = streetAddress
        self.city = city
        self.zipcode = zipcode
        
        if firstName == "" || lastName == "" {
            throw ParkPassError.invalidName
        }
        
        if streetAddress == "" || city == "" || zipcode == "" {
            throw ParkPassError.invalidAddress
        }
    }
}






















