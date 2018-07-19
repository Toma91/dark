//
//  Token.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

enum Keyword: String {
    
    case `func`
    
}

enum Punctuator {
    
    case lParen
    case rParen
    case lBrace
    case rBrace
    
    case colon
    
}

struct Token {
    
    enum Flavor {
        
        case uninitialized
        case identifier(String)
        case keyword(Keyword)
        case punctuator(Punctuator)
        case eof

    }
    
    let leadingTrivia: [Trivia]

    let flavor: Flavor
    
    let trailingTrivia: [Trivia]

}

extension Token.Flavor: CustomStringConvertible {
    
    var description: String {
        switch self {
        
        case .uninitialized: return ".uninitialized"
        case .identifier(let i): return ".identifier(\"\(i)\")"
        case .keyword(let k): return ".keyword(\(k))"
        case .punctuator(let p): return ".punctuator(\(p))"
        case .eof: return ".eof"

        }
    }
    
}
extension Token.Flavor: Equatable {
    
    static func ==(lhs: Token.Flavor, rhs: Token.Flavor) -> Bool {
        switch (lhs, rhs) {
        
        case (.uninitialized, .uninitialized): return true
        case (.identifier(let x), .identifier(let y)): return x == y
        case (.keyword(let x), .keyword(let y)): return x == y
        case (.punctuator(let x), .punctuator(let y)): return x == y
        case (.eof, .eof): return true

        default: return false
            
        }
    }
        
}









//
//extension Token {
//
//    func `is`<T: Token>(_ kind: T.Type) -> Bool {
//        fatalError()
//    }
//
//}
//
//func test(a: Token) {
//    print(a is Lexer<String>)
//}
//
//
//
//struct Identifier: Token {
//
//    let identifier: String
//
//    func `is`(_ t: Token) -> Bool {
//        guard let t = t as? Identifier else { return false }
//
//        return self.identifier == t.identifier
//    }
//
//}
//
//extension Token {
//
//    var isIdentifier: Bool {
//        return self is Identifier
//    }
//
//}
//
//extension Identifier {
//
//    init(_ identifier: String) {
//        self.identifier = identifier
//    }
//
//}
//
//enum Operator {
//
//    case equal
//    case plus
//
//}
//
//extension Operator: Token {
//
//    func `is`(_ t: Token) -> Bool {
//        guard let t = t as? Operator else { return false }
//
//        return self == t
//    }
//
//}
//
//enum Punctuator {
//
//    case lParen
//    case rParen
//    case lBrace
//    case rBrace
//
//    case colon
//
//}
//
//extension Punctuator: Token {
//
//    func `is`(_ t: Token) -> Bool {
//        guard let t = t as? Punctuator else { return false }
//
//        return self == t
//    }
//
//}
//
//extension String: Token {
//
//    func `is`(_ t: Token) -> Bool {
//        guard let t = t as? String else { return false }
//
//        return self == t
//    }
//
//}
//
//
//
////protocol Token {
////
////}
////
////extension Token {
////
////    var isEof: Bool {
////        return false
////    }
////
////}
////
////enum Keyword: String, Token {
////
////    case `func`
////    case `let`
////
////}
////
////struct Identifier: Token {
////
////    let identifier: String
////
////}
////
////extension Identifier {
////
////    init(_ identifier: String) {
////        self.identifier = identifier
////    }
////
////}
////
////enum Punctuator: Token {
////
////    case lParen
////    case rParen
////    case lBrace
////    case rBrace
////
////    case colon
////
////}
////
////struct Operator: Token {
////
////    static let operatorCharacters: [Character] = [
////        "/", "=", "-", "+", "*", "%", "<", ">", "!", "&", "|", "^", "~", ".", "?"
////    ]
////
////    static func canStartWith(character c: Character) -> Bool {
////        if operatorCharacters.contains(c) { return true }
////
////        return (c >= "¡" && c <= "§")
////            || c == "©" || c == "«" || c == "¬" || c == "®"
////            || c == "°" || c == "±" || c == "¶" || c == "»"
////            || c == "¿" || c == "×" || c == "÷"
////            || c == "‖" || c == "‗" || (c >= "†" && c <= "‧")
////            || (c >= "‰" && c <= "‾") || (c >= "⁁" && c <= "⁓")
////            || (c >= "⁕" && c <= "⁞") || (c >= "←" && c <= "⏿")
////            || (c >= "─" && c <= "❵") || (c >= "➔" && c <= "⯿")
////            || (c >= "⸀" && c <= "⹿") || (c >= "、" && c <= "〃")
////            || (c >= "〈" && c <= "〰")
////    }
////
////    static func canContinueWith(character c: Character) -> Bool {
////        if canStartWith(character: c) { return true }
////
////        guard
////            let C = c.unicodeScalars.first?.value, c.unicodeScalars.count == 1
////            else { fatalError("Strange character? (\(c)") }
////
////        return (C >= 0x0300 && C <= 0x036F)
////            || (C >= 0x1DC0 && C <= 0x1DFF)
////            || (C >= 0x20D0 && C <= 0x20FF)
////            || (C >= 0xFE00 && C <= 0xFE0F)
////            || (C >= 0xFE20 && C <= 0xFE2F)
////            || (C >= 0xE0100 && C <= 0xE01EF)
////    }
////
////}
////
////
//////enum Token {
//////
//////    case eof
//////
//////    // ----------  punctuators
//////
//////    case lParen
//////    case rParen
//////    case lBrace
//////    case rBrace
//////
//////    case equal
//////
//////    case stringQuote
//////
//////    case colon
//////
//////    // ----------  keywords
//////
//////    case `func`
//////    case `let`
//////
//////    // ----------  primary
//////
//////    case any(Character)
//////    case identifier(String)
//////
//////}
//////
//////extension Token {
//////
//////    var isEof: Bool {
//////        switch self {
//////
//////        case .eof: return true
//////        default: return false
//////
//////        }
//////    }
//////
//////}
