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
                imageURL: nil,
                itemCategory: nil,
                itemCategory2: nil
            ),
            .init(
                id: "2",
                title: "육지",
                subTitle: "Loyal friend",
                backgroundColor: "#E0F7FA",
                imageURL: nil,
                itemCategory: "animal",
                itemCategory2: "land"
            ),
            .init(
                id: "3",
                title: "해상",
                subTitle: nil,
                backgroundColor: nil,
                imageURL: nil,
                itemCategory: "animal",
                itemCategory2: "fish"
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
