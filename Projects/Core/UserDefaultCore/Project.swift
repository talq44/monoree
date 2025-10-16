import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.UserDefaultCore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .UserDefaultCore,
            dependencies: []
        ),
        .implementation(
            core: .UserDefaultCore,
            dependencies: [
                .core(target: .UserDefaultCore, type: .interface),
            ]
        ),
        .tests(
            core: .UserDefaultCore,
            dependencies: [
                .core(target: .UserDefaultCore, type: .implementation),
            ]
        ),
    ]
)
