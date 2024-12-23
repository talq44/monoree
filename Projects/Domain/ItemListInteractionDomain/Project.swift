import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.ItemListInteractionDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .ItemListInteractionDomain,
            dependencies: []
        ),
        .implementation(
            domain: .ItemListInteractionDomain,
            dependencies: [
                .domain(target: .ItemListInteractionDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .ItemListInteractionDomain,
            dependencies: [
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
