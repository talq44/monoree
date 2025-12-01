import Foundation
import RemoteConfigCoreInterface

internal struct FakeHomeConfigManager: HomeConfigManager {
    func home(
        _ type: RemoteConfigCoreInterface.HomeConfigType
    ) throws -> RemoteConfigCoreInterface.HomeDTO {
        let items: [HomeDTO.Item] = [
            .init(
                id: "1",
                title: NSLocalizedString("animal_title", comment: ""),
                subTitle: NSLocalizedString("animal_subtitle", comment: ""),
                backgroundColor: "#FFEEDD",
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/plush/tiger.webp",
                itemCategory: nil,
                itemCategory2: nil,
                columns: 1 // Int.random(in: 1...3)
            ),
            .init(
                id: "2",
                title: NSLocalizedString("land_title", comment: ""),
                subTitle: "Loyal friend",
                backgroundColor: "#E0F7FA",
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/lion.webp",
                itemCategory: "animal",
                itemCategory2: "land",
                columns: 3 // Int.random(in: 1...3)
            ),
            .init(
                id: "6",
                title: NSLocalizedString("bird_title", comment: ""),
                subTitle: NSLocalizedString("bird_subtitle", comment: ""),
                backgroundColor: "#E007F6",
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/sparrow.webp",
                itemCategory: "animal",
                itemCategory2: "land",
                columns: 3 // Int.random(in: 1...3)
            ),
            .init(
                id: "3",
                title: NSLocalizedString("sea_title", comment: ""),
                subTitle: nil,
                backgroundColor: nil,
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/realistic/swan.webp",
                itemCategory: "animal",
                itemCategory2: "fish",
                columns: 3 // Int.random(in: 1...3)
            ),
            .init(
                id: "4",
                title: NSLocalizedString("insect_title", comment: ""),
                subTitle: nil,
                backgroundColor: nil,
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/plush/eagle.webp",
                itemCategory: "animal",
                itemCategory2: "fish",
                columns: 2 // Int.random(in: 1...3)
            ),
            .init(
                id: "5",
                title: NSLocalizedString("amphibian_title", comment: ""),
                subTitle: nil,
                backgroundColor: "#E0F7FA",
                imageURL: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/frog.webp",
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
