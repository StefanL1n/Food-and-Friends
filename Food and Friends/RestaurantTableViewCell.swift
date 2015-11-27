//
//  RestaurantTableViewCell.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/7.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit
import MapKit

class RestaurantTableViewCell: UITableViewCell {
	@IBOutlet weak var restaurantImage: UIImageView!
	@IBOutlet weak var restaurantName: UILabel!
	@IBOutlet weak var restaurantAddress: UILabel!
	@IBOutlet weak var restaurantType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}