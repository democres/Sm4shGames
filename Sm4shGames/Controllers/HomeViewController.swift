//
//  HomeViewController.swift
//  Sm4shGames
//
//  Created by MacNapo on 12/27/18.
//  Copyright © 2018 DavidF. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionViewA: UICollectionView!
    var collectionViewB: UICollectionView!
    let collectionViewAIdentifier = "CollectionViewACell"
    let collectionViewBIdentifier = "CollectionViewBCell"
    
    
    var titleLbl: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica-Bold", size: 22)
        label.text = "Games"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var allBtn: UIButton = {
        let button = UIButton()
        button.setTitle("All",for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(rgb: 0xDB3069)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var dummyBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Donkey Kong",for: .normal)
        button.setTitleColor(UIColor(rgb: 0xDB3069), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgb: 0xDB3069).cgColor
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
    
        self.view.backgroundColor = .white
        
        
        collectionViewA = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionViewA.dataSource = self
        collectionViewA.delegate = self
        collectionViewA.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionViewA.backgroundColor = UIColor.green
        collectionViewA.translatesAutoresizingMaskIntoConstraints = false
        
        
        collectionViewB = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
        collectionViewB.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionViewB.backgroundColor = UIColor.yellow
        collectionViewB.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.addSubview(titleLbl)
        self.view.addSubview(allBtn)
        self.view.addSubview(dummyBtn)
        self.view.addSubview(collectionViewA)
        self.view.addSubview(collectionViewB)
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    func setupConstraints(){
        
        self.titleLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.titleLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.titleLbl.centerXAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100).isActive = true
        self.titleLbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        
        self.allBtn.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.allBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.allBtn.centerXAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100).isActive = true
        self.allBtn.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 15).isActive = true
        
        self.dummyBtn.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.dummyBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.dummyBtn.centerXAnchor.constraint(equalTo: self.allBtn.rightAnchor, constant: 80).isActive = true
        self.dummyBtn.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 15).isActive = true
        
        self.collectionViewA.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.collectionViewA.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.collectionViewA.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.collectionViewA.topAnchor.constraint(equalTo: self.allBtn.bottomAnchor, constant: 60).isActive = true
        
        self.collectionViewB.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.collectionViewB.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.collectionViewB.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.collectionViewB.topAnchor.constraint(equalTo: self.collectionViewA.bottomAnchor, constant: 60).isActive = true
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)
        myCell.backgroundColor = UIColor.blue
        return myCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath)
    {
        print("User tapped on item \(indexPath.row)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
