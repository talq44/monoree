import SwiftUI

// MARK: - Model
struct HorizontalAppItem: HomeItemProtocol {
    let id: String
    var rank: Int?
    var title: String
    var subtitle: String
    var emojiIcon: String
}

// MARK: - View
struct HomeHorizontalStyleView: View {
    var title: String
    var subtitle: String
    var items: [HorizontalAppItem]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                NavigationLink {
                    SectionDetailView(title: title, items: items)
                } label: {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(.title3.bold())
                                .foregroundStyle(.primary)
                            Text(subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                }
                .buttonStyle(.plain)
                
                // Horizontal list (3개씩 세트로 페이징)
                let pages = items.chunked(by: 3)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 12) {
                        ForEach(Array(pages.enumerated()), id: \.offset) { _, page in
                            VStack(spacing: 12) {
                                ForEach(page) { item in
                                    NavigationLink {
                                        ItemDetailView(item: item)
                                    } label: {
                                        RowCard(item: item)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Row Card (AppStore 스타일 가로 카드)
private struct RowCard: View {
    let item: HorizontalAppItem
    
    var body: some View {
        HStack(spacing: 12) {
            if let rank = item.rank {
                Text("\(rank)")
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(uiColor: .secondarySystemBackground))
                Text(item.emojiIcon)
                    .font(.system(size: 28))
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "chevron.right")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.15), lineWidth: 1)
                )
        )
        .frame(width: UIScreen.main.bounds.width * 0.8)
    }
}

private struct ItemDetailView: View {
    let item: HorizontalAppItem
    var body: some View {
        VStack(spacing: 16) {
            Text(item.emojiIcon).font(.system(size: 64))
            Text(item.title).font(.largeTitle.bold())
            Text(item.subtitle).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    HomeHorizontalStyleView(
        title: "무료 게임 순위",
        subtitle: "가장 많이 다운로드된 게임",
        items: [
            .init(id: "1", rank: 1, title: "비지 세이비어", subtitle: "200뽑기 증정", emojiIcon: "🪓"),
            .init(id: "2",title: "명조:워더링 웨이브", subtitle: "액션의 잔상, 끝없는 모험", emojiIcon: "⚔️"),
            .init(id: "3",title: "플랜티스와 좀비깡패", subtitle: "롤플레잉", emojiIcon: "🧟"),
            .init(id: "5",title: "어비스: 데스티니", subtitle: "신규 클래스 등장!", emojiIcon: "🕳️"),
            .init(id: "4",title: "라그나로크 아이들", subtitle: "방치형 RPG", emojiIcon: "🐺")
        ]
    )
}
