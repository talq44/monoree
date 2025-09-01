import SwiftUI

// MARK: - Detail Placeholders
struct SectionDetailView: View {
    let title: String
    let items: [HorizontalAppItem]
    var body: some View {
        List(items) { item in
            HStack(spacing: 12) {
                Text(item.emojiIcon).frame(width: 30)
                VStack(alignment: .leading) {
                    Text(item.title)
                    Text(item.subtitle).font(.caption).foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle(title)
    }
}

#Preview {
    SectionDetailView(
        title: "디테일",
        items: [
            .init(id: "1", title: "비지 세이비어", subtitle: "200뽑기 증정", emojiIcon: "🪓"),
            .init(id: "2",title: "명조:워더링 웨이브", subtitle: "액션의 잔상, 끝없는 모험", emojiIcon: "⚔️"),
            .init(id: "3",title: "플랜티스와 좀비깡패", subtitle: "롤플레잉", emojiIcon: "🧟"),
            .init(id: "5",title: "어비스: 데스티니", subtitle: "신규 클래스 등장!", emojiIcon: "🕳️"),
            .init(id: "4",title: "라그나로크 아이들", subtitle: "방치형 RPG", emojiIcon: "🐺")
        ]
    )
}
