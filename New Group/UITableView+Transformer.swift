//
//  UITableView+Transformer.swift
//  Pods
//
//  Created by William McGinty on 12/18/16.
//
//

import UIKit

public extension UITableView {
    
    func processUpdates<U>(for transformer: Transformer<U>, in section: Int) {
        beginUpdates()
        transformer.editSteps.forEach { $0.edit(forSection: section, in: self) }
        endUpdates()
    }
}
