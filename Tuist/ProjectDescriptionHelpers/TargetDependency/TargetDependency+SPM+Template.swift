//
//  TargetDependency+SPM+Template.swift
//  Manifests
//
//  Created by 박창규 on 11/20/24.
//

import ProjectDescription

extension TargetDependency {
    public enum SPM {
        // MARK: - Architecture
        public static let ComposableArchitecture: TargetDependency = .external(
            name: "ComposableArchitecture"
        )
        
        // MARK: - Network
        public static let alamofire: TargetDependency = .external(
            name: "Alamofire"
        )
        public static let moya: TargetDependency = .external(
            name: "Moya"
        )
        
        // MARK: - UI
        public static let kingfisher: TargetDependency = .external(
            name: "Kingfisher"
        )
        
        // MARK: - Firebase
        public static let firebaseAnalytics: TargetDependency = .external(
            name: "FirebaseAnalytics"
        )
        public static let firebaseCore: TargetDependency = .external(
            name: "FirebaseCore"
        )
        public static let firebaseRemoteConfig: TargetDependency = .external(
            name: "FirebaseRemoteConfig"
        )
        public static let firebaseCrashlytics: TargetDependency = .external(
            name: "FirebaseCrashlytics"
        )
        public static let firebaseMessaging: TargetDependency = .external(
            name: "FirebaseMessaging"
        )
        public static let firebasePerformance: TargetDependency = .external(
            name: "FirebasePerformance"
        )
        
        // MARK: - extension
        public static let swifterSwift: TargetDependency = .external(
            name: "SwifterSwift"
        )
    }
}
