import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.AuthCore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .AuthCore,
            dependencies: []
        ),
        .implementation(
            core: .AuthCore,
            dependencies: [
                .core(target: .AuthCore, type: .interface),
            ]
        ),
        .testing(
            core: .AuthCore,
            dependencies: [
                .core(target: .AuthCore, type: .interface),
            ]
        ),
        .tests(
            core: .AuthCore,
            dependencies: [
                .core(target: .AuthCore, type: .implementation),
                .core(target: .AuthCore, type: .testing),
            ]
        ),
    ]
)
