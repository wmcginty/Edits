//
//  TransformerFactory.swift
//  Pods
//
//  Created by William McGinty on 11/13/16.
//
//

import Foundation

public struct TransformerFactory {
    
    public static func transformer(from: String, to: String) -> Transformer<String.CharacterView> {
        return transformer(from: from.characters, to: to.characters)
    }
    
    public static func transformer<T: RangeReplaceableCollection>(from: T, to: T) -> Transformer<T> where T.IndexDistance == Int {
        return Transformer(source: from, destination: to)
    }
}
