//
//  main.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

import Foundation

print("Hello, World!")


let code = """
func test(name: String) {
  let value = "Hello "
  print(value + name)
}
test(name: "Andrea")
"""
var _lexer = Lexer(input: code)

while let t = Optional(_lexer.getToken()), !t.isEof {
    print("*** got token:", t)
}










