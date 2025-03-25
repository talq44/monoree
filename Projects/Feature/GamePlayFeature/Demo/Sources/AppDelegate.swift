import SwiftUI

import ComposableArchitecture

import GamePlayFeatureInterface
import GamePlayFeature

@main
struct DemoView: App {
    private let service: GamePlayService = GamePlayServiceImpl(
        gameTypes: [
            .singleText(text: "안녕하세요", answer: "안녕하세요"),
            .singleText(text: "반갑습니다", answer: "반갑습니다"),
            .singleText(text: "가가가OOO", answer: "가가가OOO"),
            .singleText(text: "그그그 XXX", answer: "그그그 그것은"),
            .singleText(text: "고생하셨습니다", answer: "고생하셨습니다"),
        ],
        timeInterval: 3.0,
        teamName: "A팀"
    )
    
    var body: some Scene {
        WindowGroup {
            service.view()
        }
    }
}
