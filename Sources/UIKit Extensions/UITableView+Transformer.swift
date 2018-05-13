//
//  UITableView+Transformer.swift
//  Pods
//
//  Created by William McGinty on 12/18/16.
//
//

import UIKit

public extension UITableView {
    
    /// Given a transformer, process the edit steps needed to convert between the source and destination.
    ///
    /// - Parameters:
    ///   - transformer: The transformer containing the source and destination states.
    ///   - section: The section in which the transformations take place. Defaults to 0.
    ///   - completion: A block to execute on completion of the transformation animations.
    @available(iOS 11, *)
    func processUpdates<U>(for transformer: Transformer<U>, inSection section: Int = 0, completion: ((Bool) -> Void)? = nil) {
        performBatchUpdates({
            transformer.editSteps.forEach { $0.edit(forSection: section, in: self) }
        }, completion: completion)
    }
    
    /// Given a transformer, process the edit steps needed to convert between the source and destination.
    ///
    /// - Parameters:
    ///   - transformer: The transformer containing the source and destination states.
    ///   - section: The section in which the transformations take place. Defaults to 0.
    func processUpdates<U>(for transformer: Transformer<U>, inSection section: Int = 0) {
        beginUpdates()
        transformer.editSteps.forEach { $0.edit(forSection: section, in: self) }
        endUpdates()
    }
}
