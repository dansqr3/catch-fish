
import Foundation
import UIKit

class Reposition {
	
	private let fishConfig = FishConfig()
	
	func setDefaultPosition(fishesForGame: [FishView], view: UIView, orientation: UIInterfaceOrientation) {
		
		fishesForGame.forEach {
			$0.imageView.transform = .identity
		}
		
		if orientation.isLandscape{
			setupHorizontalFrame(fishArray: fishesForGame, view: view)
		} else if orientation.isPortrait {
			setupVerticalFrame(fishArray: fishesForGame, view: view)
		}
		
	}
	
	func reposition(fishesForGame fishArray: [FishView], view: UIView, orientation: UIInterfaceOrientation) {
		
		UIView.animate(withDuration: 0.5) {

			fishArray.forEach {
				$0.imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
				$0.imageView.alpha = 0
				$0.imageView.isHidden = true
			}
			
		} completion: { [unowned self] _ in
			
			if orientation.isLandscape {
				setupHorizontalFrame(fishArray: fishArray, view: view)
			} else if orientation.isPortrait {
				setupVerticalFrame(fishArray: fishArray, view: view)
			}
			
			UIView.animate(withDuration: 1, delay: 0.5) {
				fishArray.forEach {
					self.fishConfig.configureFishDirection(fishView: $0)
					$0.imageView.isHidden = false
					$0.imageView.alpha = 1
				}
			}
			
		}
		
	}
	
	private func setupVerticalFrame(fishArray: [FishView], view: UIView) {
		for index in fishArray.indices {
			switch index {
				case 0:
					fishArray[0].imageView.frame = Constants.Frame.Vertical.fish1(view: view)
				case 1:
					fishArray[1].imageView.frame = Constants.Frame.Vertical.fish2(view: view)
				case 2:
					fishArray[2].imageView.frame = Constants.Frame.Vertical.fish3(view: view)
				case 3:
					fishArray[3].imageView.frame = Constants.Frame.Vertical.fish4(view: view)
				case 4:
					fishArray[4].imageView.frame = Constants.Frame.Vertical.fish5(view: view)
				case 5:
					fishArray[5].imageView.frame = Constants.Frame.Vertical.fish6(view: view)
				case 6:
					fishArray[6].imageView.frame = Constants.Frame.Vertical.fish7(view: view)
				case 7:
					fishArray[7].imageView.frame = Constants.Frame.Vertical.fish8(view: view)
				case 8:
					fishArray[8].imageView.frame = Constants.Frame.Vertical.fish9(view: view)
				default:
					break
			}
		}
	}
	
	private func setupHorizontalFrame(fishArray: [FishView], view: UIView) {
		for index in fishArray.indices {
			switch index {
				case 0:
					fishArray[0].imageView.frame = Constants.Frame.Horizontal.fish1(view: view)
				case 1:
					fishArray[1].imageView.frame = Constants.Frame.Horizontal.fish2(view: view)
				case 2:
					fishArray[2].imageView.frame = Constants.Frame.Horizontal.fish3(view: view)
				case 3:
					fishArray[3].imageView.frame = Constants.Frame.Horizontal.fish4(view: view)
				case 4:
					fishArray[4].imageView.frame = Constants.Frame.Horizontal.fish5(view: view)
				case 5:
					fishArray[5].imageView.frame = Constants.Frame.Horizontal.fish6(view: view)
				case 6:
					fishArray[6].imageView.frame = Constants.Frame.Horizontal.fish7(view: view)
				case 7:
					fishArray[7].imageView.frame = Constants.Frame.Horizontal.fish8(view: view)
				case 8:
					fishArray[8].imageView.frame = Constants.Frame.Horizontal.fish9(view: view)
				default:
					break
			}
		}
	}
	
}
