//
//  NearMeViewController.swift
//  Food and Friends
//
//  Created by LHYER on 15/11/6.
//  Copyright © 2015年 Haoyu Lin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
class NearMeViewController: UIViewController,UIPopoverPresentationControllerDelegate,MKMapViewDelegate,CLLocationManagerDelegate{
	@IBOutlet weak var mapView: MKMapView!
	@IBAction func getLocation(sender: UIButton) {
		zoomToUserLocationInMapView(mapView)
	}
	let locationManager = CLLocationManager()
	var rests=[Restuarant]()
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.mapType = .Standard
		mapView.delegate = self
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		//zoomToUserLocationInMapView(mapView)
		addRestaurantData()
		let initialLocation = CLLocation(latitude: 40.745461, longitude: -74.030600)
		centerMapOnLocation(initialLocation)
		for restuarant in rests{
			mapView.addAnnotation(restuarant)
		}
		fetch()
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
	func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,calloutAccessoryControlTapped control: UIControl) {
		self.performSegueWithIdentifier("MapShowDetail", sender: view)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "MapShowDetail" {
			let rdvc = segue.destinationViewController as! RestaurantDetailViewController
			let detail = sender as! MKAnnotationView
			rdvc.title = detail.annotation!.title!
			for rest in rests{
				if rest.coordinate.latitude==detail.annotation!.coordinate.latitude && rest.coordinate.longitude==detail.annotation!.coordinate.longitude{
					rdvc.restautant=rest
				}
			}
			rdvc.hidesBottomBarWhenPushed=true;
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
	
	
	
	let regionRadius: CLLocationDistance = 1000
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
		mapView.setRegion(coordinateRegion, animated: true)
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
	func zoomToUserLocationInMapView(mapView: MKMapView) {
		if let coordinate = mapView.userLocation.location?.coordinate {
			let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
			mapView.setRegion(region, animated: true)
		}
	}
	// MARK: - Popover
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

}
