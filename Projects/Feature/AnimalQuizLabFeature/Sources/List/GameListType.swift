import UIKit

enum GameListType: CaseIterable {
    case imageMatchAnswer2
    case textMatchAnswer2
    case imageMatchAnswer3
    case textMatchAnswer3
    case imageMatchAnswer4
    case textMatchAnswer4
    case autoScroll10
    case autoScroll30
    
    var count: Int {
        switch self {
        case .imageMatchAnswer2: return 2
        case .imageMatchAnswer3: return 3
        case .imageMatchAnswer4: return 4
        case .textMatchAnswer2: return 2
        case .textMatchAnswer3: return 3
        case .textMatchAnswer4: return 4
        case .autoScroll10: return 0
        case .autoScroll30: return 0
        }
    }
    
    var description: String {
        switch self {
        case .imageMatchAnswer2:
            return "이미지 보고 정답 맞추기 2x1"
        case .imageMatchAnswer3:
            return "이미지 보고 정답 맞추기 3x1"
        case .imageMatchAnswer4:
            return "이미지 보고 정답 맞추기 2x2"
        case .textMatchAnswer2:
            return "이름 보고 이미지로 맞추기 2x1"
        case .textMatchAnswer3:
            return "이름 보고 이미지로 맞추기 3x1"
        case .textMatchAnswer4:
            return "이름 보고 이미지로 맞추기 2x2"
        case .autoScroll10:
            return "자동으로 돌아가며 관찰하기"
        case .autoScroll30:
            return "자동으로 돌아가며 관찰하기"
        }
    }
    
    var leftImage: UIImage? {
        switch self {
        case .imageMatchAnswer2:
            return UIImage(systemName: "rectangle.grid.1x2.fill")
        case .textMatchAnswer2:
            return UIImage(systemName: "rectangle.grid.1x2")
        case .imageMatchAnswer3:
            return UIImage(systemName: "rectangle.grid.3x1.fill")
        case .textMatchAnswer3:
            return UIImage(systemName: "rectangle.grid.3x1")
        case .imageMatchAnswer4:
            return UIImage(systemName: "square.grid.2x2.fill")
        case .textMatchAnswer4:
            return UIImage(systemName: "square.grid.2x2")
        case .autoScroll10:
            return UIImage(systemName: "10.arrow.trianglehead.clockwise")
        case .autoScroll30:
            return UIImage(systemName: "30.arrow.trianglehead.clockwise")
        }
    }
    
    var isAutoScroll: Bool {
        self == .autoScroll10 || self == .autoScroll30
    }
    
    var gameType: GameTyp {
        switch self {
        case .imageMatchAnswer2:
            return .image
        case .textMatchAnswer2:
            return .text
        case .imageMatchAnswer3:
            return .image
        case .textMatchAnswer3:
            return .text
        case .imageMatchAnswer4:
            return .image
        case .textMatchAnswer4:
            return .text
        case .autoScroll10:
            return .autoScroll
        case .autoScroll30:
            return .autoScroll
        }
    }
}
