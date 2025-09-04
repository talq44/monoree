import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.UserGameSettingDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .UserGameSettingDomain,
            dependencies: [
            ]
        ),
        .implementation(
            domain: .UserGameSettingDomain,
            dependencies: [
                // Core
                .core(target: .LocalDataCore, type: .interface),
                .core(target: .RemoteConfigCore, type: .interface),
                .domain(target: .UserGameSettingDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .UserGameSettingDomain,
            dependencies: [
                // Core
                .core(target: .LocalDataCore, type: .interface),
                .core(target: .RemoteConfigCore, type: .interface),
                .domain(target: .UserGameSettingDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .UserGameSettingDomain,
            dependencies: [
                .domain(target: .UserGameSettingDomain, type: .implementation),
                .domain(target: .UserGameSettingDomain, type: .testing),
            ]
        ),
    ]
)
