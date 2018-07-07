//
//  FileLexerInput.swift
//  Dark
//
//  Created by Andrea Tomarelli on 28/06/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

import Darwin

private class File {
    
    let handle: UnsafeMutablePointer<FILE>
    
    init?(path: String) {
        guard let handle = fopen(path, "r") else {
            return nil
        }
        
        self.handle = handle
    }
    
    deinit {
        fclose(handle)
    }
    
}

struct FileLexerInput: LexerInput {
    
    private let file: File
    
    init?(path: String) {
        guard let file = File(path: path) else {
            return nil
        }
        
        self.file = file
    }
    
    func peekChar() -> Character {
        var result: Character = "\0"
        
        guard fread(&result, 1, 1, file.handle) == 1 else {
            fatalError()
        }
        
        return result
    }
    
    func skip(while predicate: (Character) -> Bool) {
        
    }
    
}
