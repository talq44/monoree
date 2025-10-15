import Foundation
import RemoteConfigCoreInterface

internal struct FakeHomeConfigManager: HomeConfigManager {
    func home(
        _ type: RemoteConfigCoreInterface.HomeConfigType
    ) throws -> RemoteConfigCoreInterface.HomeDTO {
        let items: [HomeDTO.Item] = [
            .init(
                id: "1",
                title: "동물",
                subTitle: "모든 동물을 만나보세요.",
                backgroundColor: "#FFEEDD",
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/plush/tiger.webp",
                itemCategory: nil,
                itemCategory2: nil,
                columns: 1 // Int.random(in: 1...3)
            ),
            .init(
                id: "2",
                title: "육지",
                subTitle: "Loyal friend",
                backgroundColor: "#E0F7FA",
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/lion.webp",
                itemCategory: "animal",
                itemCategory2: "land",
                columns: 2 // Int.random(in: 1...3)
            ),
            .init(
                id: "3",
                title: "해상",
                subTitle: nil,
                backgroundColor: nil,
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/realistic/swan.webp",
                itemCategory: "animal",
                itemCategory2: "fish",
                columns: 2 // Int.random(in: 1...3)
            ),
            .init(
                id: "4",
                title: "곤충",
                subTitle: nil,
                backgroundColor: nil,
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/plush/eagle.webp",
                itemCategory: "animal",
                itemCategory2: "fish",
                columns: 2 // Int.random(in: 1...3)
            ),
            .init(
                id: "5",
                title: "양서류",
                subTitle: nil,
                backgroundColor: "#E0F7FA",
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/plush/eagle.webp",
                itemCategory: "animal",
                itemCategory2: "fish",
                columns: 2 // Int.random(in: 1...3)
            )
        ]
        return HomeDTO(isShowBanner: true, items: items)
    }

    func fetchHome(
        _ type: RemoteConfigCoreInterface.HomeConfigType
    ) async throws -> HomeDTO {
        return try home(type)
    }
}

extension HomeViewReactor {
    convenience init(useFakeRemoteConfig: Bool) {
        guard useFakeRemoteConfig else {
            self.init(remoteConfig: FakeHomeConfigManager())
            return
        }
        
        self.init(remoteConfig: FakeHomeConfigManager())
    }
}
