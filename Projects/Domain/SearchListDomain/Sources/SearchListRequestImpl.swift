import Foundation

import SearchListDomainInterface

struct SearchListRequestImpl: SearchListRequest {
    let query: String
    let page: Int
    let perPage: Int
    let token: String
}
