import Foundation

enum GameType: CaseIterable {
    case image
    case text
    case autoScroll
    
    var isShowSpeakButton: Bool {
        switch self {
        case .image:
            return false
        case .text:
            return true
        case .autoScroll:
            return true
        }
    }
    
    var title: String {
        switch self {
        case .image: return "이미지 보고 맞추기"
        case .text: return "글자 보고 맞추기"
        case .autoScroll: return "이미지 보기"
        }
    }
    
    var description: String {
        switch self {
        case .image: return "그림을 보고 아래에 있는 정답 글자 중 하나를 골라주세요."
        case .text: return "이름을 보고 아래에 있는 그림 중 하나를 골라주세요."
        case .autoScroll: return "그림이 연속적으로 나타납니다.\n(설정에서 자동 넘김 설정이 가능합니다.)"
        }
    }
}
