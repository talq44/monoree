import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.BookmarkListDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .BookmarkListDomain,
            dependencies: []
        ),
        .implementation(
            domain: .BookmarkListDomain,
            dependencies: [
                .SPM.swinject,
                .core(target: .LocalDataCore, type: .interface),
                .domain(target: .BookmarkListDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .BookmarkListDomain,
            dependencies: [
                .SPM.fakery,
                .domain(target: .BookmarkListDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .BookmarkListDomain,
            dependencies: [
                .domain(target: .BookmarkListDomain, type: .implementation),
                .domain(target: .BookmarkListDomain, type: .testing),
            ]
        ),
    ]
)
