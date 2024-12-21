import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.BookmarkUpdateDomain.name,
    settings: .Module.default,
    targets: [
        .interface(
            domain: .BookmarkUpdateDomain,
            dependencies: []
        ),
        .implementation(
            domain: .BookmarkUpdateDomain,
            dependencies: [
                .SPM.swinject,
                .core(target: .LocalDataCore, type: .interface),
                .domain(target: .BookmarkUpdateDomain, type: .interface),
            ]
        ),
        .testing(
            domain: .BookmarkUpdateDomain,
            dependencies: [
                .SPM.fakery,
                .domain(target: .BookmarkUpdateDomain, type: .interface),
            ]
        ),
        .tests(
            domain: .BookmarkUpdateDomain,
            dependencies: [
                .domain(target: .BookmarkUpdateDomain, type: .implementation),
                .domain(target: .BookmarkUpdateDomain, type: .testing),
            ]
        ),
    ]
)
