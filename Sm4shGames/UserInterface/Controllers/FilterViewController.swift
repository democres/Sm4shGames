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
import Cosmos

protocol FilterVCDelegate: class {
    func applyFilters(minPrice: Double, maxPrice: Double, rating: Int)
}

class FilterViewController: UIViewController{

    weak var delegate: FilterVCDelegate?
    
    @IBOutlet weak var rangeSeeker: RangeSeekSlider!
    @IBOutlet weak var ratingControl: CosmosView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func touchApplyFilters(_ sender: Any) {
        
        delegate?.applyFilters(minPrice: Double(self.rangeSeeker!.selectedMinValue),
                               maxPrice: Double(self.rangeSeeker!.selectedMaxValue),
                               rating: Int(self.ratingControl.rating))
        self.navigationController?.popViewController(animated: false)
    }
    
}
