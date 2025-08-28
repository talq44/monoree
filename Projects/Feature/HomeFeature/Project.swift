import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: FeatureModule.HomeFeature.name,
    settings: .Module.default,
    targets: [
		.interface(
			feature: .HomeFeature,
			dependencies: []
		),
		.implementation(
			feature: .HomeFeature,
			dependencies: [
				.feature(target: .HomeFeature, type: .interface),
			]
		),
		.testing(
			feature: .HomeFeature,
			dependencies: [
				.feature(target: .HomeFeature, type: .interface),
			]
		),
		.tests(
			feature: .HomeFeature,
			dependencies: [
				.feature(target: .HomeFeature, type: .implementation),
				.feature(target: .HomeFeature, type: .testing),
			]
		),
		.demo(
			feature: .HomeFeature,
			dependencies: [
				.feature(target: .HomeFeature, type: .implementation),
				.feature(target: .HomeFeature, type: .testing),
			]
		),
]
)