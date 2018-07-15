//
//  SMLoc.swift
//  Dark
//
//  Created by Andrea Tomarelli on 15/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

extension llvm {
    
    struct SMLoc {
        
        static func ==(lhs: SMLoc, rsh: SMLoc) -> Bool {
            unimpl()
        }
        
        static func getFromPointer(_ ptr: UnsafePointer<CChar>) -> SMLoc {
            unimpl()
        }
        
        func getPointer() -> UnsafePointer<CChar> {
            unimpl()
        }
        
        func isValid() -> Bool {
            unimpl()
        }
        
    }
    
}
