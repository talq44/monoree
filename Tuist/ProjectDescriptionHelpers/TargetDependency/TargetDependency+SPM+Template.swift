//
//  TargetDependency+SPM+Template.swift
//  Manifests
//
//  Created by 박창규 on 11/20/24.
//

import ProjectDescription

extension TargetDependency {
    public enum SPM: CaseIterable {
        case alamofire
        case composableArchitecture
        case firebaseAnalytics
        case firebaseCore
        case firebaseRemoteConfig
        case firebaseCrashlytics
        case firebaseMessaging
        case firebasePerformance
        case googleMobileAds
        case kingfisher
        case moya
        case reactorKit
        case rxCocoa
        case rxSwift
        case snapKit
        case swifterSwift
        
        public var targetDependency: TargetDependency {
            switch self {
            case .alamofire:
                return .external(
                    name: "Alamofire"
                )
            case .composableArchitecture:
                return .external(
                    name: "ComposableArchitecture"
                )
            case .firebaseAnalytics:
                return .external(
                    name: "FirebaseAnalytics"
                )
            case .firebaseCore:
                return .external(
                    name: "FirebaseCore"
                )
            case .firebaseRemoteConfig:
                return .external(
                    name: "FirebaseRemoteConfig"
                )
            case .firebaseCrashlytics:
                return .external(
                    name: "FirebaseCrashlytics"
                )
            case .firebaseMessaging:
                return .external(
                    name: "FirebaseMessaging"
                )
            case .firebasePerformance:
                return .external(
                    name: "FirebasePerformance"
                )
            case .googleMobileAds:
                return .external(
                    name: "GoogleMobileAds"
                )
            case .kingfisher:
                return .external(
                    name: "Kingfisher"
                )
            case .moya:
                return .external(
                    name: "Moya"
                )
            case .reactorKit:
                return .external(
                    name: "ReactorKit"
                )
            case .rxCocoa:
                return .external(
                    name: "RxCocoa"
                )
            case .rxSwift:
                return .external(
                    name: "RxSwift"
                )
            case .snapKit:
                return .external(
                    name: "SnapKit"
                )
            case .swifterSwift:
                return .external(
                    name: "SwifterSwift"
                )
            }
        }
    }
}
