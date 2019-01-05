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
    
    var newGamesCV: UICollectionView!
    var popularGamesCV: UICollectionView!
    var allGamesCV: UICollectionView!
    
    let collectionViewAIdentifier = "CollectionViewACell"
    let collectionViewBIdentifier = "CollectionViewBCell"
    
    var gamesBuffer: Games!
    var popularGames: [Game]!
    var allGames: [Game]!
    var newGames: [Game]!
    
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
        
        self.view.backgroundColor = .white
        
        var net = Networking()
        net.fetchGames { (result) in
            self.gamesBuffer = Games(games: result)
            self.popularGames = self.gamesBuffer.getPopularGames()
            self.popularLbl.text = "Popular (\(self.popularGames.count))"
            self.popularGamesCV.reloadData()
            
            self.newGames = self.gamesBuffer.getRecentGames()
            self.newLbl.text = "New (\(self.newGames.count))"
            self.newGamesCV.reloadData()
            
            self.allGames = self.gamesBuffer.games
            self.allLbl.text = "New (\(self.allGames.count))"
            self.allGamesCV.reloadData()
        }
        
        let layoutNewCV: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutNewCV.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layoutNewCV.itemSize = CGSize(width: 160, height: 180)
        layoutNewCV.scrollDirection = .horizontal
        
        let layoutPopularCV: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutPopularCV.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layoutPopularCV.itemSize = CGSize(width: 160, height: 180)
        layoutPopularCV.scrollDirection = .horizontal
        
        let layoutAllGames: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutAllGames.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layoutAllGames.itemSize = CGSize(width: 160, height: 180)
        layoutAllGames.scrollDirection = .vertical
        
        
        newGamesCV = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutNewCV)
        newGamesCV.dataSource = self
        newGamesCV.delegate = self
        newGamesCV.register(NewGamesCell.self, forCellWithReuseIdentifier: "MyCell")
        newGamesCV.backgroundColor = .white
        newGamesCV.translatesAutoresizingMaskIntoConstraints = false
        
        popularGamesCV = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutPopularCV)
        popularGamesCV.dataSource = self
        popularGamesCV.delegate = self
        popularGamesCV.register(NewGamesCell.self, forCellWithReuseIdentifier: "MyCell")
        popularGamesCV.backgroundColor = .white
        popularGamesCV.translatesAutoresizingMaskIntoConstraints = false
        
        
        allGamesCV = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutAllGames)
        allGamesCV.dataSource = self
        allGamesCV.delegate = self
        allGamesCV.register(NewGamesCell.self, forCellWithReuseIdentifier: "MyCell")
        allGamesCV.backgroundColor = .white
        allGamesCV.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        scrollView.addSubview(newGamesCV)
        scrollView.addSubview(popularLbl)
        scrollView.addSubview(line2)
        scrollView.addSubview(popularGamesCV)
        scrollView.addSubview(allLbl)
        scrollView.addSubview(line3)
        scrollView.addSubview(allGamesCV)
        
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
        
        self.newGamesCV.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.newGamesCV.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.newGamesCV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.newGamesCV.topAnchor.constraint(equalTo: self.newLbl.bottomAnchor, constant: 20).isActive = true
        
        self.popularLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.popularLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.popularLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 100).isActive = true
        self.popularLbl.topAnchor.constraint(equalTo: self.newGamesCV.bottomAnchor, constant: 20).isActive = true
        
        self.line2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.line2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.line2.leftAnchor.constraint(equalTo: self.popularLbl.rightAnchor, constant: 0).isActive = true
        self.line2.centerYAnchor.constraint(equalTo: self.popularLbl.centerYAnchor, constant: 0).isActive = true
        
        self.popularGamesCV.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.popularGamesCV.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.popularGamesCV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.popularGamesCV.topAnchor.constraint(equalTo: self.popularLbl.bottomAnchor, constant: 20).isActive = true
        
        self.allLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.allLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.allLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 100).isActive = true
        self.allLbl.topAnchor.constraint(equalTo: self.popularGamesCV.bottomAnchor, constant: 20).isActive = true
        
        self.line3.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.line3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.line3.leftAnchor.constraint(equalTo: self.allLbl.rightAnchor, constant: 0).isActive = true
        self.line3.centerYAnchor.constraint(equalTo: self.allLbl.centerYAnchor, constant: 0).isActive = true
        
        self.allGamesCV.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.allGamesCV.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.allGamesCV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.allGamesCV.topAnchor.constraint(equalTo: self.allLbl.bottomAnchor, constant: 20).isActive = true
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.popularGamesCV {
            if self.popularGames != nil {
                return self.popularGames.count
            }
        }
        
        if collectionView == self.newGamesCV {
            if self.newGames != nil {
                return self.newGames.count
            }
        }
        
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! NewGamesCell
        
        if collectionView == self.popularGamesCV {
            if self.popularGames != nil {
                if self.popularGames.count > 0 && indexPath.row < self.popularGames.count {
                    
                    if let image = self.popularGames[indexPath.row].imageUrl {
                        myCell.imageView.downloaded(from: image)
                    }
                    if let name = self.popularGames[indexPath.row].name {
                        myCell.nameLbl.text = name
                    }

                }
            }
        }
        
        if collectionView == self.newGamesCV {
            if self.newGames != nil {
                if self.newGames.count > 0 && indexPath.row < self.newGames.count {
                    
                    if let image = self.newGames[indexPath.row].imageUrl {
                        myCell.imageView.downloaded(from: image)
                    }
                    if let name = self.newGames[indexPath.row].name {
                        myCell.nameLbl.text = name
                    }
                    
                }
            }
        }
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("User tapped on item \(indexPath.row)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}





