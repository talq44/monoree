import Foundation
import ProjectDescription

public enum MonoreeScheme: CaseIterable {
    case dev
    case prod
    
    public var name: String {
        switch self {
        case .dev: return "monoree_dev"
        case .prod: return "monoree_release"
        }
    }
    
    public var arguments: Arguments? {
        switch self {
        case .dev:
            return .arguments(launchArguments: [
                .launchArgument(name: "-FIRDebugEnabled", isEnabled: false),
                .launchArgument(name: "-FIRDebugDisabled", isEnabled: true),
            ])
            
        case .prod:
            return nil
        }
    }
    
    public var configurationName: ConfigurationName {
        switch self {
        case .dev: return .dev
        case .prod: return .prod
        }
    }
}

public extension Scheme {
    
    static func makeScheme(type: MonoreeScheme) -> Scheme {
        return .scheme(
            name: type.name,
            buildAction: .buildAction(targets: ["Monoree"]),
            testAction: .targets(["MonoreeTests"], configuration: .dev),
            runAction: .runAction(
                configuration: type.configurationName,
                arguments: type.arguments
            ),
            archiveAction: .archiveAction(configuration: type.configurationName),
            profileAction: .profileAction(configuration: type.configurationName),
            analyzeAction: .analyzeAction(configuration: type.configurationName)
        )
    }
}
