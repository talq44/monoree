import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.StatusCodeCore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .StatusCodeCore,
            dependencies: []
        ),
        .implementation(
            core: .StatusCodeCore,
            dependencies: [
                .core(target: .StatusCodeCore, type: .interface),
            ]
        ),
        .testing(
            core: .StatusCodeCore,
            dependencies: [
                .core(target: .StatusCodeCore, type: .interface),
            ]
        ),
        .tests(
            core: .StatusCodeCore,
            dependencies: [
                .core(target: .StatusCodeCore, type: .implementation),
                .core(target: .StatusCodeCore, type: .testing),
            ]
        ),
    ]
)
