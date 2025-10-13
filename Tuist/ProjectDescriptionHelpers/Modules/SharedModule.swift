import ProjectDescription

public enum SharedModule: String, CaseIterable {
	case UIKitExtensionShared
	case ExtensionsShared
    case FirebaseSPMShared
	case FoundationShared
    case NetworkThirdKit
    case RxThirdKit
    case UIThirdKit
    
    public var name: String {
        self.rawValue
    }
}
