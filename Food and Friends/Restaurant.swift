import Foundation
import MapKit
import Contacts
import AddressBook
class Restuarant: NSObject, MKAnnotation {
	let title:String?
	let coordinate: CLLocationCoordinate2D
	let subtitle:String?
	let address:String?
	let image:UIImage?
	let rate:Int?
	init(RestuarantName: String,coordinate: CLLocationCoordinate2D,RestuarantType:String,RestuarantAddress:String,RestuarantImage:UIImage,Rate:Int) {
		self.title = RestuarantName
		self.coordinate = coordinate
		self.subtitle=RestuarantType
		self.address=RestuarantAddress
		self.image=RestuarantImage
		if Rate>10{
			self.rate=10
		}else if Rate<0{
			self.rate=0
		}else{
			self.rate=Rate
		}
		super.init()
	}
	func mapItem() -> MKMapItem {
		let addressDictionary = [String(CNPostalAddressStreetKey): self.address!]
		let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = title
		return mapItem
	}
}

