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
                .core(target: .LocalDataCore, type: .interface),
                .SPM.realm,
                .SPM.realmSwift,
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
                .core(target: .LocalDataCore, type: .interface),
                .core(target: .LocalDataCore, type: .implementation),
                .core(target: .LocalDataCore, type: .testing),
                .SPM.realm,
                .SPM.realmSwift,
            ]
        ),
    ]
)
