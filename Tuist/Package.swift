// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    // Customize the product types for specific package product
    // Default is .staticFramework
    // productTypes: ["Alamofire": .framework,]
    productTypes: [:]
)
#endif

let package = Package(
    name: "Monoree",
    platforms: [
        .iOS(.v17)
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.10.1")
        ),
        .package(
            url: "https://github.com/Moya/Moya.git",
            .upToNextMajor(from: "15.0.3")
        ),
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk",
            .upToNextMajor(from: "11.11.0")
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            .upToNextMinor(from: "1.18.0")
        ),
        .package(
            url: "https://github.com/SwifterSwift/SwifterSwift",
            .upToNextMajor(from: "8.0.0")
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher",
            .upToNextMajor(from: "8.5.0")
        ),
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads",
            .upToNextMajor(from: "12.11.0")
        ),
    ]
)
