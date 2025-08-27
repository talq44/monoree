import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.VersionCheckDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .VersionCheckDomain,
            dependencies: [
                .core(target: .RemoteConfigCore, type: .interface),
            ]
        ),
        .implementation(
            domain: .VersionCheckDomain,
            dependencies: [
                .domain(target: .VersionCheckDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .VersionCheckDomain,
            dependencies: [
                .domain(target: .VersionCheckDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .VersionCheckDomain,
            dependencies: [
                .domain(target: .VersionCheckDomain, type: .implementation),
                .domain(target: .VersionCheckDomain, type: .testing),
            ]
        ),
    ]
)
