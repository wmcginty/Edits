//
//  UICollectionView+Transformer.swift
//  Pods
//
//  Created by William McGinty on 12/18/16.
//
//

import Foundation

public extension UICollectionView {
    
    func processUpdates<U>(for transformer: Transformer<U>, inSection section: Int, completion: ((Bool) -> Void)? = nil) {
        performBatchUpdates({
            transformer.editSteps.forEach { $0.edit(forSection: section, in: self) }
        }, completion: completion)
    }
}
