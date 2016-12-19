//
//  UICollectionView+Transformer.swift
//  Pods
//
//  Created by William McGinty on 12/18/16.
//
//

import Foundation

public extension UICollectionView {
    
    func processUpdates<U>(for transformer: Transformer<U>, in section: Int) {
        let editSteps = transformer.editSteps
        //TODO: Process the transforms
    }
}
