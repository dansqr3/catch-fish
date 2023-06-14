
import UIKit

class SelectSettingsViewController: UIViewController {
	
	private let tableView = UITableView()
	
	var source: SettingsModel
	var index: Int
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setupConstraints()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(source: SettingsModel, index: Int) {
		self.source = source
		self.index = index
		super.init(nibName: nil, bundle: nil)
	}
	
	
	private func setupViews() {
		
		view.backgroundColor  = .systemBackground
		
		title = source.title
		
		let barButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(barButtonAction))
		navigationItem.rightBarButtonItem = barButton
		
		
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.Table.selectSettingsCellIdentifier)
	}
	
	private func setupConstraints() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
		])
	}
	
	@objc func barButtonAction() {
		NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationName.fish), object: nil)
		NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationName.settingsTableView), object: nil)
		dismiss(animated: true)
	}
}
