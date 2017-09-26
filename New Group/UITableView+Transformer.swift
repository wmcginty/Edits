//
//  UITableView+Transformer.swift
//  Pods
//
//  Created by William McGinty on 12/18/16.
//
//

import UIKit

public extension UITableView {
    
    @available(iOS 11, *)
    func processUpdates<U>(for transformer: Transformer<U>, in section: Int, completion: ((Bool) -> Void)? = nil) {
        performBatchUpdates({
            transformer.editSteps.forEach { $0.edit(forSection: section, in: self) }
        }, completion: completion)
    }
    
    func processUpdates<U>(for transformer: Transformer<U>, in section: Int) {
        beginUpdates()
        transformer.editSteps.forEach { $0.edit(forSection: section, in: self) }
        endUpdates()
    }
}
