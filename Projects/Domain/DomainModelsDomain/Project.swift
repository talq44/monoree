import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.DomainModelsDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .DomainModelsDomain,
            dependencies: []
        ),
        .implementation(
            domain: .DomainModelsDomain,
            dependencies: [
                .domain(target: .DomainModelsDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .DomainModelsDomain,
            dependencies: [
                .domain(target: .DomainModelsDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .DomainModelsDomain,
            dependencies: [
                .domain(target: .DomainModelsDomain, type: .implementation),
                .domain(target: .DomainModelsDomain, type: .testing),
            ]
        ),
    ]
)
