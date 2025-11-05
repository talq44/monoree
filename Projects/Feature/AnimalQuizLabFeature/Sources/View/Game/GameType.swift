import Foundation

enum GameType: CaseIterable {
    case image
    case text
    case categoryDifferent
    case autoScroll
    
    var isShowSpeakButton: Bool {
        switch self {
        case .image: return false
        case .text: return true
        case .categoryDifferent: return false
        case .autoScroll: return true
        }
    }
    
    var title: String {
        switch self {
        case .image: return "이미지 보고 맞추기"
        case .text: return "글자 보고 맞추기"
        case .categoryDifferent: return "다른 카테고리 맞추기"
        case .autoScroll: return "이미지 보기"
        }
    }
    
    var description: String {
        switch self {
        case .image: return "그림을 보고 아래에 있는 정답 글자 중 하나를 골라보세요."
        case .text: return "이름을 보고 아래에 있는 그림 중 하나를 골라보세요."
        case .categoryDifferent: return "그림과 다른 카테고리를 그림 중 골라보세요."
        case .autoScroll: return "그림이 연속적으로 나타납니다.\n(설정에서 자동 넘김 설정이 가능합니다.)"
        }
    }
    
    var imageName: String {
        switch self {
        case .image: return "photo.badge.checkmark"
        case .text: return "richtext.page"
        case .categoryDifferent: return "circle.grid.2x2.topleft.checkmark.filled"
        case .autoScroll: return "photo.on.rectangle.angled"
        }
    }

    struct QuizItem {
        let imageSystemName: String
        let count: Int
        let title: String
    }
    
    var quizItems: [QuizItem] {
        switch self {
        case .image:
            return [
                QuizItem(
                    imageSystemName: "rectangle.grid.1x2",
                    count: 2,
                    title: "2"
                ),
                QuizItem(
                    imageSystemName: "rectangle.grid.1x3",
                    count: 3,
                    title: "3"
                ),
                QuizItem(
                    imageSystemName: "rectangle.grid.2x2",
                    count: 4,
                    title: "4"
                )
            ]
        case .text:
            return [
                QuizItem(
                    imageSystemName: "rectangle.grid.1x2.fill",
                    count: 2,
                    title: "2"
                ),
                QuizItem(
                    imageSystemName: "rectangle.grid.1x3.fill",
                    count: 3,
                    title: "3"
                ),
                QuizItem(
                    imageSystemName: "rectangle.grid.2x2.fill",
                    count: 4,
                    title: "4"
                )
            ]
        case .categoryDifferent:
            return [
                QuizItem(
                    imageSystemName: "rectangle.split.1x2.fill",
                    count: 2,
                    title: "2"
                ),
                QuizItem(
                    imageSystemName: "rectangle.grid.1x3.fill",
                    count: 3,
                    title: "3"
                ),
                QuizItem(
                    imageSystemName: "rectangle.split.2x2.fill",
                    count: 4,
                    title: "4"
                )
            ]
        case .autoScroll:
            return [
                QuizItem(
                    imageSystemName: "10.arrow.trianglehead.clockwise",
                    count: 10,
                    title: "10"
                ),
                QuizItem(
                    imageSystemName: "30.arrow.trianglehead.clockwise",
                    count: 30,
                    title: "30"
                )
            ]
        }
    }
}

