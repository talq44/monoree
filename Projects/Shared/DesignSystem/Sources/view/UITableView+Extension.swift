//
//  UITableView+Extension.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import UIKit

// TODO:  UIKitShared 만들어지면 이동 해야함
extension UITableView {
    func registCell(
        type: UITableViewCell.Type,
        identifier: String? = nil
    ) {
        let cellId = String(describing: type)
        register(type, forCellReuseIdentifier: identifier ?? cellId)
    }
    
    func dequeueCell<T: UITableViewCell>(
        withType type: T.Type,
        for indexPath: IndexPath
    ) -> T? {
        let cellId = String(describing: type)
        return dequeueReusableCell(
            withIdentifier: cellId,
            for: indexPath
        ) as? T
    }
}
