
import Foundation
import UIKit

class FishConfig {
	
	private let fishViewEntity = FishView()
	
	private var fishImage: String {
		Base.shared.currentSettings.sourceFishType
	}
	
	
	func configureFish(fishes: [FishView], view: UIView) {
		
		fishes.forEach {
			configureFishType(fishView: $0)
			configureFishDirection(fishView: $0)
			setupFishImage(fishView: $0)
			$0.imageView.contentMode = .scaleAspectFit
			$0.imageView.alpha = 0
			view.addSubview($0.imageView)
		}
		
	}
	
	private func configureFishType(fishView: FishView) {
		
		switch fishImage {
			case Constants.SelectSettings.FishType.mandarin:
				fishViewEntity.setType(fishView: fishView, type: .mandarin)
			case Constants.SelectSettings.FishType.green:
				fishViewEntity.setType(fishView: fishView, type: .green)
			case Constants.SelectSettings.FishType.red:
				fishViewEntity.setType(fishView: fishView, type: .red)
			case Constants.SelectSettings.FishType.yellow:
				fishViewEntity.setType(fishView: fishView, type: .yellow)
				
			case Constants.SelectSettings.FishType.random:
				
				let allTypes = [
					FishType.mandarin,
					FishType.green,
					FishType.red,
					FishType.yellow
				]
				
				fishViewEntity.setType(fishView: fishView, type: allTypes[Int.random(in: 0...3)])
				
			default:
				break
				
		}
		
	}
	
	func configureFishDirection(fishView: FishView) {
		
		switch fishView.type {
			case .mandarin, .red:
				fishViewEntity.setDirection(fishView: fishView, direction: .left)
			case .green, .yellow:
				fishViewEntity.setDirection(fishView: fishView, direction: .right)
			default:
				break
		}
		
	}
	
	private func setupFishImage(fishView: FishView) {
		
		switch fishView.type {
			case .mandarin:
				fishViewEntity.setImage(fishView: fishView, imageString: Constants.Fish.mandarin)
			case .green:
				fishViewEntity.setImage(fishView: fishView, imageString: Constants.Fish.green)
			case .red:
				fishViewEntity.setImage(fishView: fishView, imageString: Constants.Fish.red)
			case .yellow:
				fishViewEntity.setImage(fishView: fishView, imageString: Constants.Fish.yellow)
			default:
				break
		}
		
	}
	
}
