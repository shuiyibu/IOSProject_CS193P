//
//  ViewController.swift
//  Psychologist
//
//  Created by LangDylan on 25/01/2017.
//  Copyright © 2017 Dylan Lang. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    
    
    @IBAction func nothing(_ sender: UIButton) {
        performSegue(withIdentifier: "nothing", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination as? UIViewController
        
        if let navCon = destination as? UINavigationController{
            destination=navCon.visibleViewController
        }
        
        
        if let hvc = destination as? HappinessViewController{
            if let identifier = segue.identifier{
                switch identifier {
                case "sad": hvc.happiness = 0
                case "happiness": hvc.happiness = 100
                case "nothing": hvc.happiness = 25
                default: hvc.happiness = 50
                }
            }
        }
    }
    
    
    
}

