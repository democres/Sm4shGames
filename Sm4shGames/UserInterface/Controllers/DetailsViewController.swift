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
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gamePrice: UIButton!
    @IBOutlet weak var detailTV: UITextView!
    
    var image : UIImage!
    var gameTitleText: String!
    var price: String!
    var details: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        gameImage.image = self.image
        gameTitle.text = gameTitleText
        gamePrice.setTitle(price, for: .normal)
        detailTV.text = details
    }
    
}
