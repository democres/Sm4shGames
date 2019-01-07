//
//  GameBrandCell.swift
//  Sm4shGames
//
//  Created by Creativo Calidad Grafica on 7/01/19.
//  Copyright © 2019 DavidF. All rights reserved.
//

import Foundation
import UIKit

class GameBrandCell: UICollectionViewCell {
    
    weak var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0xDB3069)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        self.button = button
        
        addSubview(button)
        
        setupConstraints()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("Interface Builder is not supported!")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("Interface Builder is not supported!")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.button.setTitle("", for: .normal)
        self.button.backgroundColor = .white
   
    }
    
    
    func setupConstraints(){
        
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true

    }
}
