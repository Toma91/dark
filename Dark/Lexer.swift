//
//  Lexer.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

extension Collection where Element == Character {
    
    func collect() -> String {
        return reduce(into: "") { $0.append($1) }
    }
    
}

struct Lexer<Buffer: BidirectionalCollection> where Buffer.Element == Character {

    private let buffer: Buffer

    private var index: Buffer.Index

    private(set) var currentToken: Token = Eof()

}

extension Lexer {
    
    init(buffer: Buffer) {
        self.buffer = buffer
        self.index = buffer.startIndex
        
        lex()
    }
 
    mutating func lex() {
        skipSpaces()
     
        guard index != buffer.endIndex else { return currentToken = Eof() }
     
        switch buffer[index] {
        
        case "a" ... "z": fallthrough
        case "A" ... "Z": return lexIdentifier()
            
        case "(": return lex(punctuator: .lParen)
        case ")": return lex(punctuator: .rParen)

        default: break
            
        }
        
        print("*** character", buffer[index])
        
        unimpl()
    }
    
}

private extension Lexer {

    mutating func lexIdentifier() {
        guard buffer[index].isAlpha else {
            fatalError("Invalid identifier start character '\(buffer[index])'")
        }
        
        let id = buffer[index...]
            .index { !$0.isAlphaNum }
            .map { buffer[index ..< $0].collect() }
            ?? buffer[index...].collect()
        
        _ = buffer.formIndex(&index, offsetBy: id.count, limitedBy: buffer.endIndex)
        
        currentToken = Keyword(rawValue: id) ?? Identifier(id)        
    }
    
    mutating func lex(punctuator: Punctuator) {
        currentToken = punctuator
        _ = buffer.formIndex(&index, offsetBy: 1, limitedBy: buffer.endIndex)
    }
    
}

private extension Lexer {
    
    mutating func skipSpaces() {
        while index < buffer.endIndex && buffer[index].isSpace {
            guard
                buffer.formIndex(&index, offsetBy: 1, limitedBy: buffer.endIndex)
                else{ return }
        }
    }
    
}




//struct Lexer<Buffer: BidirectionalCollection> where Buffer.Element == Character {
//
//    private let buffer: Buffer
//
//    private var index: Buffer.Index
//
//}
//
//extension Lexer {
//
//    init(buffer: Buffer) {
//        self.buffer = buffer
//        self.index = buffer.startIndex
//    }
//
//    mutating func getChar() -> Character? {
//        if skip(while: { $0.isSpace }) { return nil }
//
//        defer { buffer.formIndex(after: &index) }
//
//        return buffer[index]
//    }
//
//    mutating func getToken() -> Token {
//        if skip(while: { $0.isSpace }) {
//            return Eof()
//        }
//
//        switch buffer[index] {
//
//        case "a" ... "z": return lexIdentifier()
//
//        default: print("unknown char '\(buffer[index])'")
//
//        }
//
//        unimpl()
//    }
//
//}
//
//private extension Lexer {
//
//    mutating func skip(while predicate: (Character) -> Bool) -> Bool {
//        while index < buffer.endIndex && predicate(buffer[index]) {
//            buffer.formIndex(after: &index)
//        }
//
//        return index == buffer.endIndex
//    }
//
//}
//
//private extension Lexer {
//
//    mutating func lexIdentifier() -> Token {
//        var identifier = ""
//
//        repeat {
//            identifier.append(buffer[index])
//            buffer.formIndex(after: &index)
//        } while buffer[index].isAlphaNum
//
//        return Keyword(rawValue: identifier) ?? Identifier(identifier)
//    }
//
//    mutating func `operator`(_ o: Operator) -> Token {
//        buffer.formIndex(after: &index)
//        return o
//    }
//
//    mutating func punctuator(_ p: Punctuator) -> Token {
//        buffer.formIndex(after: &index)
//        return p
//    }
//
//}

//private extension Lexer {
//
//    mutating func lexStringCharacter() -> Character? {
//        buffer.formIndex(after: &index)
//
//        switch buffer[index] {
//        
//        case "\"": return nil
//            
//        default: return buffer[index]
//        
//        }
//    }
//    
//    mutating func lexStringLiteral() -> Token {
//        var s = ""
//        
//        while let c = lexStringCharacter() {
//            s.append(c)
//        }
//        
//        buffer.formIndex(after: &index)
//        
//        return s
//    }
//    
//}




//struct Lexer<I: BidirectionalCollection> where I.Element == Character {
//
//    private var curIndex: I.Index
//
//    private var input: I
//
//}
//
//extension Lexer {
//
//    init(input: I) {
//        self.curIndex = input.startIndex
//        self.input = input
//    }
//
//    mutating func getToken() -> Token {
//        while input[curIndex].isSpace {
//            input.formIndex(after: &curIndex)
//        }
//
//        switch input[curIndex] {
//
//        case "A" ... "Z": fallthrough
//        case "a" ... "z": return lexIdentifier()
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
//        default: fatalError("Unknown character '\(input[curIndex])'")
//
//        }
//    }
//
//}
//
//private extension Lexer {
//
//    mutating func advanceIf(_ predicate: (Character) -> Bool) -> Bool {
//        guard predicate(input[curIndex]) else { return false }
//
//        input.formIndex(after: &curIndex)
//        return true
//    }
//
//    func isOperatorLeftBound() -> Bool {
//        guard curIndex != input.startIndex else { return false }
//
//        switch input[input.index(before: curIndex)] {
//
//        case " ", "\r", "\n", "\t": fallthrough
//        case "(", "[", "{": fallthrough
//        case ",", ";", ":": fallthrough
//        case "\0": return false
//
//        case "/":
//            return input.index(before: curIndex) == input.startIndex
//                || input[input.index(curIndex, offsetBy: -2)] != "*"
//
//        case "\u{A0}":
//            return input.index(before: curIndex) == input.startIndex
//                || input[input.index(curIndex, offsetBy: -2)] != "\u{C2}"
//
//        default: return true
//
//        }
//    }
//
//    func isOperatorRightBound() -> Bool {
//        fatalError()
//    }
//
//    mutating func lexIdentifier() -> Token {
//        var identifier = ""
//
//        while input[curIndex].isAlphaNum {
//            identifier.append(input[curIndex])
//            input.formIndex(after: &curIndex)
//        }
//
//        return Keyword(rawValue: identifier) ?? Identifier(identifier)
//    }
//
//    mutating func lexOperator() -> Token {
//        let opStart = input[input.index(before: curIndex)]
//
//        guard advanceIf(Operator.canStartWith) else {
//            fatalError("Unexpected operator start")
//        }
//
//        repeat {
//            if input[curIndex] == "." && opStart != "." {
//                break
//            }
//        } while advanceIf(Operator.canContinueWith)
//
//
//        fatalError("\(input[curIndex])")
//
//
//
//
//        print("Not implemented yet", "~", input[curIndex...], "~")
//        fatalError()
//    }
//
//    mutating func punctuator(_ p: Punctuator) -> Token {
//        input.formIndex(after: &curIndex)
//        return p
//    }
//
////    private mutating func lexIdentifier() -> Token {
////        var identifier = ""
////
////        while curChar?.isAlphaNum == true {
////            identifier.append(curChar!)
////            curChar = input.next()
////        }
////
////        return Keyword(rawValue: identifier) ?? Identifier(identifier)
////    }
////
////    private mutating func punctuator(_ p: Punctuator) -> Token {
////        curChar = input.next()
////        return p
////    }
////
////    private func lexOperator() -> Token {
////        fatalError()
////    }
////
////    mutating func getToken() -> Token {
////        while curChar?.isSpace == true {
////            curChar = input.next()
////        }
////
////        switch curChar {
////
////        case ("a" ..< "z")?:
////            fallthrough
////        case ("A" ..< "Z")?:
////            return lexIdentifier()
////
////        case "(": return punctuator(.lParen)
////        case ")": return punctuator(.rParen)
////        case "{": return punctuator(.lBrace)
////        case "}": return punctuator(.rBrace)
////
////        case ":": return punctuator(.colon)
////
////        case "=": return lexOperator()
////
////        default:
////            print("Unknown character '\(curChar as Any)'")
////            fatalError()
////
////        }
////    }
//
//}
