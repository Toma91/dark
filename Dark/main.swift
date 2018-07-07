//
//  main.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

import Foundation

print("Hello, World!")



extension Character {
    
    var _isAlpha: Bool {
        switch self {
            
        case "A" ... "Z": return true
        case "a" ... "z": return true
        default: return false
            
        }
    }
    
    var _isAlphaNum: Bool {
        return self._isAlpha || self._isNum
    }
    
    var _isNum: Bool {
        switch self {
            
        case "0" ... "9": return true
        default: return false
            
        }
    }
    
    var _isSpace: Bool {
        switch self {
        
        case " ": return true
        case "\t": return true
        case "\n": return true
        case "\r": return true
        default: return false
            
        }
    }
    
}

extension IteratorProtocol where Element == Character {
    
    mutating func skip(while predicate: (Character) -> Bool) -> Character? {
        while let c = next() {
            guard predicate(c) else { return c }
        }
        
        return nil
    }
    
    mutating func take(while predicate: (Character) -> Bool) -> (String, Character?) {
        var result = ""
        
        while let c = next() {
            if predicate(c) {
                result.append(c)
            } else {
                return (result, c)
            }
        }
        
        return (result, nil)
    }
    
}

enum _Token {

    case eof
    
    // ----------  punctuators
    
    case lParen
    case rParen
    case lBrace
    case rBrace
    
    case equal
    
    case stringQuote
    
    case colon

    // ----------  keywords
    
    case `func`
    case `let`

    // ----------  primary
    
    case any(Character)
    case identifier(String)

}

extension _Token {
    
    var isEof: Bool {
        switch self {
            
        case .eof: return true
        default: return false
            
        }
    }
    
}

struct _Lexer<I: IteratorProtocol> where I.Element == Character {
    
    private var curChar: Character? = " "
    
    private var input: I
    
    init(input: I) {
        self.input = input
    }
    
    
    mutating func getToken() -> _Token {
        while curChar?._isSpace == true {
            curChar = input.next()
        }
        
        if let t = recognizePunctuator() { curChar = input.next(); return t }
        
        if curChar?._isAlpha == true {
            var identifier = ""

            while curChar?.isAlpha == true {
                identifier.append(curChar!)
                curChar = input.next()
            }
           
            if let t = recognizeKeyword(identifier: identifier) { return t }
        
            return .identifier(identifier)
        }
      
        guard curChar != nil else { return .eof }
        
        defer { curChar = input.next() }
        return .any(curChar!)

        print("Unknown character '\(curChar as Any)'")
        fatalError()
    }

    private func recognizeKeyword(identifier: String) -> _Token? {
        switch identifier {
            
        case "func": return .func
        case "let": return .let
            
        default: return nil
            
        }
    }
    
    private func recognizePunctuator() -> _Token? {
        switch curChar {
            
        case "(": return .lParen
        case ")": return .rParen
        case "{": return .lBrace
        case "}": return .rBrace
            
        case "=": return .equal
        
        case "\"": return .stringQuote

        case ":": return .colon
            
        default: return nil
            
        }
    }
    
}

let _i = """
func test(name: String) {
  let value = "Hello "
  print(value + name)
}
test(name: "Andrea")
"""
var _lexer = _Lexer(input: _i.makeIterator())

while let t = Optional(_lexer.getToken()), !t.isEof {
    print("*** got token:", t)
}














