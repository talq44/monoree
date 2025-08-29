import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.GameCompletionDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .GameCompletionDomain,
            dependencies: [
                .core(target: .RemoteConfigCore, type: .interface),
            ]
        ),
        .implementation(
            domain: .GameCompletionDomain,
            dependencies: [
                .domain(target: .GameCompletionDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .GameCompletionDomain,
            dependencies: [
                .domain(target: .GameCompletionDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .GameCompletionDomain,
            dependencies: [
                .domain(target: .GameCompletionDomain, type: .implementation),
                .domain(target: .GameCompletionDomain, type: .testing),
            ]
        ),
    ]
)
