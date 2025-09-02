import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.WishlistDomain.name,
    settings: .Module.default,
    targets: [
		.interface(
			domain: .WishlistDomain,
			dependencies: []
		),
		.implementation(
			domain: .WishlistDomain,
			dependencies: [
				.domain(target: .WishlistDomain, type: .interface),
			]
		),
		.testing(
			domain: .WishlistDomain,
			dependencies: [
				.domain(target: .WishlistDomain, type: .interface),
			]
		),
		.tests(
			domain: .WishlistDomain,
			dependencies: [
				.domain(target: .WishlistDomain, type: .implementation),
				.domain(target: .WishlistDomain, type: .testing),
			]
		),
	]
)