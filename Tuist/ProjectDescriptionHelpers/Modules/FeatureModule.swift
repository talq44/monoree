import ProjectDescription

public enum FeatureModule: String, CaseIterable {
	case AnimalQuizLabFeature
    
    public var name: String {
        self.rawValue
    }
}
