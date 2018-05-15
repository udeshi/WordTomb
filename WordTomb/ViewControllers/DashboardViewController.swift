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

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var hamgurgerMenu: UIView!
    var categories: [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.delegate = self
        tableView.dataSource = self
        hamgurgerMenu.isHidden = true
    }
    
    func loadCategories () {
        categories = CoreDataHandler.fetchCategoryDetails()
        
        
    }
    
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        
        UIView.transition(with: hamgurgerMenu, duration: 0.8, options: [.curveEaseInOut, .transitionCrossDissolve] , animations: { self.hamgurgerMenu.isHidden = !self.hamgurgerMenu.isHidden })
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
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "oddDashboardCellView") as! DashboardCustomTableViewCell
        cell.oddCategoryImage.image = UIImage(named: categories[indexPath.row].image!)
        cell.oddCategoryName.text = categories[indexPath.row].name
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaultsHandler().save(data: categories[indexPath.row].id, key: "selectedCategoryId")
        
        //navigate to gamelevel
        let tempView = Bundle.main.loadNibNamed("Chambers", owner: self, options: nil)?.first as? Chambers
        if let tempView = tempView {
           UIView.transition(with: self.view, duration: 0.5, options: UIViewAnimationOptions.transitionCurlUp,animations: {
            tempView.frame.size = self.view.frame.size
            self.view.addSubview(tempView)
               self.view.bringSubview(toFront: tempView)
           }, completion: nil)
        
        }
//        let levelsScreen = UIView(frame: CGRect(x:0,y:0, width: view.frame.size.width, height: view.frame.size.height))
//       
//      
    }

}
