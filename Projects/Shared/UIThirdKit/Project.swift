import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.UIThirdKit.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .UIThirdKit,
            dependencies: [
                .SPM.kingfisher.targetDependency,
                .SPM.snapKit.targetDependency,
            ]
        )
    ]
)
