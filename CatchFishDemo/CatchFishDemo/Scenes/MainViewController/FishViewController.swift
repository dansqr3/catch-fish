
import UIKit

class FishViewController: UIViewController, FishViewControllerDelegate {
	
	// MARK: - Properties

	private let mainFishView = MainFishView()

	private var isReset = false
	private var isFishCaught = false
	private var isStarted = false
	
	var fishCaughtCount = 0 {
		didSet {
			mainFishView.fishCaughtLabel.text = "Fish caught: \(fishCaughtCount)"
			if fishCaughtCount == Int(Base.shared.currentSettings.sourceFishCount) {
				mainFishView.startButton.isEnabled = false
				mainFishView.startButton.setTitle("Win!", for: .normal)
				isFishCaught = true
			}
		}
	}
	
	private lazy var fishesForGame: [FishView] = {
		var fishesForGame: [FishView] = []
		var temp = fishes
		for _ in 0..<(Int(fishCount) ?? 5) {
			fishesForGame.append(temp.removeFirst())
		}
		return fishesForGame
	}()
	
	private lazy var fishes: [FishView] = [mainFishView.fish1,
										   mainFishView.fish2,
										   mainFishView.fish3,
										   mainFishView.fish4,
										   mainFishView.fish5,
										   mainFishView.fish6,
										   mainFishView.fish7,
										   mainFishView.fish8,
										   mainFishView.fish9,
	]
	
	private var fishCount: String {
		Base.shared.currentSettings.sourceFishCount
	}
	private var speed: String {
		Base.shared.currentSettings.sourceSpeed
	}
	
	private let animation = Animation()
	private let fishConfig = FishConfig()
	private let reposition = Reposition()
	private let rotation = Rotation()
	
	private var orientation: UIInterfaceOrientation {
		let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
		if let currentOrientation = orientation {
			return currentOrientation
		}
		return UIInterfaceOrientation(rawValue: 1) ?? .portrait
	}

	// MARK: - Lifecycle

	override func loadView() {
		view = mainFishView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupDelegate()
		
		fishesForGame = updateFishForGame()
		
		NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: NSNotification.Name(Constants.NotificationName.fish), object: nil)
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		fishConfig.configureFish(fishes: fishes, view: mainFishView)
		reposition.setDefaultPosition(fishesForGame: fishesForGame, view: mainFishView, orientation: orientation)
		
		animation.startAnimate(fishesForGame: fishesForGame)
		
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		
		changeOrientation(fishesForGame: fishesForGame)
		
	}

	func didTap(_ gesture: UITapGestureRecognizer) {

		guard isStarted else { return }
		if isFishCaught { return }

		for fish in fishesForGame {

			let tapLocation = gesture.location(in: fish.imageView.superview)

			if (fish.imageView.layer.presentation()?.frame.contains(tapLocation))! {
				print("fish tapped!")
				fishCaughtAnimation(fish)
			}

		}

	}

	func startButtonAction() {

		guard mainFishView.startButton.titleLabel?.text == "Start" else { return }
		mainFishView.startButton.isEnabled = true

		mainFishView.startButton.setTitle("Fishing", for: .normal)

		guard !isStarted else { return }
		isReset = false

		for fish in fishesForGame {
			moveRandom(fish, x: fish.imageView.frame.origin.x)
		}

	}

	func resetButtonAction() {

		resetFlags()

		mainFishView.startButton.setTitle("Wait", for: .normal)
		mainFishView.fishCaughtLabel.text = "Fish loading"
		mainFishView.startButton.isEnabled = false

		resetPositions()

	}

	func settingsButtonAction() {

		resetFlags()

		resetPositions()

		present(UINavigationController(rootViewController: SettingsViewController()), animated: true)
	}

	// MARK: - Private Methods

	private func setupDelegate() {
		mainFishView.fishViewControllerDelegate = self
	}

	private func updateFishForGame() -> [FishView] {
		var result: [FishView] = []
		var temp = fishes
		for _ in 0..<(Int(fishCount) ?? 5) {
			result.append(temp.removeFirst())
		}
		return result
	}
	
	private func changeOrientation(fishesForGame: [FishView]) {
		
		if UIDevice.current.orientation == .landscapeLeft {
			reposition.reposition(fishesForGame: fishesForGame, view: view, orientation: .landscapeLeft)
			
		} else if UIDevice.current.orientation == .landscapeRight {
			reposition.reposition(fishesForGame: fishesForGame, view: view, orientation: .landscapeRight)
			
		} else if UIDevice.current.orientation.isPortrait {
			reposition.reposition(fishesForGame: fishesForGame, view: view, orientation: .portrait)
		}
		
	}
	
	private func moveRandom(_ fish: FishView, x: CGFloat) {
		
		guard !isReset else { return }
		if isFishCaught { return }
		isStarted = true
		
		var xRandom = 50
		var yRandom = 100
		
		let xLowerBound = Int((view.frame.minX + fish.imageView.frame.width / 2 + 24))
		let xUpperBound = Int((view.frame.maxX - fish.imageView.frame.width / 2 - 24))
		let yLowerBound = Int((view.frame.minY + fish.imageView.frame.height / 2 + 60))
		let yUpperBound = Int((view.frame.maxY - fish.imageView.frame.height / 2 - 140))
		
		if xLowerBound <= xUpperBound && yLowerBound <= yUpperBound {
			xRandom = Int.random(in: xLowerBound...xUpperBound)
			yRandom = Int.random(in: yLowerBound...yUpperBound)
		}
		
		let durationRandom = animation.animationSpeed(speed: speed)
		
			
		if Int(fish.imageView.frame.origin.x) - xRandom < -10 && fish.direction == .left {
				rotation.rotate(fish: fish)
		} else if Int(fish.imageView.frame.origin.x) - xRandom > 10 && fish.direction == .right {
			rotation.rotate(fish: fish)
		}
		
		UIView.animate(withDuration: durationRandom,
					   delay: 0,
					   options: [.curveEaseInOut, .allowUserInteraction]) {
			fish.imageView.center = CGPoint(x: xRandom, y: yRandom)
		} completion: { [unowned self] _ in

			guard !self.isReset else { return }
			if self.isFishCaught { return }
			self.moveRandom(fish, x: CGFloat(xRandom))
		}
		
	}
	
	private func fishCaughtAnimation(_ fish: FishView) {
		
		UIView.animate(withDuration: 0.5) {
			
			var transform = fish.imageView.transform
			transform.a *= 0.1
			transform.d *= 0.1
			fish.imageView.transform = transform
			
			fish.imageView.alpha = 0.1
			
		} completion: { [unowned self] _ in
			guard let index = fishesForGame.firstIndex(of: fish) else { return }
			self.fishesForGame.remove(at: index)
			self.fishCaughtCount += 1
			fish.imageView.isHidden = true
		}
		
	}
	
	private func resetPositions() {
		
		UIView.animate(withDuration: 0.4) { [unowned self] in
			
			self.fishesForGame.forEach {
				$0.imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
				$0.imageView.alpha = 0
			}
			
		} completion: { [unowned self] _ in
			
			self.fishesForGame.forEach {
				$0.imageView.isHidden = true
			}
			
			self.fishesForGame = updateFishForGame()
			self.fishConfig.configureFish(fishes: fishesForGame, view: view)
			
			if orientation == .landscapeLeft {
				self.reposition.setDefaultPosition(fishesForGame: fishesForGame, view: view, orientation: .landscapeLeft)
			} else if orientation == .landscapeRight {
				self.reposition.setDefaultPosition(fishesForGame: fishesForGame, view: view, orientation: .landscapeRight)
			} else if orientation.isPortrait {
				self.reposition.setDefaultPosition(fishesForGame: fishesForGame, view: view, orientation: .portrait)
			}
			
			UIView.animate(withDuration: 0.5, delay: 0.2) { [unowned self] in
				self.fishesForGame.forEach {
					$0.imageView.isHidden = false
					$0.imageView.alpha = 1
				}
			} completion: { [unowned self] _ in
				self.mainFishView.fishCaughtLabel.text = "Fish caught: \(self.fishCaughtCount)"
				self.mainFishView.startButton.setTitle("Start", for: .normal)
				self.mainFishView.startButton.isEnabled = true
			}
			
		}
	}
	
	private func resetFlags() {
		isFishCaught = false
		isReset = true
		isStarted = false
		fishCaughtCount = 0
	}

	// MARK: - @objc
	@objc func updateView() {
		
		resetPositions()
		
	}
	
}
