import SwiftUI
import Kingfisher

public enum ThumbnailType: CaseIterable {
    case square_Large
    case circle_Large
    case square_Medium
    case circle_Medium
    case square_Small
    case circle_Small
    
    var size: CGFloat {
        switch self {
        case .square_Large, .circle_Large:
            return 120
        case .square_Medium, .circle_Medium:
            return 80
        case .square_Small, .circle_Small:
            return 48
        }
    }
    
    var isCircle: Bool {
        switch self {
        case .circle_Large, .circle_Medium, .circle_Small:
            return true
        default:
            return false
        }
    }
}

public struct ThumbnailView: View {
    let url: URL?
    let type: ThumbnailType
    
    public init(urlString: String?, type: ThumbnailType) {
        if let urlString, let url = URL(string: urlString) {
            self.url = url
        } else {
            self.url = nil
        }
        self.type = type
    }
    
    public var body: some View {
        KFImage.url(url)
            .placeholder {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: type.size * 0.5,
                           height: type.size * 0.5)
            }
            .resizable()
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .scaledToFill()
            .frame(width: type.size, height: type.size)
            .mask {
                if type.isCircle {
                    Circle()
                } else {
                    Rectangle()
                }
            }
            .clipped()
    }
}

#Preview {
    ThumbnailView(urlString: "https://github.githubassets.com/assets/GitHub-Mark-ea2971cee799.png", type: .circle_Large)
}
