//
//  TabBarController.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/16.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController,UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.tabBar.barStyle=UIBarStyle.Black
		self.tabBar.tintColor=UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
