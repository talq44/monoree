import ProjectDescription

public enum FeatureModule: String, CaseIterable {
    case GamePlayFeature
    case TimerFeature
    
    public var name: String {
        self.rawValue
    }
}
