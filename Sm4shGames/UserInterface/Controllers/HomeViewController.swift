//
//  HomeViewController.swift
//  Sm4shGames
//
//  Created by MacNapo on 12/27/18.
//  Copyright © 2018 DavidF. All rights reserved.
//


import Foundation
import UIKit


struct Constants {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, FilterVCDelegate {

    var scrollView: UIScrollView!
    
    var gameBrandCV: UICollectionView!
    var newGamesCV: UICollectionView!
    var popularGamesCV: UICollectionView!
    var allGamesCV: UICollectionView!
    
    var filteredGamesCV: UICollectionView!

    var gamesBuffer: Games!
    
    var popularGames: [Game]!
    var allGames: [Game]!
    var newGames: [Game]!
    var gameBrands: [String]!
    var filteredGames: [Game]!
    
    var titleLbl: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica-Bold", size: 22)
        label.text = "Games"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var filterBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(rgb: 0xDB3069).cgColor
        button.setTitleColor(UIColor(rgb: 0xDB3069), for: .normal)
        button.layer.borderWidth = 1
        button.setTitle("FILTERS", for: .normal)
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
    
    var lineNewGames: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    var linePopular: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    var lineAllGames: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    var selectedBrand = "All"
    var refreshControl = UIRefreshControl()
    var isFiltering = false
    
    
    private var normalLayout : NSLayoutConstraint?
    private var alternativeLayout : NSLayoutConstraint?

    override func viewDidLoad() {
        
        self.view.backgroundColor = .white

        
        //assign a target for the filterBtn
        self.filterBtn.addTarget(self, action: #selector(self.pressFilters(_:)), for: .touchUpInside)
        
        let layoutBrandCV: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutBrandCV.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layoutBrandCV.itemSize = CGSize(width: 160, height: 80)
        layoutBrandCV.scrollDirection = .horizontal
        
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
        
        let layoutFilteredGames: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutFilteredGames.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layoutFilteredGames.itemSize = CGSize(width: 160, height: 180)
        layoutFilteredGames.scrollDirection = .vertical
        
        gameBrandCV = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutBrandCV)
        gameBrandCV.dataSource = self
        gameBrandCV.delegate = self
        gameBrandCV.register(GameBrandCell.self, forCellWithReuseIdentifier: "MyCell")
        gameBrandCV.backgroundColor = .white
        gameBrandCV.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        filteredGamesCV = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutFilteredGames)
        filteredGamesCV.dataSource = self
        filteredGamesCV.delegate = self
        filteredGamesCV.register(NewGamesCell.self, forCellWithReuseIdentifier: "MyCell")
        filteredGamesCV.backgroundColor = .white
        filteredGamesCV.translatesAutoresizingMaskIntoConstraints = false
        filteredGamesCV.isHidden = true
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.screenHeight))
        scrollView.contentSize = CGSize(width: Constants.screenWidth, height: 1200)
        
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(titleLbl)
        scrollView.addSubview(filterBtn)
        scrollView.addSubview(gameBrandCV)
        scrollView.addSubview(newLbl)
        scrollView.addSubview(lineNewGames)
        scrollView.addSubview(newGamesCV)
        scrollView.addSubview(popularLbl)
        scrollView.addSubview(linePopular)
        scrollView.addSubview(popularGamesCV)
        scrollView.addSubview(allLbl)
        scrollView.addSubview(lineAllGames)
        scrollView.addSubview(allGamesCV)
        scrollView.addSubview(filteredGamesCV)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Loading Data")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        scrollView.addSubview(refreshControl)
        
        
        
        // Show Cache games
        self.showCacheGames()
        
        // fetch games from API
        self.showGames()
        
        
        setupConstraints()
    }
    
 
    
    
    
    //MARK: INHERITED METHODS
    
    override func viewWillLayoutSubviews() {
        
        // NO POPULAR GAMES
        if (self.popularGames != nil) {
            if self.popularGames.count == 0 {
                self.popularLbl.isHidden = true
                self.popularGamesCV.isHidden = true
                self.linePopular.isHidden = true
                normalLayout?.isActive = false
                self.alternativeLayout?.isActive = true
            } else {
                self.popularLbl.isHidden = false
                self.popularGamesCV.isHidden = false
                self.linePopular.isHidden = false
                normalLayout?.isActive = true
                self.alternativeLayout?.isActive = false
            }
        }
    
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if self.isFiltering {
            self.filterBtn.setTitle("CLEAR", for: .normal)
        } else {
            self.filterBtn.setTitle("FILTERS", for: .normal)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: CLASS METHODS
    
    private func showCacheGames(){

        guard let gamesCache = DatabaseController.shared.getGames() else {
            print("No games in cache")
            return
        }
        if gamesCache.count > 0 {
            self.gamesBuffer = Games(games: gamesCache)
            self.loadCollectionViews()
        }
        
    }
    
    
    private func showGames(){
        
        let net = Networking()
        net.fetchGames { (result) in
            
            self.gamesBuffer = Games(games: result)
            self.loadCollectionViews()
            self.refreshControl.endRefreshing()
            
            self.storeGames(games: self.gamesBuffer.games)
            
        }
        
    }
    
    private func storeGames(games: [Game]){
        DatabaseController.shared.clearDatabase()
        for game in games{
            DatabaseController.shared.saveGame(objectId: game.objectId, name: game.name, brand: game.brand, price: game.price, imageUrl: game.imageUrl, genre: game.genre, popular: game.popular, updatedAt: game.updatedAt, createdAt: game.createdAt, description: game.description, downloads: game.downloads, sku: game.SKU, rating: game.rating)
        }
        
    }
    
    private  func loadCollectionViews(){
        
        self.popularGames = self.gamesBuffer.getPopularGames()
        self.popularLbl.text = "Popular (\(self.popularGames.count))"
        self.popularGamesCV.reloadData()
        
        self.newGames = self.gamesBuffer.getRecentGames()
        self.newLbl.text = "New (\(self.newGames.count))"
        self.newGamesCV.reloadData()
        
        self.allGames = self.gamesBuffer.games
        self.allLbl.text = "All (\(self.allGames.count))"
        self.allGamesCV.reloadData()
        
        self.gameBrands = self.gamesBuffer.getAllBrands()
        self.gameBrandCV.reloadData()
        
    }
    
    
    private func showGamesByBrand(brand: String){
        
        if brand == "All" {
            self.showCacheGames()
            return
        }
        
        let gamesBufferAux = Games(games: self.gamesBuffer.getGamesByBrand(brand: brand))
        
        self.popularGames = gamesBufferAux.getPopularGames()
        self.popularLbl.text = "Popular (\(self.popularGames.count))"
        self.popularGamesCV.reloadData()
        
        self.newGames = gamesBufferAux.getRecentGames()
        self.newLbl.text = "New (\(self.newGames.count))"
        self.newGamesCV.reloadData()
        
        self.allGames = gamesBufferAux.games
        self.allLbl.text = "All (\(self.allGames.count))"
        self.allGamesCV.reloadData()
        
    }

    
    @objc func refresh(_ sender:AnyObject) {
        self.showGames()
    }
    
    
    @objc func pressFilters(_ sender: UIButton){
        
        if self.isFiltering {
            self.loadCollectionViews()
            self.isFiltering = false
            self.filterBtn.setTitle("FILTERS", for: .normal)
            self.filteredGames.removeAll()
            self.filteredGamesCV.isHidden = true
            self.scrollView.contentSize = CGSize(width: Constants.screenWidth, height: 1200)
        } else {
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let FilterVC = storyBoard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
            FilterVC.delegate = self
            FilterVC.maxPrice = self.gamesBuffer.getMaxPrice()
            FilterVC.minPrice = self.gamesBuffer.getMinPrice()
            self.navigationController?.pushViewController(FilterVC, animated: true)
            self.scrollView.contentSize = CGSize(width: Constants.screenWidth, height: Constants.screenHeight - 100)
        }
        
    }
    
    
    
    func presentDetailsVC(cell: NewGamesCell, dataArray: [Game], indexPath: IndexPath){
        
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DetailsVC = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        DetailsVC.image = cell.imageView.image
        DetailsVC.price = "$" + dataArray[indexPath.row].price!
        DetailsVC.gameTitleText = dataArray[indexPath.row].name
        DetailsVC.details = dataArray[indexPath.row].description
        DetailsVC.downloads = dataArray[indexPath.row].downloads! + " downloads"
        DetailsVC.skuNumber = "SKU: " + dataArray[indexPath.row].SKU!
        DetailsVC.rating = Int(dataArray[indexPath.row].rating!)
        
        self.navigationController?.pushViewController(DetailsVC, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: CollectionView Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        
        if collectionView == self.gameBrandCV {
            if self.gameBrands != nil {
                return self.gameBrands.count
            }
        }
        
        if collectionView == self.newGamesCV {
            if self.newGames != nil {
                return self.newGames.count
            }
        }
        
        if collectionView == self.popularGamesCV {
            if self.popularGames != nil {
                return self.popularGames.count
            }
        }
        
        if collectionView == self.allGamesCV {
            if self.allGames != nil {
                return self.allGames.count
            }
        }
        
        if collectionView == self.filteredGamesCV {
            if self.filteredGames != nil {
                return self.filteredGames.count
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.gameBrandCV {
            if self.gameBrands != nil {
                if self.gameBrands.count > 0 && indexPath.row < self.gameBrands.count {
                    
                    let gameBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! GameBrandCell
                    
                    gameBrandCell.button.setTitle(self.gameBrands[indexPath.row], for: .normal)
                    if self.gameBrands[indexPath.row] == self.selectedBrand {
                        gameBrandCell.button.backgroundColor = UIColor(rgb: 0xDB3069)
                        gameBrandCell.button.setTitleColor(.white, for: .normal)
                    } else {
                        gameBrandCell.button.backgroundColor = .white
                        gameBrandCell.button.setTitleColor(UIColor(rgb: 0xDB3069), for: .normal)
                    }
                    
                    return gameBrandCell
                    
                }
            }
        }
        
        if collectionView == self.popularGamesCV {
            if self.popularGames != nil {
                if self.popularGames.count > 0 && indexPath.row < self.popularGames.count {
                    
                    let popularGamesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! NewGamesCell
                    popularGamesCell.imageView.layer.borderColor = UIColor.lightGray.cgColor
                    
                    if let image = self.popularGames[indexPath.row].imageUrl {
                        popularGamesCell.imageView.downloaded(from: image)
                    }
                    if let name = self.popularGames[indexPath.row].name {
                        popularGamesCell.nameLbl.text = name
                        popularGamesCell.subtitleLbl.text = nil
                    }
                    
                    return popularGamesCell

                }
            }
        }
        
        if collectionView == self.newGamesCV {
            if self.newGames != nil {
                if self.newGames.count > 0 && indexPath.row < self.newGames.count {
                    
                    let newGamesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! NewGamesCell
                    
                    if let image = self.newGames[indexPath.row].imageUrl {
                        newGamesCell.imageView.downloaded(from: image)
                    }
                    if let name = self.newGames[indexPath.row].name {
                        newGamesCell.nameLbl.text = name
                        newGamesCell.subtitleLbl.text = nil
                    }
                    
                    return newGamesCell
                }
            }
        }
        
        if collectionView == self.allGamesCV {
            if self.allGames != nil {
                if self.allGames.count > 0 && indexPath.row < self.allGames.count {
                    
                    let allGamesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! NewGamesCell
                    allGamesCell.imageView.layer.borderColor = UIColor.lightGray.cgColor
                    
                    if let image = self.allGames[indexPath.row].imageUrl {
                        allGamesCell.imageView.downloaded(from: image)
                    }
                    if let name = self.allGames[indexPath.row].name {
                        allGamesCell.nameLbl.text = name
                        allGamesCell.subtitleLbl.text = nil
                    }
                    
                    return allGamesCell
                }
            }
        }
        
        
        if collectionView == self.filteredGamesCV {
            if self.filteredGames != nil {
                if self.filteredGames.count > 0 && indexPath.row < self.filteredGames.count {
                    
                    let filteredGameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! NewGamesCell
                    filteredGameCell.imageView.layer.borderColor = UIColor.lightGray.cgColor
                    
                    if let image = self.filteredGames[indexPath.row].imageUrl {
                        filteredGameCell.imageView.downloaded(from: image)
                    }
                    if let name = self.filteredGames[indexPath.row].name {
                        filteredGameCell.nameLbl.text = name
                        filteredGameCell.subtitleLbl.text = nil
                    }
                    
                    return filteredGameCell
                }
            }
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) //return default
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if collectionView == self.gameBrandCV {
            if self.gameBrands != nil {
                if self.gameBrands.count > 0 && indexPath.row < self.gameBrands.count {
                    
                    let cell = collectionView.cellForItem(at: indexPath) as! GameBrandCell
                    self.selectedBrand = cell.button.titleLabel!.text!
                    cell.button.backgroundColor = UIColor(rgb: 0xDB3069)
                    cell.button.setTitleColor(.white, for: .normal)
                    showGamesByBrand(brand: self.selectedBrand)
                    self.gameBrandCV.reloadData()
                    self.gameBrandCV.layoutSubviews()
                    return
                }
            }
        }

        if collectionView == self.newGamesCV {
            if self.newGames != nil {
                if self.newGames.count > 0 && indexPath.row < self.newGames.count {
                    
                    let cell = collectionView.cellForItem(at: indexPath) as! NewGamesCell
                    presentDetailsVC(cell: cell, dataArray: self.newGames, indexPath: indexPath)
                    
                }
            }
        }
        
        if collectionView == self.popularGamesCV {
            if self.popularGames != nil {
                if self.popularGames.count > 0 && indexPath.row < self.popularGames.count {
                    
                    let cell = collectionView.cellForItem(at: indexPath) as! NewGamesCell
                    presentDetailsVC(cell: cell, dataArray: self.popularGames, indexPath: indexPath)
                    
                }
            }
        }
        
        if collectionView == self.allGamesCV {
            if self.allGames != nil {
                if self.allGames.count > 0 && indexPath.row < self.allGames.count {
                    
                    let cell = collectionView.cellForItem(at: indexPath) as! NewGamesCell
                    presentDetailsVC(cell: cell, dataArray: self.allGames, indexPath: indexPath)
                    
                }
            }
        }
        
        if collectionView == self.filteredGamesCV {
            if self.filteredGames != nil {
                if self.filteredGames.count > 0 && indexPath.row < self.filteredGames.count {
                    
                    let cell = collectionView.cellForItem(at: indexPath) as! NewGamesCell
                    presentDetailsVC(cell: cell, dataArray: self.filteredGames, indexPath: indexPath)
                    
                }
            }
        }
        
        
    }
    

    
    //MARK: View Constraints
    
    func setupConstraints(){
        
        self.titleLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.titleLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.titleLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 80).isActive = true
        self.titleLbl.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 30).isActive = true
        
        self.filterBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.filterBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.filterBtn.centerXAnchor.constraint(equalTo: scrollView.rightAnchor, constant: Constants.screenWidth - 60).isActive = true
        self.filterBtn.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 30).isActive = true
        
        self.gameBrandCV.widthAnchor.constraint(equalToConstant: Constants.screenWidth).isActive = true
        self.gameBrandCV.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.gameBrandCV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.gameBrandCV.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 10).isActive = true
        
        
        self.filteredGamesCV.widthAnchor.constraint(equalToConstant: Constants.screenWidth).isActive = true
        self.filteredGamesCV.heightAnchor.constraint(equalToConstant: Constants.screenHeight - 100).isActive = true
        self.filteredGamesCV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.filteredGamesCV.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 20).isActive = true
        
        self.newLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.newLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.newLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 80).isActive = true
        self.newLbl.topAnchor.constraint(equalTo: self.gameBrandCV.bottomAnchor, constant: 20).isActive = true
        
        self.lineNewGames.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.lineNewGames.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.lineNewGames.leftAnchor.constraint(equalTo: self.newLbl.rightAnchor, constant: 0).isActive = true
        self.lineNewGames.centerYAnchor.constraint(equalTo: self.newLbl.centerYAnchor, constant: 0).isActive = true
        
        self.newGamesCV.widthAnchor.constraint(equalToConstant: Constants.screenWidth).isActive = true
        self.newGamesCV.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.newGamesCV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.newGamesCV.topAnchor.constraint(equalTo: self.newLbl.bottomAnchor, constant: 20).isActive = true
        
        self.popularLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.popularLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.popularLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 80).isActive = true
        self.popularLbl.topAnchor.constraint(equalTo: self.newGamesCV.bottomAnchor, constant: 20).isActive = true
        
        self.linePopular.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.linePopular.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.linePopular.leftAnchor.constraint(equalTo: self.popularLbl.rightAnchor, constant: 0).isActive = true
        self.linePopular.centerYAnchor.constraint(equalTo: self.popularLbl.centerYAnchor, constant: 0).isActive = true
        
        self.popularGamesCV.widthAnchor.constraint(equalToConstant: Constants.screenWidth).isActive = true
        self.popularGamesCV.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.popularGamesCV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.popularGamesCV.topAnchor.constraint(equalTo: self.popularLbl.bottomAnchor, constant: 20).isActive = true
        
        self.allLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        self.allLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.allLbl.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 80).isActive = true
        normalLayout = self.allLbl.topAnchor.constraint(equalTo: self.popularGamesCV.bottomAnchor, constant: 20)
        normalLayout!.isActive = true
        
        self.alternativeLayout = self.allLbl.topAnchor.constraint(equalTo: self.newGamesCV.bottomAnchor, constant: 20)
        
        self.lineAllGames.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.lineAllGames.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.lineAllGames.leftAnchor.constraint(equalTo: self.allLbl.rightAnchor, constant: 0).isActive = true
        self.lineAllGames.centerYAnchor.constraint(equalTo: self.allLbl.centerYAnchor, constant: 0).isActive = true
        
        //ALL GAMES COLLECTION VIEW
        self.allGamesCV.widthAnchor.constraint(equalToConstant: Constants.screenWidth).isActive = true
        self.allGamesCV.heightAnchor.constraint(equalToConstant: 400).isActive = true
        self.allGamesCV.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.allGamesCV.topAnchor.constraint(equalTo: self.allLbl.bottomAnchor, constant: 20).isActive = true
        
    }
    
    
    
    // MARK: FILTER DELEGATE
    func applyFilters(minPrice: Double, maxPrice: Double, rating: Int, sort: sortedBy) {
        
        var gamesBufferAux = Games(games: self.gamesBuffer.filterByRange(min: minPrice, max: maxPrice))
        gamesBufferAux = Games(games: gamesBufferAux.filterByRating(rating: rating))
        
        switch sort {
            case .byDownloads:
                gamesBufferAux = Games(games: gamesBufferAux.sortByDownloads(games: gamesBufferAux.games))
            case .byDate:
                gamesBufferAux = Games(games: gamesBufferAux.sortByDate())
            case .byPrice:
                gamesBufferAux = Games(games: gamesBufferAux.sortByPrice())
            default:
                gamesBufferAux = Games(games: gamesBufferAux.sortByDownloads(games: gamesBufferAux.games))
        }
        
        self.filteredGamesCV.isHidden = false
        self.filteredGames = gamesBufferAux.games
        self.filteredGamesCV.reloadData()
        
        
        self.isFiltering = true
    }
    
    
}
