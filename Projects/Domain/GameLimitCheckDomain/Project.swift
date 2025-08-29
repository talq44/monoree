import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.GameLimitCheckDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .GameLimitCheckDomain,
            dependencies: [
                .core(target: .RemoteConfigCore, type: .interface),
            ]
        ),
        .implementation(
            domain: .GameLimitCheckDomain,
            dependencies: [
                .domain(target: .GameLimitCheckDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .GameLimitCheckDomain,
            dependencies: [
                .domain(target: .GameLimitCheckDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .GameLimitCheckDomain,
            dependencies: [
                .domain(target: .GameLimitCheckDomain, type: .implementation),
                .domain(target: .GameLimitCheckDomain, type: .testing),
            ]
        ),
    ]
)
