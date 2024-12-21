//
//  SharedModule.swift
//  ProjectDescriptionHelpers
//
//  Created by 박창규 on 11/21/24.
//

import ProjectDescription

public enum SharedModule: String, CaseIterable {
	case DesignSystem
	case FoundationShared
    case ReactiveXShared
    
    public var name: String {
        self.rawValue
    }
}
