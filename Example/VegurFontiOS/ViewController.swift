//
//  ViewController.swift
//  VegurFontiOS
//
//  Created by Johann Wilfling on 10/03/2016.
//  Copyright (c) 2016 Johann Wilfling. All rights reserved.
//

import UIKit

import VegurFontiOS

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.text = "This is Vegur Font."
        label.font = UIFont.vegurFontWithSize(17.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

