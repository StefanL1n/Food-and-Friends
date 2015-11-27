//
//  ReserveViewController.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/9.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit

class ReserveViewController: UIViewController {
	@IBAction func ReserveDate(sender: UIDatePicker) {
		let dateformatter=NSDateFormatter()
		dateformatter.dateFormat="h a, MM/dd"
		people.text="Reserve a "+String(numberOfPeople)+" people table at "+dateformatter.stringFromDate(sender.date)
	}
	
	@IBAction func confirm(sender: UIButton) {
		//self.dismissViewControllerAnimated(true, completion: nil)
		self.navigationController?.popViewControllerAnimated(true)
	}
	@IBAction func numberOfPeople(sender: UIStepper) {
		let dateformatter=NSDateFormatter()
		dateformatter.dateFormat="h a, MM/dd"
		people.text="Reserve a "+String(Int(sender.value))+" people table at "+dateformatter.stringFromDate(datePickerOut.date)
		numberOfPeople=Int(sender.value)
	}
	@IBOutlet weak var people: UILabel!
	
	@IBOutlet weak var datePickerOut: UIDatePicker!
	
	var numberOfPeople=1
	
    override func viewDidLoad() {
        super.viewDidLoad()
		datePickerOut.minimumDate=NSDate()
		let dateformatter=NSDateFormatter()
		dateformatter.dateFormat="h a, MM/dd"
		people.text="Reserve a "+String(numberOfPeople)+" people table at "+dateformatter.stringFromDate(datePickerOut.date)
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
