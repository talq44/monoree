import Foundation

import ViewItemDomainInterface

final class ViewItemRepositoryImpl:ViewItemRepository {
    func send(_ input: any ViewItemInput) {
        print("send \(input)")
    }
}
