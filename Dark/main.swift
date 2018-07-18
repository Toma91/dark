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

func t<Buffer: RandomAccessCollection>(buf: Buffer) where Buffer.Element == Character {
    
}

var s = ""

for i in 0 ..< 1_000_000_000 {
    s.append(Character(Unicode.Scalar(UInt8(i % 256))))
}

let d = Date()
let b = Array.init(s)
print(Date().timeIntervalSince(d))

t(buf: b)




//let _code = """
//func test(name: String) -> Void {
//}
//test(name: characterName)
//"""
//
//var dp = DarkParser(lexer: DarkLexer(buffer: _code))
//print(dp.parseTopLevelExpression())
//
//exit(0)
//
//
//
//
//let code = """
//func test(name: String) -> Void {
//    print(name)
//}
//test(name: characterName)
//"""
///*var _lexer = Lexer(buffer: code)
//
//while let t = Optional(_lexer.getToken()), !t.isEof {
//    print("*** got token:", t)
//}*/
//
//var l = Lexer(buffer: code)
//var p = Parser(lexer: l)
//try p.parseTopLevelExpression()







