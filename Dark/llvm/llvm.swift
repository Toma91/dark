//
//  llvm.swift
//  Dark
//
//  Created by Andrea Tomarelli on 15/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

enum llvm { }

extension llvm {
    
    static func errs() -> raw_ostream { unimpl() }
    
}

struct raw_ostream {
    
    fileprivate init() { }
    
}

infix operator <<<: AdditionPrecedence

@discardableResult
func <<<(lhs: raw_ostream, rhs: Any) -> raw_ostream {
    unimpl()
}
