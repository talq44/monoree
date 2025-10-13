import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.UIKitExtensionShared.name,
    settings: .Module.default,
    targets: [
		.interface(
			shared: .UIKitExtensionShared,
			dependencies: []
		),
		.implementation(
			shared: .UIKitExtensionShared,
			dependencies: [
				.shared(target: .UIKitExtensionShared, type: .interface),
			]
		),
		.testing(
			shared: .UIKitExtensionShared,
			dependencies: [
				.shared(target: .UIKitExtensionShared, type: .interface),
			]
		),
		.tests(
			shared: .UIKitExtensionShared,
			dependencies: [
				.shared(target: .UIKitExtensionShared, type: .implementation),
				.shared(target: .UIKitExtensionShared, type: .testing),
			]
		),
	]
)
