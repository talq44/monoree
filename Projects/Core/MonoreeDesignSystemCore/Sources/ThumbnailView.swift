import SwiftUI
import Kingfisher

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
            .cacheMemoryOnly()
            .scaledToFill()
            .frame(width: type.size, height: type.size)
            .mask {
                if type.isCircle {
                    Circle()
                } else {
                    RoundedRectangle(cornerRadius: 16)
                }
            }
            .clipped()
    }
}

#Preview {
    ThumbnailView(urlString: "https://github.githubassets.com/assets/GitHub-Mark-ea2971cee799.png", type: .circleLarge)
}
