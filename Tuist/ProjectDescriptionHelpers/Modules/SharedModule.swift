import ProjectDescription

public enum SharedModule: String, CaseIterable {
	case ExtensionsShared
    case FirebaseSPMShared
	case FoundationShared
    
    public var name: String {
        self.rawValue
    }
}
