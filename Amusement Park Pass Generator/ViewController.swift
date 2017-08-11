//
//  ViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Garrett Votaw on 8/8/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // create a pass button
    func createPass(for entrant: Enterable, withName name: String) throws -> Pass {
        if let pass = try Pass(enterant: entrant, name: name) {
            return pass
        } else {
            throw ParkPassError.invalidEntrant
        }
    }
}
