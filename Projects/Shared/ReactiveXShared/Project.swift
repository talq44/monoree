import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.ReactiveXShared.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .ReactiveXShared,
            dependencies: [
                .SPM.rxSwift,
                .SPM.rxCocoa,
                .SPM.reactorKit,
            ]
        )
    ]
)
