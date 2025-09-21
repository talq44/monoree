import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.AdMobCore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .AdMobCore,
            dependencies: []
        ),
        .implementation(
            core: .AdMobCore,
            dependencies: [
                .core(target: .AdMobCore, type: .interface),
            ]
        ),
        .demo(
            core: .AdMobCore,
            dependencies: [
                .core(target: .AdMobCore, type: .implementation)
            ]
        )
    ]
)
