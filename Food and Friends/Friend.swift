//
//  Friend.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/8.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import Foundation
import UIKit
class Friend: NSObject {
	var name:String!
	var available:Bool!
	var chats=[Chat]()
	var portrait:UIImage?
	init(FriendName: String,FriendAvailability: Bool,FriendPortrait: UIImage) {
		self.name=FriendName
		self.available=FriendAvailability
		self.portrait=FriendPortrait
		super.init()
	}
	func addChat(ChatContent: String,IsMyChat:Bool,ChatTime:String){
		self.chats.append(Chat(chatContent: ChatContent, myChat: IsMyChat, chatTime: ChatTime))
	}
	struct Chat {
		var chatContent:String
		var myChat:Bool
		var chatTime:String
	}
}