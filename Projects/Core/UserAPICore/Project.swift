import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.UserAPICore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .UserAPICore,
            dependencies: []
        ),
        .implementation(
            core: .UserAPICore,
            dependencies: [
                .shared(target: .NetworkThridKit),
                .shared(target: .FoundationShared),
                .core(target: .UserAPICore, type: .interface),
            ]
        ),
    ]
)
