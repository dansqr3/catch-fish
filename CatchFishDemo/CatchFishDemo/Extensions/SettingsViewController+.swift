
import Foundation
import UIKit

extension SettingsViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		Constants.Source.title.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard var cell = tableView.dequeueReusableCell(withIdentifier: Constants.Table.settingsCellIdentifier) else { return UITableViewCell() }
		cell = UITableViewCell(style: .value2, reuseIdentifier: Constants.Table.settingsCellIdentifier)
		cell.accessoryType = .disclosureIndicator
		let text = Constants.Source.title[indexPath.row]
		
		var text2 = ""
		switch indexPath.row {
			case 0:
				text2 = Base.shared.currentSettings.sourceSpeed
			case 1:
				text2 = Base.shared.currentSettings.sourceSize
			case 2:
				text2 = String(Base.shared.currentSettings.sourceFishCount)
			case 3:
				text2 = Base.shared.currentSettings.sourceFishType
			default:
				break
		}
		
		var content = cell.defaultContentConfiguration()
		content.text = text
		content.secondaryText = text2
		cell.contentConfiguration = content
		return cell
	}
	
	
}

extension SettingsViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let index = indexPath.row
		present(UINavigationController(rootViewController: SelectSettingsViewController(source: source[indexPath.row], index: index)), animated: true)
	}
}
