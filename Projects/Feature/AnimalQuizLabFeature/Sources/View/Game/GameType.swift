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
        case .image: return NSLocalizedString("image_quiz", comment: "")
        case .text: return NSLocalizedString("text_quiz", comment: "")
        case .categoryDifferent: return NSLocalizedString("category_quiz", comment: "")
        case .autoScroll: return NSLocalizedString("image_scroll", comment: "")
        }
    }
    
    var description: String {
        switch self {
        case .image: return NSLocalizedString("image_quiz_description", comment: "")
        case .text: return NSLocalizedString("text_quiz_description", comment: "")
        case .categoryDifferent: return NSLocalizedString("category_quiz_description", comment: "")
        case .autoScroll: return NSLocalizedString("image_scroll_description", comment: "")
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

