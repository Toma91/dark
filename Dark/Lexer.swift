//
//  Lexer.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

struct Lexer<I: BidirectionalCollection> where I.Element == Character {
    
    private var curIndex: I.Index
    
    private var input: I
    
}

extension Lexer {
    
    init(input: I) {
        self.curIndex = input.startIndex
        self.input = input
    }
   
    mutating func getToken() -> Token {
        while input[curIndex].isSpace {
            input.formIndex(after: &curIndex)
        }
        
        switch input[curIndex] {
            
        case "A" ... "Z": fallthrough
        case "a" ... "z": return lexIdentifier()

        case "(": return punctuator(.lParen)
        case ")": return punctuator(.rParen)
        case "{": return punctuator(.lBrace)
        case "}": return punctuator(.rBrace)

        case ":": return punctuator(.colon)
            
        case "=": return lexOperator()

        default: fatalError("Unknown character '\(input[curIndex])'")
            
        }
    }
    
}

private extension Lexer {
    
    mutating func advanceIf(_ predicate: (Character) -> Bool) -> Bool {
        guard predicate(input[curIndex]) else { return false }
        
        input.formIndex(after: &curIndex)
        return true
    }
    
    func isOperatorLeftBound() -> Bool {
        guard curIndex != input.startIndex else { return false }
        
        switch input[input.index(before: curIndex)] {
        
        case " ", "\r", "\n", "\t": fallthrough
        case "(", "[", "{": fallthrough
        case ",", ";", ":": fallthrough
        case "\0": return false
            
        case "/":
            return input.index(before: curIndex) == input.startIndex
                || input[input.index(curIndex, offsetBy: -2)] != "*"

        case "\u{A0}":
            return input.index(before: curIndex) == input.startIndex
                || input[input.index(curIndex, offsetBy: -2)] != "\u{C2}"
            
        default: return true
            
        }
    }
    
    func isOperatorRightBound() -> Bool {
        fatalError()
    }
    
    mutating func lexIdentifier() -> Token {
        var identifier = ""
        
        while input[curIndex].isAlphaNum {
            identifier.append(input[curIndex])
            input.formIndex(after: &curIndex)
        }
        
        return Keyword(rawValue: identifier) ?? Identifier(identifier)
    }
    
    mutating func lexOperator() -> Token {
        let opStart = input[input.index(before: curIndex)]

        guard advanceIf(Operator.canStartWith) else {
            fatalError("Unexpected operator start")
        }
       
        repeat {
            if input[curIndex] == "." && opStart != "." {
                break
            }
        } while advanceIf(Operator.canContinueWith)
        
        
        fatalError("\(input[curIndex])")
        
        
        
        
        print("Not implemented yet", "~", input[curIndex...], "~")
        fatalError()
    }
    
    mutating func punctuator(_ p: Punctuator) -> Token {
        input.formIndex(after: &curIndex)
        return p
    }

//    private mutating func lexIdentifier() -> Token {
//        var identifier = ""
//        
//        while curChar?.isAlphaNum == true {
//            identifier.append(curChar!)
//            curChar = input.next()
//        }
//        
//        return Keyword(rawValue: identifier) ?? Identifier(identifier)
//    }
//    
//    private mutating func punctuator(_ p: Punctuator) -> Token {
//        curChar = input.next()
//        return p
//    }
//    
//    private func lexOperator() -> Token {
//        fatalError()
//    }
//    
//    mutating func getToken() -> Token {
//        while curChar?.isSpace == true {
//            curChar = input.next()
//        }
//        
//        switch curChar {
//            
//        case ("a" ..< "z")?:
//            fallthrough
//        case ("A" ..< "Z")?:
//            return lexIdentifier()
//            
//        case "(": return punctuator(.lParen)
//        case ")": return punctuator(.rParen)
//        case "{": return punctuator(.lBrace)
//        case "}": return punctuator(.rBrace)
//            
//        case ":": return punctuator(.colon)
//            
//        case "=": return lexOperator()
//            
//        default:
//            print("Unknown character '\(curChar as Any)'")
//            fatalError()
//            
//        }
//    }
    
}
