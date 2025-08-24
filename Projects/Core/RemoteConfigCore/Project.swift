import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.RemoteConfigCore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .RemoteConfigCore,
            dependencies: []
        ),
        .implementation(
            core: .RemoteConfigCore,
            dependencies: [
                .shared(target: .FirebaseSPMShared),
                .core(target: .RemoteConfigCore, type: .interface),
            ],
            resources: [
                .file(path: "Projects/Core/RemoteConfigCore/Sources/remote_config_defaults.plist")
            ]
        ),
        .testing(
            core: .RemoteConfigCore,
            dependencies: [
                .core(target: .RemoteConfigCore, type: .interface),
            ]
        ),
        .tests(
            core: .RemoteConfigCore,
            dependencies: [
                .core(target: .RemoteConfigCore, type: .implementation),
                .core(target: .RemoteConfigCore, type: .testing),
            ]
        ),
    ]
)
