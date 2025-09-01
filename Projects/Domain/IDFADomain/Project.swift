import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.IDFADomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .IDFADomain,
            dependencies: []
        ),
        .implementation(
            domain: .IDFADomain,
            dependencies: [
                .domain(target: .IDFADomain, type: .interface),
            ]
        ),
        .testing(
            domain: .IDFADomain,
            dependencies: [
                .domain(target: .IDFADomain, type: .interface),
            ]
        ),
        .tests(
            domain: .IDFADomain,
            dependencies: [
                .domain(target: .IDFADomain, type: .implementation),
                .domain(target: .IDFADomain, type: .testing),
            ]
        ),
    ]
)
