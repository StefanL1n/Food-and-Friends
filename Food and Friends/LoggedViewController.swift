//
//  LoggedViewController.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/19.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit
import CoreData
class LoggedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func ss(sender: UIButton) {
	}
	@IBAction func signOut(sender: UIButton) {
		updateLoginData(false)
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	func updateLoginData(Logged: Bool) {
		let appDelegate=UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext
		let fetchRequest = NSFetchRequest(entityName: "LogInfo")
		//fetchRequest.predicate = NSPredicate(format: "userName = %@", Logged)
		do {
			let results=try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
			for result in results{
				if Logged{
					result.setValue(1, forKey: "logged")
				}else{
					result.setValue(0, forKey: "logged")
				}
			}
			try managedContext.save()
		} catch let error as NSError {
			print("Could not fetch \(error), \(error.userInfo)")
		}
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
