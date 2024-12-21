import Foundation

import SearchListDomainInterface

struct SearchListItemImpl: SearchListItem {
    let id: Int
    let login: String
    let nodeId: String
    let avatarUrl: String
}
