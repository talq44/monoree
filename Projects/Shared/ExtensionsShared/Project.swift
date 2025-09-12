import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.ExtensionsShared.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .ExtensionsShared,
            dependencies: [
                .SPM.swifterSwift.targetDependency,
            ]
        )
    ]
)
