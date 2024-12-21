import Foundation

import SearchListDomainInterface

struct SearchListInputImpl: SearchListInput {
    let query: String
    let isMore: Bool
    
    init(query: String, isMore: Bool = false) {
        self.query = query
        self.isMore = isMore
    }
}
