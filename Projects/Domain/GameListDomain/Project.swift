import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.GameListDomain.name,
    settings: .Module.default,
    targets: [
		.interface(
			domain: .GameListDomain,
			dependencies: []
		),
		.implementation(
			domain: .GameListDomain,
			dependencies: [
				.domain(target: .GameListDomain, type: .interface),
			]
		),
		.testing(
			domain: .GameListDomain,
			dependencies: [
				.domain(target: .GameListDomain, type: .interface),
			]
		),
		.tests(
			domain: .GameListDomain,
			dependencies: [
				.domain(target: .GameListDomain, type: .implementation),
				.domain(target: .GameListDomain, type: .testing),
			]
		),
	]
)