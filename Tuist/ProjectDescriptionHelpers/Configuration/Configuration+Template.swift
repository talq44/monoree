//
//  Configuration+Template.swift
//  Manifests
//
//  Created by 박창규 on 11/21/24.
//

import ProjectDescription

public enum ConfigurationTemplate {
    
    public static let appConfigurations: [Configuration] = [
        .debug(
            name: .dev,
            xcconfig: .relativeToRoot("Configurations/monoree-DEV.xcconfig")
        ),
        .release(
            name: .prod,
            xcconfig: .relativeToRoot("Configurations/monoree-RELEASE.xcconfig")
        )
    ]
    
    public static let moduleConfigurations: [Configuration] = [
        .debug(name: .dev),
        .release(name: .prod),
    ]
}
