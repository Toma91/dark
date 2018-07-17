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

enum DarkKeyword: DarkToken {
    
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

struct DarkLexer {
    
    let currentToken: DarkToken

    func lex() {
        
    }
    
}

struct DarkParser {

    private let lexer: DarkLexer

    
    func parseArgumentName() -> Bool {
        guard lexer.currentToken.is(DarkIdentifier.self) else { return false }
        
        lexer.lex()
        
        return true
    }
    
    func parseDeclaration() -> Bool {
        return parseFunctionDeclaration()
    }

    func parseFunctionArgumentList() -> Bool {
        guard parseFunctionArgument() else { return false }
        
        guard lexer.currentToken.is(DarkPunctuator.comma) else { return true }
    
        lexer.lex()
       
        return parseFunctionArgumentList()
    }
    
    func parseFunctionArgument() -> Bool {
        guard parseArgumentName() else { return false }
    
        guard lexer.currentToken.is(DarkPunctuator.colon) else { return false }
        
        lexer.lex()
        
        return parseType()
    }
    
    func parseFunctionArguments() -> Bool {
        guard lexer.currentToken.is(DarkPunctuator.lParen) else { return false }
        
        lexer.lex()

        _ = parseFunctionArgumentList()
        
        guard lexer.currentToken.is(DarkPunctuator.rParen) else { return false }

        lexer.lex()
        
        return true
    }
    
    func parseFunctionBody() -> Bool {
        guard lexer.currentToken.is(DarkPunctuator.lBrace) else { return false }
        
        lexer.lex()
        
        guard lexer.currentToken.is(DarkPunctuator.rBrace) else { return false }
        
        lexer.lex()

        return true
    }
    
    func parseFunctionDeclaration() -> Bool {
        guard lexer.currentToken.is(DarkKeyword.func) else { return false }
        
        lexer.lex()
        
        guard parseFunctionName() else { return false }

        guard parseFunctionSignature() else { return false }
        
        return parseFunctionBody()
    }
    
    func parseFunctionName() -> Bool {
        guard lexer.currentToken.is(DarkIdentifier.self) else { return false }

        lexer.lex()
        
        return true
    }
    
    func parseFunctionSignature() -> Bool {
        guard parseFunctionArguments() else { return false }
        
        guard lexer.currentToken.is(DarkPunctuator.arrow) else { return false }
        
        lexer.lex()
     
        return parseType()
    }

    func parseTopLevelExpression() -> Bool {
        while parseDeclaration() {
            // empty
        }
        
        return true
    }
    
    func parseType() -> Bool {
        guard lexer.currentToken.is(DarkIdentifier.self) else { return false }

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
