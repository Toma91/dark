//
//  Punctuator.swift
//  Dark
//
//  Created by Andrea Tomarelli on 13/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

enum Punctuator {
    
    case lParen     // (
    case rParen     // )
    case lBrace     // {
    case rBrace     // }

    case comma      // ,    
    case colon      // :
    
    case arrow      // ->
    
}

extension Punctuator: Token { }
