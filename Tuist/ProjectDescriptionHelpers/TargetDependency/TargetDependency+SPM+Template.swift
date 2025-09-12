//
//  TargetDependency+SPM+Template.swift
//  Manifests
//
//  Created by 박창규 on 11/20/24.
//

import ProjectDescription

extension TargetDependency {
    public enum SPM: CaseIterable {
        case composableArchitecture
        case alamofire
        case moya
        case kingfisher
        case firebaseAnalytics
        case firebaseCore
        case firebaseRemoteConfig
        case firebaseCrashlytics
        case firebaseMessaging
        case firebasePerformance
        case swifterSwift
        
        public var targetDependency: TargetDependency {
            switch self {
            case .composableArchitecture:
                return .external(
                    name: "ComposableArchitecture"
                )
            case .alamofire:
                return .external(
                    name: "Alamofire"
                )
            case .moya:
                return .external(
                    name: "Moya"
                )
            case .kingfisher:
                return .external(
                    name: "Kingfisher"
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
            case .swifterSwift:
                return .external(
                    name: "SwifterSwift"
                )
            }
        }
    }
}
