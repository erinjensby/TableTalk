//
//  TabBarController.swift
//  TableTalk
//
//  Created by Patrick Liu on 3/6/17.
//  Copyright © 2017 Patrick Liu. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var places = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let secondTab = self.viewControllers?[1] as! UINavigationController
        
        let listViewController = secondTab.topViewController as! LocationListViewController
        
        listViewController.places = self.places
        
        let fourthTab = self.viewControllers?[3] as! UINavigationController
        let searchViewController = fourthTab.viewControllers[0] as! SearchViewController
        searchViewController.places = self.places
        
        self.tabBar.items?[0].image = UIImage(named: "compass")?.withRenderingMode(.alwaysOriginal)
       
        self.tabBar.items?[0].selectedImage = UIImage(named: "compassSelected")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[1].image = UIImage(named: "list")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[1].selectedImage = UIImage(named: "listSelected")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[2].image = UIImage(named: "checkin")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[2].selectedImage = UIImage(named: "checkinSelected")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[3].image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[3].selectedImage = UIImage(named: "searchSelected")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[4].image = UIImage(named: "favorite")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items?[4].selectedImage = UIImage(named: "favoriteSelected")?.withRenderingMode(.alwaysOriginal)
        
        // Do any additional setup after loading the view.
        self.selectedIndex = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let navVC = viewController as? UINavigationController
        if navVC?.viewControllers.count == 2 {
            navVC?.popViewController(animated: true)
        }
        let searchNavVC = self.viewControllers?[3] as? UINavigationController
        if let searchVC = searchNavVC?.viewControllers[0] as? SearchViewController {
            searchVC.searchController.isActive = false
        }
    }
}
