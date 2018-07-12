//
//  main.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

import Foundation

print("Hello, World!")

func unimpl(function: String = #function) -> Never {
    fatalError("\(function): not implemented yet")
}


let code = """
func test(name: String) {
  let value = "Hello "
  print(value + name)
}
test(name: "Andrea")
"""
/*var _lexer = Lexer(buffer: code)

while let t = Optional(_lexer.getToken()), !t.isEof {
    print("*** got token:", t)
}*/

var l = Lexer(buffer: code)
print(l.currentToken)
l.lex()
print(l.currentToken)
//var p = Parser(lexer: l)
//try p.parseTopLevelExpression()






