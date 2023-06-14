
import Foundation
import UIKit

protocol FishViewControllerDelegate: AnyObject {

	var fishCaughtCount: Int { get set }

	func didTap(_ gesture: UITapGestureRecognizer)
	func startButtonAction()
	func resetButtonAction()
	func settingsButtonAction()

}
