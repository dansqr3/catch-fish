
import Foundation
import UIKit

class FishView: Equatable {
	
	static func == (lhs: FishView, rhs: FishView) -> Bool {
		lhs.tag == rhs.tag
	}
	
	var type: FishType!
	var imageView: UIImageView!
	var direction: Direction!
	var tag: Tag!
	
	init(imageView: UIImageView, tag: Tag) {
		self.imageView = imageView
		self.tag = tag
	}
	
	init() {}
	
	
	func setImage(fishView: FishView, imageString: String?) {
		
		if let image = imageString {
			fishView.imageView = UIImageView(image: UIImage(named: image))
		}
		
	}
	
	func setTag(fishView: FishView, tag: Tag) {
		fishView.tag = tag
	}
	
	func setType(fishView: FishView, type: FishType) {
		fishView.type = type
	}
	
	func setDirection(fishView: FishView, direction: Direction) {
		fishView.direction = direction
	}
	
}
