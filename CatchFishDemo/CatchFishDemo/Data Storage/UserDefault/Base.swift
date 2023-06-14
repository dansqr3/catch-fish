
import Foundation

struct Settings: Codable {
	var sourceSpeed: String
	var sourceSize: String
	var sourceFishCount: String
	var sourceFishType: String
}

class Base {
	
	static let shared = Base()
	
	private let userDefault = UserDefaults.standard
	
	private let defaultSettings = Settings(
		sourceSpeed: Constants.SelectSettings.Speed.normal,
		sourceSize: Constants.SelectSettings.Size.big,
		sourceFishCount: Constants.SelectSettings.FishCount.five,
		sourceFishType: Constants.SelectSettings.FishType.mandarin
	)
	
	var currentSettings: Settings {
		
		get {
			
			if let data = userDefault.object(forKey: Constants.UserDefaultKey.settings) as? Data {
				let settings = try! PropertyListDecoder().decode(Settings.self, from: data)
				return settings
				
			} else {
				
				if let data = try? PropertyListEncoder().encode(defaultSettings) {
					userDefault.set(data, forKey: Constants.UserDefaultKey.settings)
				}
				
				return defaultSettings
				
			}
			
		}
		
		set {
			
			if let data = try? PropertyListEncoder().encode(newValue) {
				userDefault.set(data, forKey: Constants.UserDefaultKey.settings)
			}
			
		}
		
	}
	
	func resetSettings() {
		currentSettings = defaultSettings
	}
	
}
