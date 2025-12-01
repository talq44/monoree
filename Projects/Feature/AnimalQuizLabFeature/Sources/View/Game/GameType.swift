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
        case .image: return AnimalQuizLabFeatureStrings.imageQuiz
        case .text: return AnimalQuizLabFeatureStrings.textQuiz
        case .categoryDifferent: return AnimalQuizLabFeatureStrings.categoryQuiz
        case .autoScroll: return AnimalQuizLabFeatureStrings.imageScroll
        }
    }
    
    var description: String {
        switch self {
        case .image: return AnimalQuizLabFeatureStrings.imageQuizDescription
        case .text: return AnimalQuizLabFeatureStrings.textQuizDescription
        case .categoryDifferent: return AnimalQuizLabFeatureStrings.categoryQuizDescription
        case .autoScroll: return AnimalQuizLabFeatureStrings.imageScrollDescription
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

