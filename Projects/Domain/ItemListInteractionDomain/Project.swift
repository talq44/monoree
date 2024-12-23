import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.ItemListInteractionDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .ItemListInteractionDomain,
            dependencies: [
                .domain(target: .DomainModelsDomain, type: .interface),
            ]
        ),
        .implementation(
            domain: .ItemListInteractionDomain,
            dependencies: [
                .domain(target: .DomainModelsDomain, type: .interface),
                .domain(target: .ItemListInteractionDomain, type: .interface),
                .core(target: .AnalyticsCore, type: .interface),
            ]
        ),
        .testing(
            domain: .ItemListInteractionDomain,
            dependencies: [
                .domain(target: .DomainModelsDomain, type: .interface),
                .domain(target: .ItemListInteractionDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .ItemListInteractionDomain,
            dependencies: [
                .domain(target: .ItemListInteractionDomain, type: .implementation),
                .domain(target: .ItemListInteractionDomain, type: .testing),
            ]
        ),
    ]
)
