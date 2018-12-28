//
//  NewCell.swift
//  Sm4shGames
//
//  Created by MacNapo on 12/28/18.
//  Copyright © 2018 DavidF. All rights reserved.
//

import Foundation
import UIKit

class NewCell: UICollectionViewCell {
    
    var image: UIImageView!
    var name: UILabel!
    var subtitle: UILabel!
    
    public func configure(with model: NewCell?) {
        //        image.image = model.image!
        //        name.text = model.name.text!
        image = UIImageView()
        image.backgroundColor = .black
        image.layer.cornerRadius = 7
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor(rgb: 0xDB3069).cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        
        name = UILabel()
        name.text = "ASDAS"
        name.font = UIFont.boldSystemFont(ofSize: 16.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        
        subtitle = UILabel()
        subtitle.text = "ASDAS"
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(image)
        addSubview(name)
        addSubview(subtitle)
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        image.widthAnchor.constraint(equalToConstant: 140).isActive = true
        image.heightAnchor.constraint(equalToConstant: 140).isActive = true
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        
        name.widthAnchor.constraint(equalToConstant: 60).isActive = true
        name.heightAnchor.constraint(equalToConstant: 12).isActive = true
        name.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        
        subtitle.widthAnchor.constraint(equalToConstant: 60).isActive = true
        subtitle.heightAnchor.constraint(equalToConstant: 12).isActive = true
        subtitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subtitle.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
    }
}
