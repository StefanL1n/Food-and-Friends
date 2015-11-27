//
//  ChatViewController.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/17.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import syncano_ios
class ChatViewController: JSQMessagesViewController {
	let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor(red: 10/255, green: 180/255, blue: 230/255, alpha: 1.0))
	let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
	
	var messages = [JSQMessage]()
	var chat:Friend?=nil
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setup()
		self.addDemoMessages()
		self.view.backgroundColor=UIColor(red: 234/255, green: 241/255, blue: 241/255, alpha: 1.0)
    }

	func reloadMessagesView() {
		self.collectionView?.reloadData()
	}
	func addDemoMessages() {
		for onePieceOfChat in chat!.chats{
			var sender=chat!.name
			if onePieceOfChat.myChat{
				sender=self.senderId
			}
			self.messages.append(JSQMessage(senderId: sender, displayName: sender, text: onePieceOfChat.chatContent))
		}
		reloadMessagesView()
	}
	
	func setup() {
		self.senderId = UIDevice.currentDevice().identifierForVendor?.UUIDString
		self.senderDisplayName = UIDevice.currentDevice().identifierForVendor?.UUIDString
	}
	//MARK - Data Source
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.messages.count
	}
	
	override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
		return self.messages[indexPath.row]
	}
	
	override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
		self.messages.removeAtIndex(indexPath.row)
	}
	
	override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
		let data = messages[indexPath.row]
		switch(data.senderId) {
		case self.senderId:
			return self.outgoingBubble
		default:
			return self.incomingBubble
		}
	}
	override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
		let data = messages[indexPath.row]
		switch(data.senderId) {
		case self.senderId:
			return JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "Haoyu Lin")!, diameter: 60)
		default:
			return JSQMessagesAvatarImageFactory.avatarImageWithImage(chat?.portrait, diameter: 60)
		}		
	}
	override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
		let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
		self.messages.append(message)
		self.finishSendingMessage()
	}
	
	override func didPressAccessoryButton(sender: UIButton!) {
		
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
