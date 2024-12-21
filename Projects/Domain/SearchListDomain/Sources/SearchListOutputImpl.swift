import Foundation

import SearchListDomainInterface

struct SearchListOutputImpl: SearchListOutput {
    let items: [any SearchListDomainInterface.SearchListItem]   
}
