import ProjectDescription

public enum DomainModule: String, CaseIterable {
    case BookmarkListDomain
    case BookmarkUpdateDomain
    case DomainModelsDomain
    case ItemListInteractionDomain
    case KoreanChosungDomain
    case SearchListDomain
    case VersionCheckDomain
    case ViewItemDomain
    
    public var name: String {
        self.rawValue
    }
}
