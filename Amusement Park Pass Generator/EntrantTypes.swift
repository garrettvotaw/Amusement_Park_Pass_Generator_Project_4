//
//  Entrant Types.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/8/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

enum EntrantType {
    case guest
    case employee
    case vendor
    case contractor
}

enum GuestType {
    case child
    case classic
    case vip
    case seasonPass
    case senior
}

enum EmployeeType {
    case foodService
    case rideService
    case maintenance
    case manager
    case contractor
}

enum ManagementTier {
    case generalManager
    case shiftManager
    case seniorManager
}

enum Company {
    case acme
    case orkin
    case fedex
    case nwElectrical
}


