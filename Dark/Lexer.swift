//
//  Lexer.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

struct Lexer<I: IteratorProtocol> where I.Element == Character {
    
    private var curChar: Character? = " "
    
    private var input: I
    
    init(input: I) {
        self.input = input
    }
    
    
    private mutating func lexIdentifier() -> Token {
        var identifier = ""
        
        while curChar?.isAlphaNum == true {
            identifier.append(curChar!)
            curChar = input.next()
        }
        
        return Keyword(rawValue: identifier) ?? Identifier(identifier)
    }
    
    private mutating func punctuator(_ p: Punctuator) -> Token {
        curChar = input.next()
        return p
    }
    
    private func lexOperator() -> Token {
        fatalError()
    }
    
    mutating func getToken() -> Token {
        while curChar?.isSpace == true {
            curChar = input.next()
        }
        
        switch curChar {
            
        case ("a" ..< "z")?:
            fallthrough
        case ("A" ..< "Z")?:
            return lexIdentifier()
            
        case "(": return punctuator(.lParen)
        case ")": return punctuator(.rParen)
        case "{": return punctuator(.lBrace)
        case "}": return punctuator(.rBrace)
            
        case ":": return punctuator(.colon)
            
        case "=": return lexOperator()
            
        default:
            print("Unknown character '\(curChar as Any)'")
            fatalError()
            
        }
        
        
//        if let t = recognizePunctuator() { curChar = input.next(); return t }
//
//        if curChar?.isAlpha == true {
//            var identifier = ""
//
//            while curChar?.isAlpha == true {
//                identifier.append(curChar!)
//                curChar = input.next()
//            }
//
//            if let t = recognizeKeyword(identifier: identifier) { return t }
//
//            return .identifier(identifier)
//        }
//
//        guard curChar != nil else { return .eof }
//
//        defer { curChar = input.next() }
//        return .any(curChar!)
//
//        print("Unknown character '\(curChar as Any)'")
//        fatalError()
    }
    
//    private func recognizeKeyword(identifier: String) -> Token? {
//        switch identifier {
//
//        case "func": return .func
//        case "let": return .let
//
//        default: return nil
//
//        }
//    }
    
//    private func recognizePunctuator() -> Token? {
//        switch curChar {
//
//        case "(": return .lParen
//        case ")": return .rParen
//        case "{": return .lBrace
//        case "}": return .rBrace
//
//        case "=": return .equal
//
//        case "\"": return .stringQuote
//
//        case ":": return .colon
//
//        default: return nil
//
//        }
//    }
    
}
