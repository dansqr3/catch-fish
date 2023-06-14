
import Foundation
import UIKit

enum Constants {
	
	enum Fish {
		static let mandarin = "fishMandarin"
		static let green = "fishGreen"
		static let red = "fishRed"
		static let yellow = "fishYellow"
	}
	
	enum SizeCoefficient {
		static var coefficient: Double {
			switch Base.shared.currentSettings.sourceSize {
				case Constants.SelectSettings.Size.small:
					return 0.6
				case Constants.SelectSettings.Size.normal:
					return 0.85
				case Constants.SelectSettings.Size.big:
					return 1
				case Constants.SelectSettings.Size.huge:
					return 1.15
				default:
					break
			}
			return 1
		}
	}
	
	enum FishSize {
		static var width: Double {
			123 * Constants.SizeCoefficient.coefficient
		}
		static var height: Double {
			87.5 * Constants.SizeCoefficient.coefficient
		}
		
		static let multiply = width / height
	}
	
	enum FishSpeed {
		static let slow: ClosedRange<Double> = 1.7...2.5
		static let normal: ClosedRange<Double> = 1.3...2.1
		static let fast: ClosedRange<Double> = 1.0...1.8
		static let veryFast: ClosedRange<Double> = 0.4...1.2
	}
	
	enum Indent {
		static var bottomMargin: Double {
			175
		}
		static var topMargin: Double {
			80
		}
	}
	
	enum Color {
		static let button = #colorLiteral(red: 0.5568627451, green: 0.5490196078, blue: 0.5254901961, alpha: 1)
		static let label = #colorLiteral(red: 0.1647058824, green: 0.4509803922, blue: 0.6470588235, alpha: 1)
	}
	
	enum Table {
		static let settingsCellIdentifier = "settingsCell"
		static let selectSettingsCellIdentifier = "selectSettingsCell"
	}
	
	enum UserDefaultKey {
		static let settings = "settings"
	}
	
	enum NotificationName {
		static let settingsTableView = "settingsTableView"
		static let fish = "fish"
	}
	
	enum SelectSettings {
		
		enum Title {
			static let speed = "Fish speed selection"
			static let size = "Fish size selection"
			static let fishCount = "Number of fish"
			static let fishType = "Image of fish"
		}
		
		enum Speed {
			static let slow = "Slow"
			static let normal = "Normal"
			static let fast = "Fast"
			static let veryFast = "Very fast"
		}
		
		enum Size {
			static let small = "Small"
			static let normal = "Normal"
			static let big = "Big"
			static let huge = "Huge"
		}
		
		enum FishCount {
			static let one = "1"
			static let two = "2"
			static let three = "3"
			static let four = "4"
			static let five = "5"
			static let six = "6"
			static let seven = "7"
			static let eight = "8"
			static let nine = "9"
		}
		
		enum FishType {
			static let mandarin = "Mandarin"
			static let green = "Green"
			static let red = "Red"
			static let yellow = "Yellow"
			static let random = "Random"
		}
		
	}
	
	enum Source {
		
		static let title: [String] = [
			Constants.SelectSettings.Title.speed,
			Constants.SelectSettings.Title.size,
			Constants.SelectSettings.Title.fishCount,
			Constants.SelectSettings.Title.fishType
		]
		
		static let speed: [String] = [
			Constants.SelectSettings.Speed.slow,
			Constants.SelectSettings.Speed.normal,
			Constants.SelectSettings.Speed.fast,
			Constants.SelectSettings.Speed.veryFast
		]
		
		static let size: [String] = [
			Constants.SelectSettings.Size.small,
			Constants.SelectSettings.Size.normal,
			Constants.SelectSettings.Size.big,
			Constants.SelectSettings.Size.huge
		]
		
		static let fishCount: [String] = [
			Constants.SelectSettings.FishCount.one,
			Constants.SelectSettings.FishCount.two,
			Constants.SelectSettings.FishCount.three,
			Constants.SelectSettings.FishCount.four,
			Constants.SelectSettings.FishCount.five,
			Constants.SelectSettings.FishCount.six,
			Constants.SelectSettings.FishCount.seven,
			Constants.SelectSettings.FishCount.eight,
			Constants.SelectSettings.FishCount.nine
		]
		
		static let fishType: [String] = [
			Constants.SelectSettings.FishType.mandarin,
			Constants.SelectSettings.FishType.green,
			Constants.SelectSettings.FishType.red,
			Constants.SelectSettings.FishType.yellow,
			Constants.SelectSettings.FishType.random
		]
		
	}

	enum Frame {
		
		enum Vertical {
			
			static func fish1(view: UIView) -> CGRect {
				CGRect( x: 48 / Constants.SizeCoefficient.coefficient,
						y: Constants.Indent.topMargin,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish2(view: UIView) -> CGRect {
				CGRect( x: view.frame.maxX - FishSize.width - 48 / Constants.SizeCoefficient.coefficient,
						y: Constants.Indent.topMargin,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish3(view: UIView) -> CGRect {
				CGRect(origin: CGPoint(
					x: view.center.x - Constants.FishSize.width / 2,
					y: view.center.y - Constants.FishSize.height / 2),
					   size: CGSize(
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
				)
			}
			
			static func fish4(view: UIView) -> CGRect {
				CGRect( x: 48 / Constants.SizeCoefficient.coefficient,
						y: view.frame.maxY - Constants.Indent.bottomMargin,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish5(view: UIView) -> CGRect {
				CGRect( x: view.frame.maxX - FishSize.width - 48 / Constants.SizeCoefficient.coefficient,
						y: view.frame.maxY - Constants.Indent.bottomMargin,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish6(view: UIView) -> CGRect {
				CGRect( x: 48 / Constants.SizeCoefficient.coefficient,
						y: view.center.y - view.frame.height / 4,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish7(view: UIView) -> CGRect {
				CGRect( x: 48 / Constants.SizeCoefficient.coefficient,
						y: view.center.y + view.frame.height / 4 - Constants.FishSize.height,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish8(view: UIView) -> CGRect {
				CGRect( x: view.frame.maxX - FishSize.width - 48 / Constants.SizeCoefficient.coefficient,
						y: view.center.y - view.frame.height / 4,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish9(view: UIView) -> CGRect {
				CGRect( x: view.frame.maxX - FishSize.width - 48 / Constants.SizeCoefficient.coefficient,
						y: view.center.y + view.frame.height / 4 - Constants.FishSize.height,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
		}
		
		enum Horizontal {
			
			static func fish1(view: UIView) -> CGRect {
				CGRect( x: 48 / Constants.SizeCoefficient.coefficient,
						y: Constants.Indent.topMargin,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish2(view: UIView) -> CGRect {
				CGRect( x: view.frame.maxX - FishSize.width - 48 / Constants.SizeCoefficient.coefficient,
						y: Constants.Indent.topMargin,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish3(view: UIView) -> CGRect {
				CGRect(origin: CGPoint(
					x: view.center.x - Constants.FishSize.width / 2,
					y: view.center.y - Constants.FishSize.height / 2),
					   size: CGSize(
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
				)
			}
			
			static func fish4(view: UIView) -> CGRect {
				CGRect( x: 48 / Constants.SizeCoefficient.coefficient,
						y: view.frame.maxY - Constants.Indent.bottomMargin,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish5(view: UIView) -> CGRect {
				CGRect( x: view.frame.maxX - FishSize.width - 48 / Constants.SizeCoefficient.coefficient,
						y: view.frame.maxY - Constants.Indent.bottomMargin,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish6(view: UIView) -> CGRect {
				CGRect( x: view.frame.width / 4.0,
						y: view.center.y - view.frame.height / 4,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish7(view: UIView) -> CGRect {
				CGRect( x: view.center.x + view.frame.width / 4 - Constants.FishSize.width,
						y: view.center.y + view.frame.height / 4 - Constants.FishSize.height,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish8(view: UIView) -> CGRect {
				CGRect( x: view.frame.width / 4.0,
						y: view.center.y + view.frame.height / 4 - Constants.FishSize.height,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
			static func fish9(view: UIView) -> CGRect {
				CGRect( x: view.center.x + view.frame.width / 4 - Constants.FishSize.width,
						y: view.center.y - view.frame.height / 4,
						width: Constants.FishSize.width,
						height: Constants.FishSize.height)
			}
			
		}
		
	}
	
	
}
