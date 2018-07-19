//
//  IteratorProtocol+Utils.swift
//  Dark
//
//  Created by Andrea Tomarelli on 08/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

//import Foundation
//
//extension IteratorProtocol where Element == Character {
//    
//    mutating func skip(while predicate: (Character) -> Bool) -> Character? {
//        while let c = next() {
//            guard predicate(c) else { return c }
//        }
//        
//        return nil
//    }
//    
//    mutating func take(while predicate: (Character) -> Bool) -> (String, Character?) {
//        var result = ""
//        
//        while let c = next() {
//            if predicate(c) {
//                result.append(c)
//            } else {
//                return (result, c)
//            }
//        }
//        
//        return (result, nil)
//    }
//    
//}
