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
    
    var scrollView: UIScrollView!
    
    var collectionViewA: UICollectionView!
    var collectionViewB: UICollectionView!
    var collectionViewC: UICollectionView!
    
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
    
    var newLbl: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = .gray
        label.text = "New (5)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var popularLbl: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = .gray
        label.text = "Popular (7)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var allLbl: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = .gray
        label.text = "All (27)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var line1: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    var line2: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    var line3: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    override func viewDidLoad() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 160, height: 180)
        layout.scrollDirection = .horizontal
    
        self.view.backgroundColor = .white
        
        
        collectionViewA = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionViewA.dataSource = self
        collectionViewA.delegate = self
        collectionViewA.register(NewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionViewA.backgroundColor = .white
        collectionViewA.translatesAutoresizingMaskIntoConstraints = false
        
        
        collectionViewB = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
        collectionViewB.register(NewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionViewB.backgroundColor = UIColor.yellow
        collectionViewB.translatesAutoresizingMaskIntoConstraints = false
        
        
        collectionViewC = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionViewC.dataSource = self
        collectionViewC.delegate = self
        collectionViewC.register(NewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionViewC.backgroundColor = UIColor.cyan
        collectionViewC.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: 1200)

        
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(titleLbl)
        scrollView.addSubview(allBtn)
        scrollView.addSubview(dummyBtn)
        scrollView.addSubview(newLbl)
        scrollView.addSubview(line1)
        scrollView.addSubview(collectionViewA)
        scrollView.addSubview(popularLbl)
        scrollView.addSubview(line2)
        scrollView.addSubview(collectionViewB)
        scrollView.addSubview(allLbl)
        scrollView.addSubview(line3)
        scrollView.addSubview(collectionViewC)
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    func setupConstraints(){
        
        self.titleLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.titleLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.titleLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 100).isActive = true
        self.titleLbl.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 30).isActive = true
        
        self.allBtn.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.allBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.allBtn.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 100).isActive = true
        self.allBtn.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 15).isActive = true
        
        self.dummyBtn.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.dummyBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.dummyBtn.centerXAnchor.constraint(equalTo: self.allBtn.rightAnchor, constant: 80).isActive = true
        self.dummyBtn.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 15).isActive = true
        
        self.newLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.newLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.newLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 100).isActive = true
        self.newLbl.topAnchor.constraint(equalTo: self.allBtn.bottomAnchor, constant: 20).isActive = true
        
        self.line1.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.line1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.line1.leftAnchor.constraint(equalTo: self.newLbl.rightAnchor, constant: 0).isActive = true
        self.line1.centerYAnchor.constraint(equalTo: self.newLbl.centerYAnchor, constant: 0).isActive = true
        
        self.collectionViewA.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.collectionViewA.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.collectionViewA.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.collectionViewA.topAnchor.constraint(equalTo: self.newLbl.bottomAnchor, constant: 20).isActive = true
        
        self.popularLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.popularLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.popularLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 100).isActive = true
        self.popularLbl.topAnchor.constraint(equalTo: self.collectionViewA.bottomAnchor, constant: 20).isActive = true
        
        self.line2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.line2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.line2.leftAnchor.constraint(equalTo: self.popularLbl.rightAnchor, constant: 0).isActive = true
        self.line2.centerYAnchor.constraint(equalTo: self.popularLbl.centerYAnchor, constant: 0).isActive = true
        
        self.collectionViewB.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.collectionViewB.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.collectionViewB.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.collectionViewB.topAnchor.constraint(equalTo: self.popularLbl.bottomAnchor, constant: 20).isActive = true
        
        self.allLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.allLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.allLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 100).isActive = true
        self.allLbl.topAnchor.constraint(equalTo: self.collectionViewB.bottomAnchor, constant: 20).isActive = true
        
        self.line3.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.line3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.line3.leftAnchor.constraint(equalTo: self.allLbl.rightAnchor, constant: 0).isActive = true
        self.line3.centerYAnchor.constraint(equalTo: self.allLbl.centerYAnchor, constant: 0).isActive = true
        
        self.collectionViewC.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.collectionViewC.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.collectionViewC.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.collectionViewC.topAnchor.constraint(equalTo: self.allLbl.bottomAnchor, constant: 20).isActive = true
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! NewCell
        myCell.configure(with: nil)
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




