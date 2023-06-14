
import Foundation
import UIKit

extension SelectSettingsViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		source.content.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Table.selectSettingsCellIdentifier) else { return UITableViewCell() }
		let text = source.content[indexPath.row]
		var content = cell.defaultContentConfiguration()
		content.text = text
		cell.contentConfiguration = content
		return cell
	}

}

extension SelectSettingsViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		switch index {
			case 0:
				Base.shared.currentSettings.sourceSpeed = Constants.Source.speed[indexPath.row]
			case 1:
				Base.shared.currentSettings.sourceSize = Constants.Source.size[indexPath.row]
			case 2:
				Base.shared.currentSettings.sourceFishCount = Constants.Source.fishCount[indexPath.row]
			case 3:
				Base.shared.currentSettings.sourceFishType = Constants.Source.fishType[indexPath.row]
			default:
				break
		}
		
		NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationName.fish), object: nil)
		NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationName.settingsTableView), object: nil)
		dismiss(animated: true)
		
	}
}
