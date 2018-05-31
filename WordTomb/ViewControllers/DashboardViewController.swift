//
//  DashboardViewController.swift
//  WordTomb
//
//  Created by Udeshi on 5/6/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate{
    
    @IBOutlet weak var dashboardContentView: SKView!
    var currentView : SKView!
    var activeTab = 0
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var tabContentView: SKView!
    @IBOutlet weak var tableView: UITableView!
   
    var categories: [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.delegate = self
        tableView.dataSource = self
        tabBar.delegate = self
        setUserProfileImageInNavBar()
        tabBar.items![0].image = UIImage(named: "aboutGame")?.withRenderingMode(.alwaysOriginal)
        tabBar.items![1].image = UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal)
        
        let skView = self.dashboardContentView
        let scene = DashboardScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        scene.scaleMode  = .resizeFill
        currentView = skView
        skView?.presentScene(scene)
        self.dashboardContentView.isHidden = false
        self.tabContentView.isHidden = true
    }
    
    func setUserProfileImageInNavBar(){
        let button: UIButton = UIButton.init(type: .custom)
        var userDetails: UserDetails? = nil
        userDetails = UserDefaultsHandler().getOtherData(key: "Session") as? UserDetails
        let image =   userDetails != nil && userDetails?.profileImageUrl != "" ? UIImage(contentsOfFile: (userDetails?.profileImageUrl)!) : UIImage(named:"userIcon.png")
        //set image for button
        button.setImage(image, for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(DashboardViewController.viewUserProfile), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y:0,width:10, height:10)
        let barButton = UIBarButtonItem(customView: button)
        //assign button to nav bar
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func loadCategories () {
        categories = CoreDataHandler.fetchCategoryDetails()
        
        
    }
    
    
    @objc func viewUserProfile(){
        print("view it")
        let userDetails = UserDefaultsHandler().getOtherData(key: "Session")
        if(userDetails != nil) {
        performSegue(withIdentifier: "UserProfileController_Segue", sender: self)
        }
   
    }
    
    
    @IBAction func menuButtonClicked(_ sender: Any) {
//        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
//        let viewController = appDelegate.window!.rootViewController as! LoginViewController
//        viewController.performSegue(withIdentifier: "DashboardNavigationController_Segue", sender: self)
        self.performSegue(withIdentifier: "MenuViewController_Segue", sender: self)
        
//        UIView.transition(with: hamgurgerMenu, duration: 0.8, options: [.curveEaseInOut, .transitionCrossDissolve] , animations: { self.hamgurgerMenu.isHidden = !self.hamgurgerMenu.isHidden })
//        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
//            self.hamgurgerMenu.layoutIfNeeded()
//        }) { (animationComplete) in
//            print("The animation is complete!")
//        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(categories.count)
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "evenDashboardCellView") as! DashboardCustomTableViewCell
            cell.evenCategoryImage.image = UIImage(named: categories[indexPath.row].image!)
            cell.evenCategoryName.text = categories[indexPath.row].name
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            cell.evenCategoryImage.image?.resizableImage(withCapInsets: UIEdgeInsets(top:8,left:8,bottom:8,right:8), resizingMode: .stretch)
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "oddDashboardCellView") as! DashboardCustomTableViewCell
        cell.oddCategoryImage.image = UIImage(named: categories[indexPath.row].image!)
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cell.oddCategoryImage.image?.resizableImage(withCapInsets: UIEdgeInsets(top:8,left:8,bottom:8,right:8), resizingMode: .stretch)
        cell.oddCategoryName.text = categories[indexPath.row].name
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaultsHandler().save(data: categories[indexPath.row].id, key: "selectedCategoryId")
        
        //navigate to gamelevel
        let reveal = SKTransition.flipHorizontal(withDuration: 1.0)
        //self.dashboardContentView.isHidden = true
       // let skView = self.chambers as! SKView
        let chambersScreen = ChambersScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        chambersScreen.scaleMode  = .resizeFill
        chambersScreen.size = UIScreen.main.bounds.size
        currentView.presentScene(chambersScreen, transition: reveal)
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 2004  {
            if(activeTab != 2004){
              self.dashboardContentView.isHidden =  !self.dashboardContentView.isHidden
                self.tabContentView.isHidden =  !self.tabContentView.isHidden
                let scene = AboutGameScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                
                scene.scaleMode  = .resizeFill
                tabContentView?.presentScene(scene)
            }else{
                  self.dashboardContentView.isHidden =  false
                  self.tabContentView.isHidden = !self.tabContentView.isHidden
            }
        }else if item.tag == 2005 {
            if(activeTab != 2005){
                  self.dashboardContentView.isHidden =  !self.dashboardContentView.isHidden
                   self.tabContentView.isHidden =  !self.tabContentView.isHidden
            let scene = SettingsScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            
            scene.scaleMode  = .resizeFill
            tabContentView?.presentScene(scene)
        }else{
                  self.dashboardContentView.isHidden =  false
            self.tabContentView.isHidden = !self.tabContentView.isHidden
        }
        }
    }
    
    
}
