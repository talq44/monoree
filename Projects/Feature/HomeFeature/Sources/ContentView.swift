import SwiftUI

// MARK: - Model
struct GameCategory: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var subtitle: String
    var accentEmoji: String
    var tint: Color
    var imageURL: URL? = nil // For future remote artwork
}

private let sampleCategories: [GameCategory] = [
    .init(title: "커플 게임", subtitle: "둘이 동시에 골라보자", accentEmoji: "💑", tint: .pink),
    .init(title: "초성 맞추기", subtitle: "사자성어 · 속담 · 일상어", accentEmoji: "🔤", tint: .blue),
    .init(title: "이미지 퀴즈", subtitle: "사진 보고 정답을 맞혀요", accentEmoji: "🖼️", tint: .green),
    .init(title: "술 게임", subtitle: "분위기 살리는 미니게임", accentEmoji: "🍻", tint: .orange),
    .init(title: "민속놀이", subtitle: "투호 · 윷놀이(준비중)", accentEmoji: "🎎", tint: .purple)
]

// MARK: - Views
public struct ContentView: View {
    var categories: [GameCategory] = sampleCategories
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HeroCard()
                    
                    HomeHorizontalStyleView(
                        title: "초성 맞추기",
                        subtitle: "다양한 초성 맞추기 게임!",
                        items: [
                            .init(id: "1", title: "속담 초성 맞추기!", subtitle: "ㄱㄴ ㅁㅇ ㄱㅇㅇ ㅇㄴ ㅁㅇ ㄱㄷ", emojiIcon: "🪓"),
                            .init(id: "2",title: "공룡 초성 맞추기!", subtitle: "ㅁㅅㅅㅇㄹㅅ", emojiIcon: "⚔️"),
                            .init(id: "3",title: "사자성어 초성 맞추기!", subtitle: "ㄱㅈㄱㄹ", emojiIcon: "🧟"),
                            .init(id: "4",title: "영화 초성 맞추기!", subtitle: "ㄱㅈㄱㄹ", emojiIcon: "🧟"),
                            .init(id: "5",title: "세계 명소 초성 맞추기!", subtitle: "ㄱㅈㄱㄹ", emojiIcon: "🧟")
                        ]
                    )
                    
                    Text("오늘의 놀이")
                        .font(.title2.bold())
                        .padding(.horizontal)
                    
                    VStack(spacing: 14) {
                        ForEach(categories) { item in
                            NavigationLink(value: item) {
                                CategoryCard(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }
                .padding(.top, 16)
            }
            .navigationTitle("모놀이")
            .navigationDestination(for: GameCategory.self) { item in
                VStack(spacing: 16) {
                    Text(item.accentEmoji)
                        .font(.system(size: 72))
                    Text(item.title)
                        .font(.largeTitle.bold())
                    Text(item.subtitle)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(colors: [item.tint.opacity(0.15), .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                .navigationTitle(item.title)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

// MARK: - Hero
private struct HeroCard: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: [Color.green.opacity(0.9), Color.green.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    // Decorative rings (fake "App Store" feel)
                    Circle().strokeBorder(Color.white.opacity(0.25), lineWidth: 18)
                        .scaleEffect(1.2)
                        .offset(x: 120, y: -60)
                        .blur(radius: 0.5)
                )
                .overlay(
                    Circle().strokeBorder(Color.white.opacity(0.15), lineWidth: 10)
                        .offset(x: -90, y: -40)
                        .blur(radius: 0.5)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text("지금 바로 즐겨요")
                    .font(.callout.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.9))
                
                Text("모두의 놀이, 모놀이")
                    .font(.system(size: 34, weight: .heavy))
                    .foregroundStyle(.white)
                    .shadow(radius: 10, y: 2)
                
                Text("가볍지만 재밌고 즐거운 게임")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(24)
        }
        .frame(height: 160)
        .padding(.horizontal)
    }
}

// MARK: - Category Card
private struct CategoryCard: View {
    let item: GameCategory
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 18)
                .fill(item.tint.gradient.opacity(0.22))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .strokeBorder(item.tint.opacity(0.35), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
            
            HStack(alignment: .center, spacing: 14) {
                Text(item.accentEmoji)
                    .font(.system(size: 34))
                    .frame(width: 56, height: 56)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 88)
    }
}

#Preview {
    ContentView()
}
