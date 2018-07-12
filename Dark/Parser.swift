//
//  Parser.swift
//  Dark
//
//  Created by Andrea Tomarelli on 12/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

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
    
    mutating func parseDeclaration() throws {
        unimpl()
    }
    
    mutating func parseFunctionDeclaration() throws {
        unimpl()
    }
    
    mutating func parseFunctionName() throws {
        unimpl()
    }
    
    mutating func parseStatement() throws {
        try parseDeclaration()
    }

    mutating func parseTopLevelExpression() throws {
        unimpl()
    }
    
}
