//
//  Identifier.swift
//  Dark
//
//  Created by Andrea Tomarelli on 13/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

struct Identifier {
    
    let identifier: String
    
}

extension Identifier {
    
    init(_ identifier: String) {
        self.identifier = identifier
    }
    
}

extension Identifier: Token { }
