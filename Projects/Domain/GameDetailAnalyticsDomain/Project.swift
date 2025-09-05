import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.GameDetailAnalyticsDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .GameDetailAnalyticsDomain,
            dependencies: []
        ),
        .implementation(
            domain: .GameDetailAnalyticsDomain,
            dependencies: [
                .domain(target: .GameDetailAnalyticsDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .GameDetailAnalyticsDomain,
            dependencies: [
                .domain(target: .GameDetailAnalyticsDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .GameDetailAnalyticsDomain,
            dependencies: [
                .domain(target: .GameDetailAnalyticsDomain, type: .implementation),
                .domain(target: .GameDetailAnalyticsDomain, type: .testing),
            ]
        ),
    ]
)
