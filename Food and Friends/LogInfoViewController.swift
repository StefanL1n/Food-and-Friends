//
//  LogInfoViewController.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/6.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit
import CoreData

class LogInfoViewController: UIViewController,UITextFieldDelegate {

	@IBAction func login(sender: UIButton) {
		fetch()
		for log in Logs{
			let username=log.valueForKey("userName") as! String
			let password=log.valueForKey("password") as! String
			if userOut.text==username && passwordOut.text==password{
				updateLoginData(true)
				self.dismissViewControllerAnimated(true, completion: nil)
			}
			print(username+password)
		}
	}
	@IBOutlet weak var userOut: UITextField!{
		didSet{
			userOut.delegate=self
		}
	}
	@IBOutlet weak var passwordOut: UITextField!{
		didSet{
			passwordOut.delegate=self
		}
	}
	@IBAction func register(sender: UIButton) {
		fetch()
		saveUserAndPassword(userOut.text!, password: passwordOut.text!)
		updateLoginData(true)
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	@IBAction func loginWithFTG(sender: UIButton) {
		updateLoginData(true)
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	
	
	
	
	
	var Logs=[NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
		userOut.becomeFirstResponder()
		//self.view.backgroundColor=UIColor(patternImage: UIImage(named: "wg_blurred_backgrounds_14")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	
	func fetch(){
		let appDelegate=UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext
		let fetchRequest = NSFetchRequest(entityName: "LogInfo")
		do {
			let results=try managedContext.executeFetchRequest(fetchRequest)
			Logs = results as! [NSManagedObject]
		} catch let error as NSError {
			print("Could not fetch \(error), \(error.userInfo)")
		}
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

	func saveUserAndPassword(username: String,password: String) {
		let appDelegate=UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext
		let entity =  NSEntityDescription.entityForName("LogInfo",inManagedObjectContext:managedContext)
		let person = NSManagedObject(entity: entity!,insertIntoManagedObjectContext: managedContext)
		person.setValue(username, forKey: "userName")
		person.setValue(password, forKey: "password")
		person.setValue(0, forKey: "logged")
		do {
			try managedContext.save()
			Logs.append(person)
		} catch let error as NSError  {
			print("Could not save \(error), \(error.userInfo)")
		}
	}



}
