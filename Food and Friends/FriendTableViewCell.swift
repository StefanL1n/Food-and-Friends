//
//  FriendTableViewCell.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/8.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
	@IBOutlet weak var portrait: UIImageView!
	@IBOutlet weak var friendName: UILabel!
	@IBOutlet weak var lastChatContent: UILabel!
	@IBOutlet weak var lastChatDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
