//
//  Grammar.swift
//  Dark
//
//  Created by Andrea Tomarelli on 11/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

enum Grammar {

    typealias CHAR_UNDERSCORE = Void
    
    
    typealias PUNC_EQUAL = Void
    typealias PUNC_DOUBLE_QUOTE = Void

    
    enum AssignmentExpression {
        
    }
    
    enum DecimalDigit: String {
        
        case _0 = "Numbers 0 ... 9"
        
    }
    
    enum DecimalLiteralCharacter {
        
        case _0(DecimalDigit)
        case _1(CHAR_UNDERSCORE)
        
    }
    
    enum Declaration {
        
        case _0(FunctionDeclaration)
        
    }

    enum Expression {
        
        case _0(AssignmentExpression)
        case _1(FunctionCallExpression)
        case _2(PrimaryExpression)

    }

    enum FunctionCallExpression {
        
    }
    
    enum FunctionDeclaration {
        
    }
    
    enum Identifier {
        
        case _0(IdentifierHead, [IdentifierCharacter])
        
    }
    
    enum IdentifierCharacter: String {
        
        case _0 = "a ... z"
        case _1 = "A ... Z"
        case _2 = "0 ... 9"
        case _3 = "_"
        
    }
    
    enum IdentifierHead: String {
        
        case _0 = "a ... z"
        case _1 = "A ... Z"
        case _3 = "_"
        
    }
    
    enum IntegerLiteral {
        
        case _0(DecimalDigit, [DecimalLiteralCharacter])
        
    }
    
    enum Literal {
        
        case _0(StringLiteral)
        case _1(IntegerLiteral)

    }
    
    enum PrimaryExpression {
        
        case _0(Literal)
        
    }
    
    enum StringLiteral {
        
        case _0(PUNC_DOUBLE_QUOTE, [StringLiteralCharacter], PUNC_DOUBLE_QUOTE)
        
    }
    
    enum StringLiteralCharacter: String {

        case _0 = "Almost any character (no new line, no unescaped characters, ...)"
        case _1 = "\\"
        case _2 = "\""

    }
    
    enum TopLevelExpression {
        
        case _0(Declaration)
        case _1(Expression)

    }
    
    
    
//
//
//
//
//
//
//    typealias KW_FUNC = Void
//    typealias KW_STRUCT = Void
//    typealias KW_LET = Void
//
//
//    typealias PUNC_LPAREN = Void
//    typealias PUNC_RPAREN = Void
//    typealias PUNC_LBRACE = Void
//    typealias PUNC_RBRACE = Void
//
//    typealias PUNC_COMMA = Void
//    typealias PUNC_COLON = Void
//
//    typealias PUNC_ARROW = Void
//
//
//    enum CodeBlock {
//
//        case _0(PUNC_LBRACE, [Statement], PUNC_RBRACE)
//
//    }
//
//    enum ConstantDeclaration {
//
//        case _0(KW_LET, Identifier, TypeAnnotation?)
//
//    }
//
//    enum Declaration {
//
//        case _0(FunctionDeclaration)
//        case _1(StructDeclaration)
//        case _2(ConstantDeclaration)
//
//    }
//
//    enum FunctionBody {
//
//        case _0(CodeBlock)
//
//    }
//
//    enum FunctionDeclaration {
//
//        case _0(KW_FUNC, FunctionName, FunctionSignature, FunctionBody)
//
//    }
//
//    enum FunctionName {
//
//        case _0(Identifier)
//
//    }
//
//    enum FunctionResult {
//
//        case _0(PUNC_ARROW, Type)
//
//    }
//
//    enum FunctionSignature {
//
//        case _0(ParameterClause, FunctionResult?)
//
//    }
//
//    enum Identifier {
//
//        case _0(IdentifierHead, [IdentifierCharacter])
//
//    }
//
//    enum IdentifierCharacter: String {
//
//        case _0 = "a ... z"
//        case _1 = "A ... Z"
//        case _2 = "0 ... 9"
//        case _3 = "_"
//
//    }
//
//    enum IdentifierHead: String {
//
//        case _0 = "a ... z"
//        case _1 = "A ... Z"
//        case _3 = "_"
//
//    }
//
//    enum Parameter {
//
//        case _0(ParameterName, TypeAnnotation)
//
//    }
//
//    enum ParameterClause {
//
//        case _0(PUNC_LPAREN, ParameterList?, PUNC_RPAREN)
//
//    }
//
//    indirect enum ParameterList {
//
//        case _0(Parameter)
//        case _1(Parameter, PUNC_COMMA, ParameterList)
//
//    }
//
//    enum ParameterName {
//
//        case _0(Identifier)
//
//    }
//
//    enum Statement {
//
//        case _0(Declaration)
//
//    }
//
//    enum StructBody {
//
//        case _0(PUNC_LBRACE, [StructMember], PUNC_RBRACE)
//
//    }
//
//    enum StructDeclaration {
//
//        case _0(KW_STRUCT, StructName, StructBody)
//
//    }
//
//    enum StructMember {
//
//        case _0(Declaration)
//
//    }
//
//    enum StructName {
//
//        case _0(Identifier)
//
//    }
//
//    enum TopLevelDeclaration {
//
//        case _0([Statement])
//
//    }
//
//    enum `Type` {
//
//        case _0(TypeIdentifier)
//
//    }
//
//    enum TypeAnnotation {
//
//        case _0(PUNC_COLON, Type)
//
//    }
//
//    enum TypeIdentifier {
//
//        case _0(Identifier)
//
//    }
    
    
    
    
    
    //postfix operator *
    //
    //postfix func *(rhs: Any) { }
    //
    //func Grammar() {
    //    var code_block: Any = "code_block"
    //
    //    var declaration: Any = "declaration"
    //
    //    var expression: Any = "expression"
    //    var function_call_expression: Any = "function_call_expression"
    //    var function_call_argument: Any = "function_call_argument"
    //    var function_call_argument_list: Any = "function_call_argument_list"
    //    var function_call_arguments_clause: Any = "function_call_arguments_clause"
    //
    //    var function_body: Any = "function_body"
    //    var function_declaration: Any = "function_declaration"
    //    var function_name: Any = "function_name"
    //    var function_result: Any = "function_result"
    //    var function_signature: Any = "function_signature"
    //
    //    var identifier: Any = "identifier"
    //    var identifier_character: Any = "identifier_character"
    //    var identifier_head: Any = "identifier_head"
    //
    //    var parameter: Any = "parameter"
    //    var parameter_clause: Any = "parameter_clause"
    //    var parameter_list: Any = "parameter_list"
    //    var parameter_name: Any = "parameter_name"
    //
    //    var statement: Any = "statement"
    //
    //    var struct_body: Any = "struct_body"
    //    var struct_declaration: Any = "struct_declaration"
    //    var struct_member: Any = "struct_member"
    //    var struct_name: Any = "struct_name"
    //
    //    var top_level_declaration: Any = "top_level_declaration"
    //
    //    var type: Any = "type"
    //    var type_annotation: Any = "type_annotation"
    //
    //
    //    code_block = [
    //        ["{", statement*, "}"]
    //    ]
    //
    //    declaration = [
    //        function_declaration,
    //        struct_declaration
    //    ]
    //
    //    expression = [
    //        function_call_expression
    //    ]
    //
    //    function_body = [
    //        code_block
    //    ]
    //
    //    function_call_argument = [
    //        expression,
    //        [identifier, ":", expression]
    //    ]
    //
    //    function_call_argument_list = [
    //        function_call_argument,
    //        [function_call_argument, ",", function_call_argument_list]
    //    ]
    //
    //    function_call_arguments_clause = [
    //        ["(", ")"],
    //        ["(", function_call_argument_list, ")"]
    //    ]
    //
    //    function_call_expression = [
    //        [expression, function_call_arguments_clause]
    //    ]
    //
    //    function_declaration = [
    //        ["func", function_name, function_signature, function_body]
    //    ]
    //
    //    function_name = [
    //        identifier
    //    ]
    //
    //    function_result = [
    //        ["->", type]
    //    ]
    //
    //    function_signature = [
    //        [parameter_clause, function_result]
    //    ]
    //
    //    identifier = [
    //        [identifier_head, identifier_character*]
    //    ]
    //
    //    identifier_character = [
    //        "[a-z]",
    //        "[A-Z]",
    //        "[0-9]",
    //        "_"
    //    ]
    //
    //    identifier_head = [
    //        "[a-z]",
    //        "[A-Z]",
    //        "_"
    //    ]
    //
    //    parameter = [
    //        [parameter_name, type_annotation]
    //    ]
    //
    //    parameter_clause = [
    //        ["(", ")"],
    //        ["(", parameter_list, ")"]
    //    ]
    //
    //    parameter_name = [
    //        identifier
    //    ]
    //
    //    parameter_list = [
    //        parameter,
    //        [parameter, ",", parameter_list]
    //    ]
    //
    //    statement = [
    //        declaration,
    //        expression
    //    ]
    //
    //    struct_body = [
    //        ["{", struct_member*, "}"]
    //    ]
    //
    //    struct_declaration = [
    //        ["struct", struct_name, struct_body]
    //    ]
    //
    //    struct_member = [
    //        declaration
    //    ]
    //
    //    struct_name = [
    //        identifier
    //    ]
    //
    //    top_level_declaration = [
    //        statement*
    //    ]
    //
    //    type = [
    //        identifier
    //    ]
    //
    //    type_annotation = [
    //        [":", type]
    //    ]
    //
    //    print(top_level_declaration)
    //}
}

