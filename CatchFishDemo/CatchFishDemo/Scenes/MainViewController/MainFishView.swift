
import UIKit

class MainFishView: UIView {

	weak var fishViewControllerDelegate: FishViewControllerDelegate?

	var backImage = UIImage()
	let fishCaughtLabel = UILabel()
	let startButton = UIButton()
	let resetButton = UIButton()
	let settingsButton = UIButton()

	private let stackView = UIStackView()
	private var visualEffectView = UIVisualEffectView()

	let fish1 = FishView(imageView: UIImageView(), tag: .one)
	let fish2 = FishView(imageView: UIImageView(), tag: .two)
	let fish3 = FishView(imageView: UIImageView(), tag: .three)
	let fish4 = FishView(imageView: UIImageView(), tag: .four)
	let fish5 = FishView(imageView: UIImageView(), tag: .five)
	let fish6 = FishView(imageView: UIImageView(), tag: .six)
	let fish7 = FishView(imageView: UIImageView(), tag: .seven)
	let fish8 = FishView(imageView: UIImageView(), tag: .eight)
	let fish9 = FishView(imageView: UIImageView(), tag: .nine)


	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViews()
		setupConstraints()

		setupGesture()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Views

	private func setupViews() {

		backImage = UIImage(named: "ocean") ?? UIImage()
		backgroundColor = UIColor(patternImage: backImage)

		startButton.setTitle("Start", for: .normal)
		resetButton.setTitle("Reset", for: .normal)
		settingsButton.setTitle("Settings", for: .normal)

		fishCaughtLabel.text = "Fish caught: \(fishViewControllerDelegate?.fishCaughtCount ?? 0)"
		fishCaughtLabel.textColor = .black
		fishCaughtLabel.textAlignment = .center

		[startButton, resetButton, settingsButton].forEach {
			$0.setTitleColor(.black.withAlphaComponent(0.9), for: .normal)
			$0.setTitleColor(.systemGray3, for: .highlighted)
			$0.backgroundColor = Constants.Color.button.withAlphaComponent(0.3)
			$0.layer.cornerRadius = 17
			stackView.addArrangedSubview($0)
		}

		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 16

		let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
		visualEffectView = UIVisualEffectView(effect: blurEffect)
		visualEffectView.alpha = 0.2
		visualEffectView.layer.cornerRadius = 8
		visualEffectView.clipsToBounds = true

		[visualEffectView, fishCaughtLabel, stackView].forEach {
			addSubview($0)
		}

		startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
		resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
		settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)

	}

	private func setupConstraints() {

		[stackView, visualEffectView, fishCaughtLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

		let stackViewLeading = NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 16)
		let stackViewTrailing = NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -16)
		let stackViewBottom = NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)

		let fishCaughtLabelCenterX = NSLayoutConstraint(item: fishCaughtLabel, attribute: .centerX, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0)
		let fishCaughtLabelTop = NSLayoutConstraint(item: fishCaughtLabel, attribute: .top, relatedBy: .equal, toItem: safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 2)

		let visualEffectViewLeading = NSLayoutConstraint(item: visualEffectView, attribute: .leading, relatedBy: .equal, toItem: fishCaughtLabel, attribute: .leading, multiplier: 1, constant: -12)
		let visualEffectViewTrailing = NSLayoutConstraint(item: visualEffectView, attribute: .trailing, relatedBy: .equal, toItem: fishCaughtLabel, attribute: .trailing, multiplier: 1, constant: 12)
		let visualEffectViewTop = NSLayoutConstraint(item: visualEffectView, attribute: .top, relatedBy: .equal, toItem: fishCaughtLabel, attribute: .top, multiplier: 1, constant: -1)
		let visualEffectViewBottom = NSLayoutConstraint(item: visualEffectView, attribute: .bottom, relatedBy: .equal, toItem: fishCaughtLabel, attribute: .bottom, multiplier: 1, constant: 1)

		addConstraints([
			stackViewLeading,
			stackViewTrailing,
			stackViewBottom,
			fishCaughtLabelCenterX,
			fishCaughtLabelTop,
			visualEffectViewLeading,
			visualEffectViewTrailing,
			visualEffectViewBottom,
			visualEffectViewTop,
		])

		UIView.animate(withDuration: 1) { [unowned self] in
			[self.fishCaughtLabel, self.stackView, self.visualEffectView].forEach {
				$0.layoutIfNeeded()
			}
		}

	}

	// MARK: - Gesture
	
	private func setupGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
		addGestureRecognizer(tapGesture)

	}

	@objc func didTap(_ gesture: UITapGestureRecognizer) {

		fishViewControllerDelegate?.didTap(gesture)
		
	}
	@objc func startButtonAction() {

		fishViewControllerDelegate?.startButtonAction()
		
	}
	@objc func resetButtonAction() {

		fishViewControllerDelegate?.resetButtonAction()
		
	}
	@objc func settingsButtonAction() {

		fishViewControllerDelegate?.settingsButtonAction()
		
	}

}
