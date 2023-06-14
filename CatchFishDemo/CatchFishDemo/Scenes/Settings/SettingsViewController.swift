
import UIKit

class SettingsViewController: UIViewController {
	
	private let tableView = UITableView()
	private let resetButton = UIButton()
	
	var source: [SettingsModel] {
		[
			SettingsModel(title: Constants.SelectSettings.Title.speed, content: Constants.Source.speed),
			SettingsModel(title: Constants.SelectSettings.Title.size, content: Constants.Source.size),
			SettingsModel(title: Constants.SelectSettings.Title.fishCount, content: Constants.Source.fishCount),
			SettingsModel(title: Constants.SelectSettings.Title.fishType, content: Constants.Source.fishType)
		]
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setupConstraints()
		
		NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: NSNotification.Name(Constants.NotificationName.settingsTableView), object: nil)
		
	}
	
	private func setupViews() {
		
		view.backgroundColor  = .systemBackground
		
		title = "Settings"
		
		let barButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(barButtonAction))
		navigationItem.rightBarButtonItem = barButton
		
		tableView.dataSource = self
		tableView.delegate = self
		tableView.separatorInset = .zero
		
		resetButton.backgroundColor = .systemBlue
		resetButton.setTitleColor(.systemBackground, for: .normal)
		resetButton.setTitleColor(.systemGray3, for: .highlighted)
		resetButton.layer.cornerRadius = 17
		resetButton.setTitle("Reset default settings", for: .normal)
		resetButton.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
		
		view.addSubview(tableView)
		view.addSubview(resetButton)
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.Table.settingsCellIdentifier)
	}
	
	private func setupConstraints() {
		[tableView, resetButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
			tableView.heightAnchor.constraint(equalToConstant: 200),
			
			resetButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
			resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			resetButton.widthAnchor.constraint(equalToConstant: 200)
		])
	}
	
	@objc func barButtonAction() {
		NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationName.fish), object: nil)
		NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationName.settingsTableView), object: nil)
		dismiss(animated: true)
	}
	
	@objc func resetButtonAction() {
		Base.shared.resetSettings()
		NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationName.fish), object: nil)
		NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationName.settingsTableView), object: nil)
	}
	
	@objc func updateTableView() {
		tableView.reloadData()
	}
	
}

