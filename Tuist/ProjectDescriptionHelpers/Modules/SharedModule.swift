import ProjectDescription

public enum SharedModule: String, CaseIterable {
	case ExtensionsShared
    case FirebaseSPMShared
	case FoundationShared
    case NetworkThirdKit
    case UIThirdKit
    
    public var name: String {
        self.rawValue
    }
}
