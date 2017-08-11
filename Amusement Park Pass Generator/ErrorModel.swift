//
//  ErrorModel.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/11/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

enum ParkPassError: Error {
    case invalidBirthday(Guest)
    case invalidName(Enterable)
    case invalidEntrant
}
