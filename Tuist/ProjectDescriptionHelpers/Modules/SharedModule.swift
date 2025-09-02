import ProjectDescription

public enum SharedModule: String, CaseIterable {
	case ExtensionsShared
    case FirebaseSPMShared
	case FoundationShared
    case NetworkThirdKit
    
    public var name: String {
        self.rawValue
    }
}
