import SwiftUI
import HomeFeature

struct HomeContentView: View {
    private let sampleCategories: [GameCategory] = [
        .init(title: "커플 게임", subtitle: "둘이 동시에 골라보자", accentEmoji: "💑", tint: .pink),
        .init(title: "초성 맞추기", subtitle: "사자성어 · 속담 · 일상어", accentEmoji: "🔤", tint: .blue),
        .init(title: "이미지 퀴즈", subtitle: "사진 보고 정답을 맞혀요", accentEmoji: "🖼️", tint: .green),
        .init(title: "술 게임", subtitle: "분위기 살리는 미니게임", accentEmoji: "🍻", tint: .orange),
        .init(title: "민속놀이", subtitle: "투호 · 윷놀이(준비중)", accentEmoji: "🎎", tint: .purple)
    ]
    
    var body: some View {
        HomeFeature.HomeView(categories: sampleCategories)
    }
}

#Preview {
    HomeContentView()
}
