//
//  Lexer.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

protocol LexerInput {
    
    func peekChar() -> Character
    
    func skip(while predicate: (Character) -> Bool)
    
}


protocol InputProcessor {
    
    func identifyToken(using input: LexerInput) -> Token
    
}

struct AlphaProcessor: InputProcessor {
 
    func identifyToken(using input: LexerInput) -> Token {
        fatalError()
    }
    
}

struct Lexer {
    
    private let input: LexerInput
    
    
    init(input: LexerInput) {
        self.input = input
    }
 
    
    func getToken() -> Token {
        input.skip { $0.isSpace }
        
        let processor = getInputProcessor(for: input.peekChar())
        
        return processor.identifyToken(using: input)
    }
    
    func getInputProcessor(for character: Character) -> InputProcessor {
        if character.isAlpha {
            return AlphaProcessor()
        }
        
        
        
        fatalError("|\(character)|")
    }
    
}
