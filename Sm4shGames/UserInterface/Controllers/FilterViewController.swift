//
//  FilterViewController.swift
//  Sm4shGames
//
//  Created by Test on 1/10/19.
//  Copyright © 2019 DavidF. All rights reserved.
//

import Foundation
import UIKit
import RangeSeekSlider

protocol FilterVCDelegate: class {
    func applyFilters(min: Double, max: Double)
}

class FilterViewController: UIViewController{

    weak var delegate: FilterVCDelegate?
    
    @IBOutlet weak var rangeSeeker: RangeSeekSlider!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func touchApplyFilters(_ sender: Any) {
        
        delegate?.applyFilters(min: Double(self.rangeSeeker!.selectedMinValue),
                               max: Double(self.rangeSeeker!.selectedMaxValue))
        self.navigationController?.popViewController(animated: false)
    }
    
}
