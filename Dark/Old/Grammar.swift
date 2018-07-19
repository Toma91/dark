//
//  Grammar.swift
//  Dark
//
//  Created by Andrea Tomarelli on 11/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

enum Grammar {

    typealias PUNC_LBRACE = Void
    typealias PUNC_RBRACE = Void
    typealias PUNC_LPAREN = Void
    typealias PUNC_RPAREN = Void

    typealias PUNC_COMMA = Void
    typealias PUNC_COLON = Void

    typealias PUNC_ARROW = Void

    
    typealias KW_FUNC = Void

    
    enum ArgumentName {
    
        case _0(Identifier)
        
    }
    
    enum Declaration {
        
        case _0(FunctionDeclaration)
        
    }

    enum FunctionArgument {

        case _0(ArgumentName, PUNC_COLON, Type)

    }
    
    indirect enum FunctionArgumentList {
        
        case _0(FunctionArgument)
        case _1(FunctionArgument, PUNC_COMMA, FunctionArgumentList)
        
    }
    
    enum FunctionArguments {
        
        case _0(PUNC_LPAREN, PUNC_RPAREN)
        case _1(PUNC_LPAREN, FunctionArgumentList, PUNC_RPAREN)
        
    }
    
    enum FunctionBody {
    
        case _0(PUNC_LBRACE, PUNC_RBRACE)
        
    }
    
    enum FunctionDeclaration {
    
        case _0(KW_FUNC, FunctionName, FunctionSignature, FunctionBody)
        
    }
    
    enum FunctionName {
        
        case _0(Identifier)
        
    }
   
    enum FunctionSignature {
        
        case _0(FunctionArguments, PUNC_ARROW, Type)
        
    }
    
    enum Identifier { }
    
    enum TopLevelExpression {
        
        case _0([Declaration])

    }
    
    enum `Type` {
        
        case _0(Identifier)
        
    }
    
}
