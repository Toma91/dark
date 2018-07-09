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

struct Eof: Token {
    
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

enum Operator: Token {
    
    case equal
    case plus
    
}

enum Punctuator: Token {

    case lParen
    case rParen
    case lBrace
    case rBrace

    case colon
    
}

extension String: Token { }



//protocol Token {
//    
//}
//
//extension Token {
//    
//    var isEof: Bool {
//        return false
//    }
//    
//}
//
//enum Keyword: String, Token {
//    
//    case `func`
//    case `let`
//    
//}
//
//struct Identifier: Token {
//    
//    let identifier: String
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
//enum Punctuator: Token {
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
//struct Operator: Token {
//    
//    static let operatorCharacters: [Character] = [
//        "/", "=", "-", "+", "*", "%", "<", ">", "!", "&", "|", "^", "~", ".", "?"
//    ]
//    
//    static func canStartWith(character c: Character) -> Bool {
//        if operatorCharacters.contains(c) { return true }
//        
//        return (c >= "¡" && c <= "§")
//            || c == "©" || c == "«" || c == "¬" || c == "®"
//            || c == "°" || c == "±" || c == "¶" || c == "»"
//            || c == "¿" || c == "×" || c == "÷"
//            || c == "‖" || c == "‗" || (c >= "†" && c <= "‧")
//            || (c >= "‰" && c <= "‾") || (c >= "⁁" && c <= "⁓")
//            || (c >= "⁕" && c <= "⁞") || (c >= "←" && c <= "⏿")
//            || (c >= "─" && c <= "❵") || (c >= "➔" && c <= "⯿")
//            || (c >= "⸀" && c <= "⹿") || (c >= "、" && c <= "〃")
//            || (c >= "〈" && c <= "〰")
//    }
//    
//    static func canContinueWith(character c: Character) -> Bool {
//        if canStartWith(character: c) { return true }
//    
//        guard
//            let C = c.unicodeScalars.first?.value, c.unicodeScalars.count == 1
//            else { fatalError("Strange character? (\(c)") }
//        
//        return (C >= 0x0300 && C <= 0x036F)
//            || (C >= 0x1DC0 && C <= 0x1DFF)
//            || (C >= 0x20D0 && C <= 0x20FF)
//            || (C >= 0xFE00 && C <= 0xFE0F)
//            || (C >= 0xFE20 && C <= 0xFE2F)
//            || (C >= 0xE0100 && C <= 0xE01EF)
//    }
//    
//}
//
//
////enum Token {
////
////    case eof
////
////    // ----------  punctuators
////
////    case lParen
////    case rParen
////    case lBrace
////    case rBrace
////
////    case equal
////
////    case stringQuote
////
////    case colon
////
////    // ----------  keywords
////
////    case `func`
////    case `let`
////
////    // ----------  primary
////
////    case any(Character)
////    case identifier(String)
////
////}
////
////extension Token {
////
////    var isEof: Bool {
////        switch self {
////
////        case .eof: return true
////        default: return false
////
////        }
////    }
////
////}
