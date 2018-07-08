//
//  Token.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

protocol Token {
    
}

extension Token {
    
    var isEof: Bool {
        return false
    }
    
}

enum Keyword: String, Token {
    
    case `func`
    case `let`
    
}

struct Identifier: Token {
    
    let identifier: String
    
}

extension Identifier {
    
    init(_ identifier: String) {
        self.identifier = identifier
    }
    
}

enum Punctuator: Token {
    
    case lParen
    case rParen
    case lBrace
    case rBrace

    case colon
    
}

enum Operator: Token {
    
    case equal
    
}


//enum Token {
//
//    case eof
//
//    // ----------  punctuators
//
//    case lParen
//    case rParen
//    case lBrace
//    case rBrace
//
//    case equal
//
//    case stringQuote
//
//    case colon
//
//    // ----------  keywords
//
//    case `func`
//    case `let`
//
//    // ----------  primary
//
//    case any(Character)
//    case identifier(String)
//
//}
//
//extension Token {
//
//    var isEof: Bool {
//        switch self {
//
//        case .eof: return true
//        default: return false
//
//        }
//    }
//
//}
