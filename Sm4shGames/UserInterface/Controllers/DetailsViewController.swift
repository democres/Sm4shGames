//
//  DetailsViewController.swift
//  Sm4shGames
//
//  Created by Creativo Calidad Grafica on 5/01/19.
//  Copyright © 2019 DavidF. All rights reserved.
//

import Foundation
import UIKit


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var gameImageIV: UIImageView!
    @IBOutlet weak var gameTitleLbl: UILabel!
    @IBOutlet weak var gamePriceBtn: UIButton!
    @IBOutlet weak var detailTV: UITextView!
    @IBOutlet weak var skuNumberLbl: UILabel!
    @IBOutlet weak var downloadsLbl: UILabel!
    
    var image : UIImage!
    var gameTitleText: String!
    var price: String!
    var details: String!
    var skuNumber: String!
    var downloads: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        gamePriceBtn.layer.cornerRadius = 7 // Add corner radius to btn like the sketch
        
        gameImageIV.image = self.image
        gameTitleLbl.text = gameTitleText
        gamePriceBtn.setTitle(price, for: .normal)
        detailTV.text = details
        skuNumberLbl.text = skuNumber
        downloadsLbl.text = downloads
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
