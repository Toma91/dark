//
//  Parser.swift
//  Dark
//
//  Created by Andrea Tomarelli on 12/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

protocol DarkToken {
    
    func `is`(_ other: DarkToken) -> Bool
  
}

extension DarkToken {
    
    func `is`<T: DarkToken>(_ other: T.Type) -> Bool {
        return self is T
    }
    
}

struct DarkEof: DarkToken {
 
    func `is`(_ other: DarkToken) -> Bool {
        return other is DarkEof
    }
    
}

enum DarkKeyword: String, DarkToken {
    
    case `func`
    
    
    func `is`(_ other: DarkToken) -> Bool {
        if let k = other as? DarkKeyword {
            return self == k
        } else {
            return false
        }
    }
    
}

struct DarkIdentifier: DarkToken {
    
    let id: String
    
    
    func `is`(_ other: DarkToken) -> Bool {
        if let k = other as? DarkIdentifier {
            return self.id == k.id
        } else {
            return false
        }
    }
    
}

enum DarkPunctuator: DarkToken {
    
    case lParen
    case rParen
    case lBrace
    case rBrace
    
    case comma
    case colon
    
    case arrow
    
    
    func `is`(_ other: DarkToken) -> Bool {
        if let p = other as? DarkPunctuator {
            return self == p
        } else {
            return false
        }
    }

}

struct DarkLexer<Buffer: BidirectionalCollection> where Buffer.Element == Character {
    
    private let buffer: Buffer

    private var index: Buffer.Index
    
    private(set) var currentToken: DarkToken = DarkEof()

    init(buffer: Buffer) {
        self.buffer = buffer
        self.index = buffer.startIndex
        
        lex()
    }
    
    mutating func lex() {
        while index < buffer.endIndex && buffer[index].isSpace {
            buffer.formIndex(after: &index)
        }
        
        guard index < buffer.endIndex else { return currentToken = DarkEof() }
        
        switch buffer[index] {
        
        case "a" ... "z": fallthrough
        case "A" ... "Z": return lexIdentifier()

        case "(": return lex(.lParen)
        case ")": return lex(.rParen)
        case "{": return lex(.lBrace)
        case "}": return lex(.rBrace)

        case ":": return lex(.colon)

        case "-": return lexArrow()
            
        default: fatalError("Unknown character '\(buffer[index])'")
            
        }
    }

    private mutating func lex(_ p: DarkPunctuator) {
        currentToken = p
        buffer.formIndex(after: &index)
    }
    
    private mutating func lexArrow() {
        buffer.formIndex(after: &index)

        guard index < buffer.endIndex && buffer[index] == ">" else {
            fatalError("Invalid character in source code")
        }
        
        buffer.formIndex(after: &index)

        currentToken = DarkPunctuator.arrow
    }
    
    private mutating func lexIdentifier() {
        var id = String(buffer[index])
        
        buffer.formIndex(after: &index)

        while index < buffer.endIndex && buffer[index].isAlphaNum {
            id.append(buffer[index])
            buffer.formIndex(after: &index)
        }
        
        currentToken = DarkKeyword(rawValue: id) ?? DarkIdentifier(id: id)
    }
    
}

struct DarkParser<Buffer: BidirectionalCollection> where Buffer.Element == Character {
    
    private var lexer: DarkLexer<Buffer>

    init(lexer: DarkLexer<Buffer>) {
        self.lexer = lexer
    }
    
    mutating func parseArgumentName() -> Bool {
        guard let id = lexer.currentToken as? DarkIdentifier else {
            print("expected identifier")
            return false
        }
        
        print("argument name is: \"\(id.id)\"")
        
        lexer.lex()
        
        return true
    }
    
    mutating func parseDeclaration() -> Bool {
        guard parseFunctionDeclaration() else {
            print("could not parse function declaration")
            return false
        }
        
        return true
    }

    mutating func parseFunctionArgumentList() -> Bool {
        guard parseFunctionArgument() else {
            print("could not parse function argument")
            return false
        }
        
        guard lexer.currentToken.is(DarkPunctuator.comma) else { return true }
    
        lexer.lex()
       
        guard parseFunctionArgumentList() else {
            print("could not parse function argument list")
            return false
        }
        
        return true
    }
    
    mutating func parseFunctionArgument() -> Bool {
        guard parseArgumentName() else {
            print("could not parse argument name")
            return false
        }
    
        guard lexer.currentToken.is(DarkPunctuator.colon) else {
            print("expected ':'")
            return false
        }
        
        lexer.lex()
        
        guard parseType() else {
            print("could not parse type")
            return false
        }
        
        return true
    }
    
    mutating func parseFunctionArguments() -> Bool {
        guard lexer.currentToken.is(DarkPunctuator.lParen) else {
            print("expected '('")
            return false
        }
        
        lexer.lex()

        _ = parseFunctionArgumentList()
        
        guard lexer.currentToken.is(DarkPunctuator.rParen) else {
            print("expected ')'")
            return false
        }

        lexer.lex()
        
        return true
    }
    
    mutating func parseFunctionBody() -> Bool {
        guard lexer.currentToken.is(DarkPunctuator.lBrace) else {
            print("expected '{'")
            return false
        }
        
        lexer.lex()
        
        guard lexer.currentToken.is(DarkPunctuator.rBrace) else {
            print("expected '}'")
            return false
        }
        
        lexer.lex()

        return true
    }
    
    mutating func parseFunctionDeclaration() -> Bool {
        guard lexer.currentToken.is(DarkKeyword.func) else {
            print("expected 'func'")
            return false
        }
        
        lexer.lex()
        
        guard parseFunctionName() else {
            print("could not parse function name")
            return false
        }

        guard parseFunctionSignature() else {
            print("could not parse function signature")
            return false
        }
        
        guard parseFunctionBody() else {
            print("could not parse function body")
            return false
        }
        
        return true
    }
    
    mutating func parseFunctionName() -> Bool {
        guard let id = lexer.currentToken as? DarkIdentifier else {
            print("expected identifier")
            return false
        }

        print("function name is: \"\(id.id)\"")

        lexer.lex()
        
        return true
    }
    
    mutating func parseFunctionSignature() -> Bool {
        guard parseFunctionArguments() else {
            print("could not parse function arguments")
            return false
        }
        
        guard lexer.currentToken.is(DarkPunctuator.arrow) else {
            print("expected '->'")
            return false
        }
        
        lexer.lex()
     
        guard parseType() else {
            print("could not parse type")
            return false
        }
        
        return true
    }

    mutating func parseTopLevelExpression() -> Bool {
        while parseDeclaration() {
            // empty
        }
        
        return true
    }
    
    mutating func parseType() -> Bool {
        guard let id = lexer.currentToken as? DarkIdentifier else {
            print("expected identifier")
            return false
        }
        
        print("type is: \"\(id.id)\"")

        lexer.lex()
        
        return true
    }
    
}








struct ParserError: Error {

    let message: String

}

struct Parser<Buffer: BidirectionalCollection> where Buffer.Element == Character {

    var lexer: Lexer<Buffer>

    init(lexer: Lexer<Buffer>) {
        self.lexer = lexer
    }

}

extension Parser {

    mutating func parseCodeBlock() throws {
        print("Parsing code block")

        guard
            let lBrace = lexer.currentToken as? Punctuator,
            lBrace == .lBrace
            else { throw ParserError(message: "Expected '{'") }

        lexer.lex()

        if let rBrace = lexer.currentToken as? Punctuator, rBrace == .rBrace {
            print("Parsed empty code block")
            return lexer.lex()
        }

        try parseStatement()

        guard
            let rBrace = lexer.currentToken as? Punctuator,
            rBrace == .rBrace
            else { throw ParserError(message: "Expected '}'") }

        print("Parsed code block")
    }

    mutating func parseDeclaration() throws {
        print("Parsing declaration")
        try parseFunctionDeclaration()
        print("Parsed declaration")
    }

    mutating func parseFunctionBody() throws {
        print("Parsing function body")
        try parseCodeBlock()
        print("Parsed function body")
    }

    mutating func parseFunctionDeclaration() throws {
        print("Parsing function declaration")

        guard
            let t = lexer.currentToken as? Keyword,
            t == .func
            else { throw ParserError(message: "Expected 'func' keyword") }

        lexer.lex()

        try parseFunctionName()
        try parseFunctionSignature()
        try parseFunctionBody()

        print("Parsed function declaration")
    }

    mutating func parseFunctionName() throws {
        print("Parsing function name")
        try parseIdentifier()
        print("Parsed function name")
    }

    mutating func parseFunctionResult() throws {
        print("Parsing function result")

        guard
            let arrow = lexer.currentToken as? Punctuator,
            arrow == .arrow
            else { throw ParserError(message: "Expected '->'") }

        lexer.lex()

        try parseType()

        print("Parsed function result")
    }

    mutating func parseFunctionSignature() throws {
        print("Parsing function signature")
        try parseParametersClause()
        try parseFunctionResult()
        print("Parsed function signature")
    }

    mutating func parseIdentifier() throws {
        print("Parsing identifier")

        guard let id = lexer.currentToken as? Identifier else {
            throw ParserError(message: "Expected identifier")
        }

        lexer.lex()

        print("Parsed identifier '\(id.identifier)'")
    }

    mutating func parseParameter() throws {
        print("Parsing parameter")
        try parseParameterName()
        try parseTypeAnnotation()
        print("Parsed parameter")
    }

    mutating func parseParameterName() throws {
        print("Parsing parameter name")
        try parseIdentifier()
        print("Parsed parameter name")
    }

    mutating func parseParametersClause() throws {
        print("Parsing parameters clause")

        guard
            let lParen = lexer.currentToken as? Punctuator,
            lParen == .lParen
            else { throw ParserError(message: "Expected '('") }

        lexer.lex()

        if let rParen = lexer.currentToken as? Punctuator, rParen == .rParen {
            print("Parsed empty parameters clause")
            return lexer.lex()
        }

        try parseParametersList()

        guard
            let rParen = lexer.currentToken as? Punctuator,
            rParen == .rParen
            else { throw ParserError(message: "Expected ')'") }

        lexer.lex()

        print("Parsed parameters clause")
    }

    mutating func parseParametersList() throws {
        print("Parsing parameters list")

        try parseParameter()

        if let t = lexer.currentToken as? Punctuator, t == .comma {
            try parseParametersList()
        }

        print("Parsed parameters list")
    }

    mutating func parseStatement() throws {
        print("Parsing statement")
        try parseDeclaration()
        print("Parsed statement")
    }

    mutating func parseTopLevelExpression() throws {
        print("Parsing top level expression")
        try parseStatement()
        print("Parsed top level expression")
    }

    mutating func parseType() throws {
        print("Parsing type")
        try parseIdentifier()
        print("Parsed type")
    }

    mutating func parseTypeAnnotation() throws {
        print("Parsing type annotation")

        guard
            let colon = lexer.currentToken as? Punctuator,
            colon == .colon
            else { throw ParserError(message: "Expected ':'") }

        lexer.lex()

        try parseType()

        print("Parsed type annotation")
    }

}
