//
//  RestaurantTableViewController.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/7.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class RestaurantTableViewController: UITableViewController,UIPopoverPresentationControllerDelegate,UISearchResultsUpdating{
	var resultSearchController=UISearchController()
	var rests = [Restuarant]()
	var filteredRests = [Restuarant]()
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.rowHeight = 70
		//tableView.backgroundView=UIImageView(image: UIImage(named: "wg_blurred_backgrounds_14"))
		addRestaurantData()
		self.resultSearchController=UISearchController(searchResultsController: nil)
		self.resultSearchController.searchResultsUpdater=self
		self.resultSearchController.dimsBackgroundDuringPresentation=false
		self.resultSearchController.searchBar.sizeToFit()
		self.resultSearchController.searchBar.placeholder="Search Restaurant"
		self.tableView.tableHeaderView=self.resultSearchController.searchBar
		self.tableView.reloadData()
		fetch()
		print(Logs.count)
		if Logs.count==0{
			saveUserAndPassword("admin", password: "123456")
		}
    }
	var logged=false
	var Logs=[NSManagedObject]()
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
	
	
	
	
	func addRestaurantData(){
		self.rests.removeAll()
		self.rests.append(Restuarant(RestuarantName: "La Isla", coordinate: CLLocationCoordinate2D(latitude: 40.737723, longitude: -74.031045), RestuarantType: "Spanish", RestuarantAddress: "104 Washington St, Hoboken", RestuarantImage: UIImage(named: "Re1")!,Rate: 8))
		self.rests.append(Restuarant(RestuarantName: "Sushi Lounge", coordinate: CLLocationCoordinate2D(latitude: 40.738691, longitude: -74.029554), RestuarantType: "Japanese", RestuarantAddress: "200 Hudson St, Hoboken", RestuarantImage: UIImage(named: "Re2")!,Rate: 9))
		self.rests.append(Restuarant(RestuarantName: "McDonald's", coordinate: CLLocationCoordinate2D(latitude: 40.739946, longitude: -74.030356), RestuarantType: "American", RestuarantAddress: "234 Washington St, Hoboken", RestuarantImage: UIImage(named: "Re3")!,Rate: 7))
		self.rests.append(Restuarant(RestuarantName: "Amanda's Restaurant", coordinate: CLLocationCoordinate2D(latitude: 40.747612, longitude: -74.028003), RestuarantType: "American", RestuarantAddress: "908 Washington St, Hoboken", RestuarantImage: UIImage(named: "Re4")!,Rate: 8))
		self.rests.append(Restuarant(RestuarantName: "The Cuban Restaurant and Bar", coordinate: CLLocationCoordinate2D(latitude: 40.741025, longitude: -74.029604), RestuarantType: "Cuban, Latin American", RestuarantAddress: "333 Washington St, Hoboken", RestuarantImage: UIImage(named: "Re5")!,Rate: 6))
		
		self.rests.append(Restuarant(RestuarantName: "Brasserie de Paris", coordinate: CLLocationCoordinate2D(latitude: 40.739981, longitude: -74.042165), RestuarantType: "French, Brasseries", RestuarantAddress: "700 1st St, Hoboken", RestuarantImage: UIImage(named: "Re6")!,Rate: 10))
		self.rests.append(Restuarant(RestuarantName: "Cooper’s Union", coordinate: CLLocationCoordinate2D(latitude: 40.737528, longitude: -74.030046), RestuarantType: "Bars, Comfort Food", RestuarantAddress: "104 Hudson St, Hoboken", RestuarantImage: UIImage(named: "Re7")!,Rate: 6))
		self.rests.append(Restuarant(RestuarantName: "Rosticeria Da Gigi", coordinate: CLLocationCoordinate2D(latitude: 40.747865, longitude: -74.028052), RestuarantType: "Italian, American", RestuarantAddress: "916 Washington St, Hoboken", RestuarantImage: UIImage(named: "Re8")!,Rate: 4))
		self.rests.append(Restuarant(RestuarantName: "Stingray Lounge", coordinate: CLLocationCoordinate2D(latitude: 40.751658, longitude: -74.02689), RestuarantType: "Seafood", RestuarantAddress: "1210 Washington St, Hoboken", RestuarantImage: UIImage(named: "Re9")!,Rate: 4))
		self.rests.append(Restuarant(RestuarantName: "Mamoun’s Falafel Restaurant", coordinate: CLLocationCoordinate2D(latitude: 40.742410, longitude: -74.029665), RestuarantType: "Middle Eastern, Falafel", RestuarantAddress: "502 Washington St, Hoboken", RestuarantImage: UIImage(named: "Re10")!,Rate: 8))
	}
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if self.resultSearchController.active{
			return self.filteredRests.count
		}else{
			return self.rests.count
		}
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier : String = "Restaurant"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
		let row = indexPath.row
		var rest:Restuarant
		if self.resultSearchController.active{
			rest=self.filteredRests[row]
		}else{
			rest=self.rests[row]
		}
		cell.restaurantImage.image=rest.image!
		cell.restaurantImage.layer.backgroundColor=UIColor.clearColor().CGColor
		cell.restaurantImage.layer.cornerRadius=5
		cell.restaurantImage.layer.masksToBounds=true
		//cell.portrait.layer.borderWidth=0.5
		cell.restaurantImage.layer.borderColor=UIColor.grayColor().CGColor
		cell.restaurantName.text=rest.title
		cell.restaurantType.text=rest.subtitle
		cell.restaurantAddress.text=rest.address
		cell.backgroundColor=UIColor.whiteColor()
        return cell
    }

	// MARK: - Search
	func updateSearchResultsForSearchController(searchController: UISearchController) {
		self.filteredRests.removeAll(keepCapacity: false)
		let searchPredicate=NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
		var restsString=[String]()
		for re in rests{
			restsString.append(re.title!)
		}
		let array=(restsString as NSArray).filteredArrayUsingPredicate(searchPredicate)
		for ar in array{
			for re in rests{
				if ar as? String==re.title{
					filteredRests.append(re)
					break
				}
			}
		}
		self.tableView.reloadData()
	}

	//MARK: - popover
	@IBAction func Settings(sender: UIBarButtonItem) {
		let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let identifier:String
		if Logs.last!.valueForKey("logged") as? NSNumber == 1{
			identifier="Logged"
		}else{
			identifier="LogInfo"
		}
		let vc = storyboard.instantiateViewControllerWithIdentifier(identifier)
		vc.modalPresentationStyle = UIModalPresentationStyle.Popover
		let popover: UIPopoverPresentationController = vc.popoverPresentationController!
		popover.barButtonItem = sender
		popover.delegate = self
		presentViewController(vc, animated: true, completion:nil)
	}
	func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
		return UIModalPresentationStyle.FullScreen
		//        return UIModalPresentationStyle.None
	}
	func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
		let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
		let btnDone=UIBarButtonItem(image: UIImage(named: "delete_sign")!, style: .Done, target: self, action: "dismiss")
		navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
		navigationController.navigationBar.barStyle=UIBarStyle.Black
		navigationController.navigationBar.tintColor=UIColor.whiteColor()
		return navigationController
	}
	func dismiss() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	//MARK: - segue
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "restaurantDetail" {
			let rdvc = segue.destinationViewController as! RestaurantDetailViewController
			if self.resultSearchController.active{
				let updater = self.resultSearchController.searchResultsUpdater as! UITableViewController
				let indexPath = updater.tableView.indexPathForSelectedRow!
				rdvc.title=self.filteredRests[indexPath.row].title
				rdvc.restautant=self.filteredRests[indexPath.row]
				self.resultSearchController.active=false
				self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
			}else{
				let indexPath = self.tableView.indexPathForSelectedRow!
				rdvc.title = self.rests[indexPath.row].title
				rdvc.restautant=self.rests[indexPath.row]
				self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
			}
			//rdvc.hidesBottomBarWhenPushed=true;
		}
	}
}
