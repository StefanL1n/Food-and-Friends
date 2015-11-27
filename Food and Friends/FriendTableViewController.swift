//
//  FriendTableViewController.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/8.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit
import CoreData
class FriendTableViewController: UITableViewController,UIPopoverPresentationControllerDelegate {
	var friends=[Friend]()
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.rowHeight = 80
		//tableView.separatorColor=UIColor.clearColor()
		//tableView.backgroundView=UIImageView(image: UIImage(named: "wg_blurred_backgrounds_14"))
		addFriendsData()
		self.tableView.reloadData()
		//self.title="Available Friends"
		
		
    }
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		fetch()
		if Logs.last!.valueForKey("logged") as? NSNumber == 0{
			PopOverTo("LogInfo")
		}
	}
	
	
	var Logs=[NSManagedObject]()
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
	
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier : String = "Friend"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FriendTableViewCell
		let frd=self.friends[indexPath.row]
		cell.portrait.image=frd.portrait
		cell.portrait.layer.backgroundColor=UIColor.clearColor().CGColor
		cell.portrait.layer.cornerRadius=30
		cell.portrait.layer.masksToBounds=true
		//cell.portrait.layer.borderWidth=0.5
		cell.portrait.layer.borderColor=UIColor.grayColor().CGColor
		cell.friendName.text=frd.name
		cell.lastChatContent.text=frd.chats.last?.chatContent
		cell.lastChatDate.text=frd.chats.last?.chatTime
		cell.backgroundColor=UIColor.clearColor()
		return cell
    }
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		if segue.identifier == "Chat" {
			let rdvc = segue.destinationViewController as! ChatViewController
			let indexPath = self.tableView.indexPathForSelectedRow!
			rdvc.title = self.friends[indexPath.row].name
			rdvc.chat=self.friends[indexPath.row]
			self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
			//rdvc.navigationItem.leftBarButtonItem=UIBarButtonItem(image: UIImage(named: "back"), style: .Done, target: self, action: "back")
			rdvc.hidesBottomBarWhenPushed=true
		}
    }
	
	// MARK: - add Friends Data
	func addFriendsData(){
		self.friends.removeAll()
		self.friends.append(Friend(FriendName: "Sacnite Roma", FriendAvailability: true, FriendPortrait: UIImage(named: "IMG_0442")!))
		self.friends.last?.addChat("Bro, what are you doing?", IsMyChat: true, ChatTime: "11/8/2015")
		self.friends.last?.addChat("Just finished my job", IsMyChat: false, ChatTime: "11/8/2015")
		self.friends.last?.addChat("Good, wanna have dinner with me?", IsMyChat: true, ChatTime: "11/8/2015")
		self.friends.last?.addChat("Sounds great", IsMyChat: false, ChatTime: "11/8/2015")
		
		self.friends.append(Friend(FriendName: "Jarah Carman", FriendAvailability: true, FriendPortrait: UIImage(named: "IMG_0443")!))
		self.friends.last?.addChat("How was your day?", IsMyChat: true, ChatTime: "11/8/2015")
		self.friends.last?.addChat("Tough!", IsMyChat: false, ChatTime: "11/8/2015")
		self.friends.last?.addChat("Sorry to hear that, if you want find someone to talk to I am always here", IsMyChat: true, ChatTime: "11/8/2015")
		self.friends.last?.addChat("Thank you , I know a very nice restaurant, come with me", IsMyChat: false, ChatTime: "11/8/2015")
		
		self.friends.append(Friend(FriendName: "Blagoj Cardona", FriendAvailability: true, FriendPortrait: UIImage(named: "IMG_0444")!))
		self.friends.last?.addChat("The restaurant is great", IsMyChat: false, ChatTime: "11/7/2015")
		self.friends.last?.addChat("Totally agree, great food and very cheap", IsMyChat: true, ChatTime: "11/7/2015")
		
		self.friends.append(Friend(FriendName: "Vespasian Svensson", FriendAvailability: true, FriendPortrait: UIImage(named: "IMG_0445")!))
		self.friends.last?.addChat("So nice to have dinner with you", IsMyChat: true, ChatTime: "11/4/2015")
		self.friends.last?.addChat("Me too, what a great app, lol", IsMyChat: false, ChatTime: "11/4/2015")
		
		self.friends.append(Friend(FriendName: "Adwoa Arentz", FriendAvailability: true, FriendPortrait: UIImage(named: "IMG_0446")!))
		self.friends.last?.addChat("Are you available now, I am looking for a friend to have dinner with, I don't want to eat alone", IsMyChat: true, ChatTime: "11/4/2015")
		self.friends.last?.addChat("I am sorry bro, but I really need to study, have a test tomorrow ", IsMyChat: false, ChatTime: "11/4/2015")
		
		self.friends.append(Friend(FriendName: "Tracee Queen", FriendAvailability: true, FriendPortrait: UIImage(named: "IMG_0447")!))
		self.friends.last?.addChat("Wanna have dinner with me?", IsMyChat: false, ChatTime: "11/2/2015")
		self.friends.last?.addChat("Sorry, but I already have an appointment with my friend", IsMyChat: true, ChatTime: "11/2/2015")
		
		self.friends.append(Friend(FriendName: "Isidore Godfrey", FriendAvailability: true, FriendPortrait: UIImage(named: "IMG_0448")!))
		self.friends.last?.addChat("Houston Rockets!!", IsMyChat: true, ChatTime: "11/1/2015")
		self.friends.last?.addChat("I am so excited, they finally won the champion, James Harden, what a great game!", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.last?.addChat("We really need to celebrate it ", IsMyChat: true, ChatTime: "11/1/2015")
		self.friends.last?.addChat("Absolutely!", IsMyChat: false, ChatTime: "11/1/2015")
		
		self.friends.append(Friend(FriendName: "Rilla Rogers", FriendAvailability: true, FriendPortrait: UIImage(named: "IMG_0450")!))
		self.friends.last?.addChat("If you leave now, you lose everything.", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.last?.addChat("You think I'm being paranoid but the truth is I'm worth nothing to her alive.", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.last?.addChat("Midnight, on the bridge. Come alone.", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.last?.addChat("Quick, hide behind the sofa!", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.last?.addChat("There's someone in the house!", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.last?.addChat("F*** you!!!Are you insane?", IsMyChat: true, ChatTime: "11/1/2015")
		self.friends.last?.addChat("Yes!", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.append(Friend(FriendName: "Oedipus Ó Néill", FriendAvailability: true, FriendPortrait: UIImage(named: "IMG_0451")!))
		self.friends.last?.addChat("What have you done with my pills? I need them!", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.last?.addChat("Why did you scream like that?", IsMyChat: true, ChatTime: "11/1/2015")
		self.friends.last?.addChat("Why didn't he come and talk to me himself?", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.last?.addChat("I''m not really surprised that you murdered him.", IsMyChat: true, ChatTime: "11/1/2015")
		self.friends.last?.addChat("I think the room is bugged.", IsMyChat: false, ChatTime: "11/1/2015")
		self.friends.last?.addChat("Move away from the door and let me at him.", IsMyChat: true, ChatTime: "11/1/2015")
	}
	// MARK: - Settings Popover
	@IBAction func Settings(sender: UIBarButtonItem) {
		if Logs.last!.valueForKey("logged") as? NSNumber == 1{
			PopOverTo("Logged")
		}else{
			PopOverTo("LogInfo")
		}
	}
	@IBAction func Add(sender: UIBarButtonItem) {
		PopOverTo("AddFriend")
	}
	func PopOverTo(Identifier: String){
		let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier(Identifier)
		vc.modalPresentationStyle = UIModalPresentationStyle.Popover
		let popover: UIPopoverPresentationController = vc.popoverPresentationController!
		//popover.barButtonItem = sender
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
}
