//
//  HomeViewController.swift
//  M2
//
//  Created by Mohammad Alfauri on 26/08/2022.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var pageControlar: UIPageControl!
    @IBOutlet weak var collectionview: UICollectionView!
     
    //l2
    @IBOutlet weak var tableviewhome: UITableView!
    var chaletdata: ChaletModel?
    //l2
    
    //link1
    var sideBarView: UIView!
    var tableView1 = UITableView()
    var toplabel = UILabel()
    var bottomView = UIView()
    var logOutBtn = UIButton()
    var nameLbl = UILabel()
    var imageview = UIImageView()
    var topHeight_navigationBar_statusBar:CGFloat = 0.0
    var isEnableSideBarView:Bool = false
    
    var arrData = ["Dashboard", "Profile", "Overview","Events","About","Services","Contats"]
    var arrImages = [UIImage(named: "home")!,UIImage(named: "user1")!,UIImage(named: "heart1")!,UIImage(named: "bulb")!,UIImage(named: "home-icon-silhouette")!,UIImage(named: "user")!,UIImage(named: "heart")!,UIImage(named: "bulb")!]
    
    var swipeToRight = UISwipeGestureRecognizer()
    var swipetoLeft = UISwipeGestureRecognizer()
    var tempview = UIView()
    var tapGesture = UITapGestureRecognizer()
    //link1
    
    
    
    
    var arrProductPhoto = [UIImage(named: "5")!,UIImage(named: "6")!,UIImage(named: "7")!,UIImage(named: "8")!,UIImage(named: "9")!,UIImage(named: "image4")!]
    
    var timer : Timer?
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //link2
        
        loadViewFunctionality()
        loadSideBarViewFunctionality()
        loadGesturefunctionality()
        
        //link2
        
        collectionview.delegate = self
        collectionview.dataSource = self
        pageControlar.numberOfPages = arrProductPhoto.count
        startTimer()
        
        //l2
        loadJson()
        tableviewhome.delegate = self
        tableviewhome.dataSource = self
        //l2
        tableView1.delegate = self
        tableView1.dataSource = self
    
    }
    
    
    //l2
    func loadJson() {
        if let path = Bundle.main.path(forResource: "ChaletJSON", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                chaletdata = try jsonDecoder.decode(ChaletModel.self, from: jsonData)
                
              } catch {
                   //  error
              }
        }
    }
    //l2
    
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(movetoToNextIndex), userInfo: nil, repeats: true)
        
        
    }
    @objc func movetoToNextIndex () {
        if currentCellIndex < arrProductPhoto.count - 1 {
            currentCellIndex += 1

        }else {
            
             currentCellIndex = 0

        }
        collectionview.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControlar.currentPage = currentCellIndex
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProductPhoto.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        cell.imgProductPhoto.image = arrProductPhoto [indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    //link3
    
    func loadViewFunctionality(){
        var menuBtn = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(menuBtnClick))
        menuBtn.tintColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
        self.navigationItem.leftBarButtonItem = menuBtn
    }
    
    
    func loadSideBarViewFunctionality(){
        topHeight_navigationBar_statusBar = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height)!
        
        tempview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        tempview.backgroundColor = .lightGray
        tempview.alpha = 0
        
        sideBarView = UIView(frame: CGRect(x: -self.view.bounds.width/1.5, y: topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - topHeight_navigationBar_statusBar))
        
        tableView1.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 16/255, green: 37/255, blue: 64/255, alpha: 1))
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(UINib.init(nibName: "SideBarTableViewCell", bundle: nil), forCellReuseIdentifier: "sideBarCell")
        
        tableView1.separatorStyle = .none
        tableView1.bounces = false

        toplabel.text = "Menu"
        toplabel.textAlignment = .center
        toplabel.font = UIFont(name: "Party LET", size: 45)
        toplabel.textColor = UIColor.white
        toplabel.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 16/255, green: 37/255, blue: 64/255, alpha: 1))
        
        bottomView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
        
        logOutBtn.setTitle("Log Out", for: .normal)
        logOutBtn.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
        logOutBtn.titleLabel?.textColor = UIColor.white
        logOutBtn.titleLabel?.font = UIFont(name: "Chalkboard SE", size: 20)
        
        nameLbl.numberOfLines = 0
        nameLbl.text = "Mohammad Alfauri"
        nameLbl.textColor = UIColor.white
        nameLbl.textAlignment = NSTextAlignment.center
        nameLbl.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
        
        imageview.image = UIImage(imageLiteralResourceName: "6")
        self.imageview.clipsToBounds = true
        self.imageview.layer.borderWidth = 1
        self.imageview.layer.borderColor = UIColor.white.cgColor
        
        self.view.addSubview(tempview)
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(toplabel)
        self.sideBarView.addSubview(bottomView)
        self.sideBarView.addSubview(tableView1)
        
        self.bottomView.addSubview(logOutBtn)
        self.bottomView.addSubview(nameLbl)
        self.bottomView.addSubview(imageview)
        
        setUpSideBarViewConstraints()
        setUpBottomViewConstraints()
    }
    
    
    func loadGesturefunctionality(){
        swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedToRight))
        swipeToRight.direction = .right
        self.view.addGestureRecognizer(swipeToRight)
        
        swipetoLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedToLeft))
        swipetoLeft.direction = .left
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSideBarView))
        tempview.addGestureRecognizer(tapGesture)
    }
    
    
    func setUpBottomViewConstraints(){
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 20).isActive = true
//        logOutBtn.trailingAnchor.constraint(equalTo: self.imageview.leadingAnchor, constant: -20).isActive = true
        logOutBtn.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 15).isActive = true
        logOutBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 20).isActive = true
//        nameLbl.trailingAnchor.constraint(equalTo: self.imageview.leadingAnchor, constant: -20).isActive = true
        nameLbl.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -15).isActive = true
        nameLbl.topAnchor.constraint(equalTo: self.logOutBtn.bottomAnchor, constant: 0).isActive = true
        
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 20).isActive = true
        imageview.trailingAnchor.constraint(equalTo: self.bottomView.trailingAnchor, constant: -20).isActive = true
        imageview.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -20).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func setUpSideBarViewConstraints(){
        toplabel.translatesAutoresizingMaskIntoConstraints = false
        toplabel.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
        toplabel.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
        toplabel.topAnchor.constraint(equalTo: self.sideBarView.topAnchor, constant: 0).isActive = true
        toplabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        tableView1.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
        tableView1.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
        tableView1.topAnchor.constraint(equalTo: self.toplabel.bottomAnchor, constant: 0).isActive = true
        tableView1.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 0).isActive = true
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.sideBarView.bottomAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    
    @objc func closeSideBarView(){
        print("tapGesture")
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipetoLeft)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
            
            for alpha in (0...5).reversed(){
                self.tempview.alpha = CGFloat(alpha/10)
            }
        }, completion: nil)
        isEnableSideBarView = false
    }
    
    
    @objc func swipedToLeft(){
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipetoLeft)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
            
            for alpha in (0...5).reversed(){
                self.tempview.alpha = CGFloat(alpha/10)
            }
            
        }, completion: nil)
        isEnableSideBarView = false
    }
    
    
    @objc func swipedToRight(){
        self.imageview.layer.cornerRadius = self.imageview.frame.size.height/2
        
        self.view.addGestureRecognizer(swipetoLeft)
        self.view.removeGestureRecognizer(swipeToRight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.sideBarView.frame = CGRect(x: 0, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
            
            for alpha in (0...5){
                self.tempview.alpha = CGFloat(alpha/10)
            }
            self.tempview.alpha = 0.5
        }, completion: nil)
        isEnableSideBarView = true
    }
    
    
    @objc func menuBtnClick(){
        self.imageview.layer.cornerRadius = self.imageview.frame.size.height/2
        
        if isEnableSideBarView{
            self.view.addGestureRecognizer(swipeToRight)
            self.view.removeGestureRecognizer(swipetoLeft)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
                
                for alpha in (0...5).reversed(){
                    self.tempview.alpha = CGFloat(alpha/10)
                }
                
            }, completion: nil)
            
            isEnableSideBarView = false
            
        }else{
            self.view.addGestureRecognizer(swipetoLeft)
            self.view.removeGestureRecognizer(swipeToRight)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.sideBarView.frame = CGRect(x: 0, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
                
                for alpha in (0...5){
                    self.tempview.alpha = CGFloat(alpha/10)
                }
                self.tempview.alpha = 0.5
            }, completion: nil)
            
            isEnableSideBarView = true
        }
    }

}




extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        switch tableView {
        case tableView1:
            numberOfRow = self.arrData.count
        case tableviewhome:
            numberOfRow = chaletdata?.response?.count ?? 0
        default:
            print("Some things Wrong!!")
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView {
        
        case tableView1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath)as! SideBarTableViewCell
            cell.imagev.image = self.arrImages[indexPath.row]
            cell.lbl.text = self.arrData[indexPath.row]
            return cell
        
        case tableviewhome:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell else {
                return UITableViewCell()
            }
            cell.chalets = chaletdata?.response?[indexPath.row ]
            return cell
            
            
            
           /* cell.name.text = product?.products?[indexPath.row].name
            cell.productImage.image = UIImage(named: product?.products?[indexPath.row].imageName ?? "")
            cell.price.text = product?.products?[indexPath.row].price
            cell.productDescription.text = product?.products?[indexPath.row].description
            */
        default:
            print("Some things Wrong!!")
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView1 {
                return 60
            }
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       var cell = UITableViewCell()
        if tableView == self.tableView1 {
        let cell = tableView.cellForRow(at: indexPath)as! SideBarTableViewCell
        
        switch indexPath.row {
        
        case 0:
        let HomeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC")as!HomeViewController
        self.navigationController?.pushViewController(HomeVC, animated: false)
        cell.imagev.tintColor = UIColor(cgColor: CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1))
        cell.lbl.textColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
        cell.contentView.backgroundColor = UIColor.white
            
            
        case 1:
            let shortcutsVC = self.storyboard?.instantiateViewController(identifier: "svc")as! ShortCutsViewController
            self.navigationController?.pushViewController(shortcutsVC, animated: true)
            cell.imagev.tintColor = UIColor(cgColor: CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1))
            cell.lbl.textColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
            cell.contentView.backgroundColor = UIColor.white
            
        case 2:
        let overviewVC = self.storyboard?.instantiateViewController(identifier: "ovc")as! OverViewViewController
        self.navigationController?.pushViewController(overviewVC, animated: true)
            cell.imagev.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
            cell.lbl.textColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
            cell.contentView.backgroundColor = UIColor.white
         
        case 3:
        let dashboardVC = self.storyboard?.instantiateViewController(identifier: "dvc")as!DashBoardViewController
        self.navigationController?.pushViewController(dashboardVC, animated: true)
        cell.imagev.tintColor = UIColor(cgColor: CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1))
        cell.lbl.textColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
        cell.contentView.backgroundColor = UIColor.white
            
        default:
            print(self.arrData[indexPath.row])
            cell.imagev.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
            cell.lbl.textColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
            cell.contentView.backgroundColor = UIColor.white
            
        }
            
        }}
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)as! SideBarTableViewCell
        cell.imagev.tintColor = UIColor.white
        cell.lbl.textColor = UIColor.white
        cell.contentView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 25/255, green: 45/255, blue: 70/255, alpha: 1))
    }
    
    //link3
    //l2
    
    /*
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListingTableViewCell") as? ProductListingTableViewCell else {
            return UITableViewCell()
        }
        cell.name.text = product?.products?[indexPath.row].name
        cell.productImage.image = UIImage(named: product?.products?[indexPath.row].imageName ?? "")
        cell.price.text = product?.products?[indexPath.row].price
        cell.productDescription.text = product?.products?[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else {return}
        vc.product = product?.products?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }*/
    
    
    //l2
        
        
    }
    
    

