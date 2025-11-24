import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.GameEntityDomain.name,
    settings: .Module.default,
    targets: [
		.interface(
			domain: .GameEntityDomain,
			dependencies: []
		),
		.implementation(
			domain: .GameEntityDomain,
			dependencies: [
				.domain(target: .GameEntityDomain, type: .interface),
			]
		),
		.testing(
			domain: .GameEntityDomain,
			dependencies: [
				.domain(target: .GameEntityDomain, type: .interface),
			]
		),
		.tests(
			domain: .GameEntityDomain,
			dependencies: [
				.domain(target: .GameEntityDomain, type: .implementation),
				.domain(target: .GameEntityDomain, type: .testing),
			]
		),
	]
)