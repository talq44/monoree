import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.SearchListDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .SearchListDomain,
            dependencies: []
        ),
        .implementation(
            domain: .SearchListDomain,
            dependencies: [
                .SPM.swinject,
                .core(target: .UserAPICore, type: .interface),
                .core(target: .AuthCore, type: .interface),
                .domain(target: .SearchListDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .SearchListDomain,
            dependencies: [
                .SPM.fakery,
                .domain(target: .SearchListDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .SearchListDomain,
            dependencies: [
                .domain(target: .SearchListDomain, type: .implementation),
                .domain(target: .SearchListDomain, type: .testing),
            ]
        ),
    ]
)
