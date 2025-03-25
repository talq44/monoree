import ProjectDescription

public enum FeatureModule: String, CaseIterable {
    case BookmarkFeature
    case GamePlayFeature
    case SearchFeature
    case TimerFeature
    
    public var name: String {
        self.rawValue
    }
}
