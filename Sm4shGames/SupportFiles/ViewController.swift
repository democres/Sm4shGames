//
//  ViewController.swift
//  Sm4shGames
//
//  Created by MacNapo on 12/27/18.
//  Copyright © 2018 DavidF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getStaredBtn(_ sender: Any) {
        let VC = HomeViewController()
        self.present(VC, animated: true, completion: nil)
    }
    
}

