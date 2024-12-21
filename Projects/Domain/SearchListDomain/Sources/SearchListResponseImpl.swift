import Foundation

import SearchListDomainInterface

struct SearchListResponseImpl: SearchListResponse {
    let totalCount: Int
    let items: [any SearchListDomainInterface.SearchListItem]
}
