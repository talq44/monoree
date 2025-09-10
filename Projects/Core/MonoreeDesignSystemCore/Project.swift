import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.MonoreeDesignSystemCore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .MonoreeDesignSystemCore,
            dependencies: []
        ),
        .implementation(
            core: .MonoreeDesignSystemCore,
            dependencies: [
                .shared(target: .UIThirdKit),
                .core(target: .MonoreeDesignSystemCore, type: .interface),
            ]
        ),
        .tests(
            core: .MonoreeDesignSystemCore,
            dependencies: [
                .core(target: .MonoreeDesignSystemCore, type: .implementation),
            ]
        ),
    ]
)
