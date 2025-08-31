import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.LocalDataCore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .LocalDataCore,
            dependencies: []
        ),
        .implementation(
            core: .LocalDataCore,
            dependencies: [
                .shared(target: .ExtensionsShared),
                .core(target: .LocalDataCore, type: .interface),
            ]
        ),
        .testing(
            core: .LocalDataCore,
            dependencies: [
                .core(target: .LocalDataCore, type: .interface),
            ]
        ),
        .tests(
            core: .LocalDataCore,
            dependencies: [
                .core(target: .LocalDataCore, type: .implementation),
                .core(target: .LocalDataCore, type: .testing),
            ]
        ),
    ]
)
