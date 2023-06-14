
import Foundation
import UIKit

class Animation {
	
	func startAnimate(fishesForGame: [FishView]) {
		
		UIView.animate(withDuration: 1) {
			fishesForGame.forEach {
				$0.imageView.alpha = 1
				let animation = CABasicAnimation(keyPath: "position")
				animation.fromValue = NSValue(cgPoint: CGPoint(x: $0.imageView.center.x - 3, y: $0.imageView.center.y))
				animation.toValue = NSValue(cgPoint: CGPoint(x: $0.imageView.center.x + 3, y: $0.imageView.center.y))
				animation.duration = 0.05
				animation.repeatCount = 8
				animation.autoreverses = true
				$0.imageView.layer.add(animation, forKey: "position")
			}
		}
		
	}
	
	func animationSpeed(speed: String) -> Double {
		switch speed {
			case Constants.SelectSettings.Speed.slow:
				return Double.random(in: Constants.FishSpeed.slow)
			case Constants.SelectSettings.Speed.normal:
				return Double.random(in: Constants.FishSpeed.normal)
			case Constants.SelectSettings.Speed.fast:
				return Double.random(in: Constants.FishSpeed.fast)
			case Constants.SelectSettings.Speed.veryFast:
				return Double.random(in: Constants.FishSpeed.veryFast)
			default:
				break
		}
		return Double.random(in: 1...2)
	}
	
}
