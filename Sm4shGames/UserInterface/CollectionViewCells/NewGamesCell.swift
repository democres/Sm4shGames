//
//  NewCell.swift
//  Sm4shGames
//
//  Created by MacNapo on 12/28/18.
//  Copyright © 2018 DavidF. All rights reserved.
//

import Foundation
import UIKit

class NewGamesCell: UICollectionViewCell {
    
    weak var imageView: UIImageView!
    weak var nameLbl: UILabel!
    weak var subtitleLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        image.image = model.image!
        //        name.text = model.name.text!
        let image = UIImageView()
        image.backgroundColor = .black
        image.layer.cornerRadius = 7
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor(rgb: 0xDB3069).cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = image
        
        let name = UILabel()
        name.text = "ASDAS"
        name.font = UIFont.boldSystemFont(ofSize: 16.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.nameLbl = name
        
        let subtitle = UILabel()
        subtitle.text = "ASDAS"
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLbl = subtitle
        
        
        addSubview(image)
        addSubview(name)
        addSubview(subtitle)
        
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
        
        self.nameLbl.text = nil
        self.imageView.image = nil
        self.subtitleLbl.text = nil
    }
    
    
    func setupConstraints(){
        imageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        
        nameLbl.widthAnchor.constraint(equalToConstant: 60).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: 12).isActive = true
        nameLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        
        subtitleLbl.widthAnchor.constraint(equalToConstant: 60).isActive = true
        subtitleLbl.heightAnchor.constraint(equalToConstant: 12).isActive = true
        subtitleLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subtitleLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 10).isActive = true
    }
}
