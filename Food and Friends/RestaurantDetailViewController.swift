//
//  RestaurantDetailViewController.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/8.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class RestaurantDetailViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UIPopoverPresentationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
	var restautant:Restuarant?=nil
	let imagePicker = UIImagePickerController()
	let locationManager = CLLocationManager()
	@IBOutlet weak var mapView: MKMapView!{
		didSet {
			mapView.mapType = .Standard
			mapView.delegate = self
		}
	}
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var restaurantType: UILabel!
	@IBOutlet weak var distanceInMile: UILabel!
	
	@IBOutlet weak var star1: UIImageView!
	@IBOutlet weak var star2: UIImageView!
	@IBOutlet weak var star3: UIImageView!
	@IBOutlet weak var star4: UIImageView!
	@IBOutlet weak var star5: UIImageView!
	
	@IBAction func mapButton(sender: UIButton) {
		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
		restautant?.mapItem().openInMapsWithLaunchOptions(launchOptions)
	}
	
	@IBOutlet weak var addresslabel: UIButton!
	@IBAction func AddressButton(sender: UIButton) {
		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
		restautant?.mapItem().openInMapsWithLaunchOptions(launchOptions)
	}
	@IBAction func CallButton(sender: UIButton) {
		UIApplication.sharedApplication().openURL(NSURL(string:"telprompt:2122068989")!)
	}
	@IBAction func ReserveButton(sender: UIButton) {
		
		
		/*
		let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier("Reserve")
		vc.modalPresentationStyle = UIModalPresentationStyle.Popover
		let popover: UIPopoverPresentationController = vc.popoverPresentationController!
		//popover.barButtonItem = sender
		popover.delegate = self
		presentViewController(vc, animated: true, completion:nil)
		*/
	}
	@IBAction func AddPhotoButton(sender: UIButton) {
		imagePicker.allowsEditing = false
		imagePicker.sourceType = .PhotoLibrary
		presentViewController(imagePicker, animated: true, completion: nil)
	}
	@IBAction func ViewMenuButton(sender: UIButton) {
		let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier("ViewMenu")
		vc.modalPresentationStyle = UIModalPresentationStyle.Popover
		let popover: UIPopoverPresentationController = vc.popoverPresentationController!
		//popover.barButtonItem = sender
		popover.delegate = self
		presentViewController(vc, animated: true, completion:nil)
		//self.view.setNeedsDisplay()
	}
	let regionRadius: CLLocationDistance = 200
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
		mapView.setRegion(coordinateRegion, animated: true)
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		imageView.image=restautant?.image
		addresslabel.setTitle(restautant?.address, forState: .Normal)
		addresslabel.setTitle(restautant?.address, forState: .Selected)
		restaurantType.text=restautant?.subtitle
		let initialLocation = CLLocation(latitude: restautant!.coordinate.latitude, longitude: restautant!.coordinate.longitude)
		centerMapOnLocation(initialLocation)
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		mapView.addAnnotation(restautant!)
		//self.view.backgroundColor=UIColor.blackColor()
		imagePicker.delegate=self
		setRateStarImage()
    }
	
	
	func setRateStarImage(){
		switch restautant!.rate!{
		case 1:
			star1.image=UIImage(named: "star_half_empty")
			star2.hidden=true
			star3.hidden=true
			star4.hidden=true
			star5.hidden=true
		case 2:
			star1.image=UIImage(named: "star_filled")
			star2.hidden=true
			star3.hidden=true
			star4.hidden=true
			star5.hidden=true
		case 3:
			star1.image=UIImage(named: "star_filled")
			star2.image=UIImage(named: "star_half_empty")
			star3.hidden=true
			star4.hidden=true
			star5.hidden=true
		case 4:
			star1.image=UIImage(named: "star_filled")
			star2.image=UIImage(named: "star_filled")
			star3.hidden=true
			star4.hidden=true
			star5.hidden=true
		case 5:
			star1.image=UIImage(named: "star_filled")
			star2.image=UIImage(named: "star_filled")
			star3.image=UIImage(named: "star_half_empty")
			star4.hidden=true
			star5.hidden=true
		case 6:
			star1.image=UIImage(named: "star_filled")
			star2.image=UIImage(named: "star_filled")
			star3.image=UIImage(named: "star_filled")
			star4.hidden=true
			star5.hidden=true
		case 7:
			star1.image=UIImage(named: "star_filled")
			star2.image=UIImage(named: "star_filled")
			star3.image=UIImage(named: "star_filled")
			star4.image=UIImage(named: "star_half_empty")
			star5.hidden=true
		case 8:
			star1.image=UIImage(named: "star_filled")
			star2.image=UIImage(named: "star_filled")
			star3.image=UIImage(named: "star_filled")
			star4.image=UIImage(named: "star_filled")
			star5.hidden=true
		case 9:
			star1.image=UIImage(named: "star_filled")
			star2.image=UIImage(named: "star_filled")
			star3.image=UIImage(named: "star_filled")
			star4.image=UIImage(named: "star_filled")
			star5.image=UIImage(named: "star_half_empty")
		case 10:
			star1.image=UIImage(named: "star_filled")
			star2.image=UIImage(named: "star_filled")
			star3.image=UIImage(named: "star_filled")
			star4.image=UIImage(named: "star_filled")
			star5.image=UIImage(named: "star_filled")
		default:
			break
		}
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			imageView.contentMode = .ScaleAspectFit
			imageView.image = pickedImage
		}
		dismissViewControllerAnimated(true, completion: nil)
	}
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
		if let usrlocation=mapView.userLocation.location{
			let tendistance=CLLocation(latitude: restautant!.coordinate.latitude, longitude: restautant!.coordinate.longitude).distanceFromLocation(usrlocation)/100*1.6
			let tendistanceInt=Int(tendistance)
			if tendistanceInt>10 && tendistanceInt%10==0{
				distanceInMile.text=String(tendistanceInt/10)+" miles"
			}
			if tendistanceInt>10 && !(tendistanceInt%10==0){
				distanceInMile.text=String(Float(tendistanceInt)/10)+" miles"
			}
			if tendistanceInt==10{
				distanceInMile.text=String(tendistanceInt/10)+" mile"
			}
			if tendistanceInt<10{
				distanceInMile.text=String(Float(tendistanceInt)/10)+" mile"
			}
			
			print(tendistanceInt)
		}
	}


	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		if let annotation = annotation as? Restuarant {
			let identifier = "pin"
			var view: MKPinAnnotationView
			if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
				as? MKPinAnnotationView { // 2
					dequeuedView.annotation = annotation
					view = dequeuedView
			} else {
				// 3
				view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
				view.canShowCallout = true
				view.calloutOffset = CGPoint(x: -5, y: 5)
				view.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure) as UIView
			}
			return view
		}
		return nil
	}
	
	func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		mapView.showsUserLocation = (status == .AuthorizedWhenInUse)
	}

	func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
		return UIModalPresentationStyle.FullScreen
		//return UIModalPresentationStyle.None
	}
	func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
		let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
		let btnDone=UIBarButtonItem(image: UIImage(named: "delete_sign")!, style: .Done, target: self, action: "dismiss")
		navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
		return navigationController
	}
	func dismiss() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}
