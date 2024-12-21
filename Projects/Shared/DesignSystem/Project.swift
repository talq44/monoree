import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.DesignSystem.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .DesignSystem,
            dependencies: [
                .SPM.kingfisher,
                .shared(target: .FoundationShared)
            ]
        ),
        .tests(
            shared: .DesignSystem,
            dependencies: [
                .shared(target: .DesignSystem, type: .implementation),
            ]
        ),
        .preview(
            shared: .DesignSystem,
            dependencies: [
                .shared(target: .DesignSystem, type: .implementation),
            ]
        )
    ]
)
