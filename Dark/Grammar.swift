//
//  Grammar.swift
//  Dark
//
//  Created by Andrea Tomarelli on 11/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

postfix operator *

postfix func *(rhs: Any) { }

func Grammar() {
    var code_block: Any = "code_block"
    var declaration: Any = "declaration"
    var function_body: Any = "function_body"
    var function_declaration: Any = "function_declaration"
    var function_name: Any = "function_name"
    var function_result: Any = "function_result"
    var function_signature: Any = "function_signature"
    var identifier: Any = "identifier"
    var identifier_character: Any = "identifier_character"
    var identifier_head: Any = "identifier_head"
    var parameter: Any = "parameter"
    var parameter_clause: Any = "parameter_clause"
    var parameter_list: Any = "parameter_list"
    var parameter_name: Any = "parameter_name"
    var statement: Any = "statement"
    var top_level_declaration: Any = "top_level_declaration"
    var type: Any = "type"
    var type_annotation: Any = "type_annotation"

    
    code_block = [
        ["{", statement*, "}"]
    ]
    
    declaration = [
        function_declaration
    ]
    
    function_body = [
        code_block
    ]
    
    function_declaration = [
        ["func", function_name, function_signature, function_body]
    ]
    
    function_name = [
        identifier
    ]
    
    function_result = [
        ["->", type]
    ]
    
    function_signature = [
        [parameter_clause, function_result]
    ]
    
    identifier = [
        [identifier_head, identifier_character*]
    ]
    
    identifier_character = [
        "[a-z]",
        "[A-Z]",
        "[0-9]",
        "_"
    ]
    
    identifier_head = [
        "[a-z]",
        "[A-Z]",
        "_"
    ]
    
    parameter = [
        [parameter_name, type_annotation]
    ]
    
    parameter_clause = [
        ["(", ")"],
        ["(", parameter_list, ")"]
    ]
    
    parameter_name = [
        identifier
    ]
    
    parameter_list = [
        parameter,
        [parameter, ",", parameter_list]
    ]
    
    statement = [
        declaration
    ]
    
    top_level_declaration = [
        statement*
    ]
    
    type = [
        identifier
    ]
    
    type_annotation = [
        [":", type]
    ]
}
