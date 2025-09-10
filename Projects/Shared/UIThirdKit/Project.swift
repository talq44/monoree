import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.UIThirdKit.name,
    settings: .Module.default,
    targets: [
		.interface(
			shared: .UIThirdKit,
			dependencies: []
		),
		.implementation(
			shared: .UIThirdKit,
			dependencies: [
				.shared(target: .UIThirdKit, type: .interface),
			]
		),
		.testing(
			shared: .UIThirdKit,
			dependencies: [
				.shared(target: .UIThirdKit, type: .interface),
			]
		),
		.tests(
			shared: .UIThirdKit,
			dependencies: [
				.shared(target: .UIThirdKit, type: .implementation),
				.shared(target: .UIThirdKit, type: .testing),
			]
		),
	]
)