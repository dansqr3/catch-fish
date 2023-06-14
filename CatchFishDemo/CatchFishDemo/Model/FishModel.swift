
import Foundation

struct FishModel {
	var imageString: String?
	var direction: Direction?
	var tag: Tag?
	var type: FishType?
}

enum FishType {
	case mandarin
	case green
	case red
	case yellow
}

enum Direction {
	case left
	case right
}

enum Tag {
	case one
	case two
	case three
	case four
	case five
	case six
	case seven
	case eight
	case nine
}
