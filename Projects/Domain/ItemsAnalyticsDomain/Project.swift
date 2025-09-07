import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.ItemsAnalyticsDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .ItemsAnalyticsDomain,
            dependencies: []
        ),
        .implementation(
            domain: .ItemsAnalyticsDomain,
            dependencies: [
                .core(target: .AnalyticsCore, type: .interface),
                .domain(target: .ItemsAnalyticsDomain, type: .interface),
            ]
        )
    ]
)
