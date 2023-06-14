
import Foundation
import UIKit

class Rotation {
	
	func rotate(fish: FishView) {
		
		var duration = 0.4
		
		if fish.direction == .left {
			fish.direction = .right
		} else if fish.direction == .right {
			fish.direction = .left
		}
		
		switch Base.shared.currentSettings.sourceSpeed {
			case Constants.SelectSettings.Speed.veryFast:
				duration = 0.2
			case Constants.SelectSettings.Speed.fast:
				duration = 0.3
			default:
				break
		}
		
		
		UIView.animate(withDuration: duration,
					   delay: 0,
					   options: [.allowUserInteraction, .curveLinear]) {
			
			var transform = fish.imageView.transform
			transform.a *= -1
			fish.imageView.transform = transform
			
		}
		
	}
	
}
