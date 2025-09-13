//
//  ConfigurationName+Template.swift
//  ProjectDescriptionHelpers
//
//  Created by 박창규 on 11/21/24.
//

import ProjectDescription

public extension ProjectDescription.ConfigurationName {
    static var dev: ConfigurationName { configuration("debug") }
    static var prod: ConfigurationName { configuration("release") }
}
