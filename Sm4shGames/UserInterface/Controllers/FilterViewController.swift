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
    func applyFilters(minPrice: Double, maxPrice: Double, rating: Int, sort: sortedBy)
}

enum sortedBy {
    case byDownloads, byDate, byPrice
}

class FilterViewController: UIViewController{

    weak var delegate: FilterVCDelegate?
    
    @IBOutlet weak var rangeSeeker: RangeSeekSlider!
    @IBOutlet weak var ratingControl: CosmosView!
    
    var maxPrice: Double!
    var minPrice: Double!
    
    @IBOutlet weak var sortByDownloads: UISwitch!
    @IBOutlet weak var sortByDate: UISwitch!
    @IBOutlet weak var sortByPrice: UISwitch!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.rangeSeeker.minValue = CGFloat(minPrice)
        self.rangeSeeker.maxValue = CGFloat(maxPrice)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func touchApplyFilters(_ sender: Any) {
        
        var sortedByFilter = sortedBy.byDownloads
        if sortByDownloads.isOn {
            sortedByFilter = .byDownloads
        }
        if sortByDate.isOn {
            sortedByFilter = .byDate
        }
        if sortByPrice.isOn {
            sortedByFilter = .byPrice
        }
        
        delegate?.applyFilters(minPrice: Double(self.rangeSeeker!.selectedMinValue),
                               maxPrice: Double(self.rangeSeeker!.selectedMaxValue),
                               rating: Int(self.ratingControl.rating),
                               sort: sortedByFilter)
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
    @IBAction func selectSortByDownloads(_ sender: Any) {
        self.sortByDate.isOn = false
        self.sortByPrice.isOn = false
    }
    
    @IBAction func selectSortByDate(_ sender: Any) {
        self.sortByPrice.isOn = false
        self.sortByDownloads.isOn = false
    }
    
    @IBAction func selectSortByPrice(_ sender: Any) {
        self.sortByDate.isOn = false
        self.sortByDownloads.isOn = false
    }
    
}
