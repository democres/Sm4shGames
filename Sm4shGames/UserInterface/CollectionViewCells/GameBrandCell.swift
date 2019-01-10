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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(rgb: 0xDB3069), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgb: 0xDB3069).cgColor
        button.backgroundColor = .white
        button.isUserInteractionEnabled = false
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
        
        self.button.setTitle("XXX", for: .normal)
   
    }
    
    
    func setupConstraints(){
        
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true

    }
}
