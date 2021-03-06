//
//  Character+Utils.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

extension Swift.Character {
    
    var isAlpha: Bool {
        switch self {
        
        case "A" ... "Z": return true
        case "a" ... "z": return true
            
        default: return false
            
        }
    }
    
    var isAlphaNum: Bool {
        return isAlpha || isNum
    }
    
    var isNum: Bool {
        switch self {
            
        case "0" ... "9": return true
        default: return false
            
        }
    }
    
    var isSpace: Bool {
        switch self {

        case " ": return true
        case "\t": return true
        case "\n": return true
        case "\r": return true
            
        default: return false
            
        }
    }
    
}
