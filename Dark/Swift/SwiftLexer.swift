//
//  SwiftLexer.swift
//  Dark
//
//  Created by Andrea Tomarelli on 15/07/18.
//  Copyright © 2018 Weedea. All rights reserved.
//

class SourceLoc {

    private let value: llvm.SMLoc
 
    init() { self.value = llvm.SMLoc() }
    
    init(_ value: llvm.SMLoc) { self.value = value }
    
    func isValid() -> Bool { return value.isValid() }
    func isInvalid() -> Bool { return !isValid() }
    
    static func ==(lhs: SourceLoc, rhs: SourceLoc) -> Bool { return lhs.value == rhs.value }
    static func !=(lhs: SourceLoc, rhs: SourceLoc) -> Bool { return !(lhs.value == rhs.value) }

    func getAdvancedLoc(_ byteOffset: Int) -> SourceLoc {
        assert(isValid(), "Can't advance an invalid location")
        return SourceLoc(llvm.SMLoc.getFromPointer(value.getPointer() + byteOffset))
    }
    
    func getAdvancedLocOrInvalid(_ byteOffset: Int) -> SourceLoc {
        return isValid() ? getAdvancedLoc(byteOffset) : SourceLoc()
    }
    
    func getOpaquePointerValue() -> UnsafePointer<CChar> { return value.getPointer() }

    func print(_ OS: raw_ostream, _ SM: SourceManager, _ LastBufferID: inout UInt) {
        if (isInvalid()) {
            OS <<< "<invalid loc>"
            return
        }
        
        let bufferId = SM.findBufferContainingLoc(self)
        if (bufferId != LastBufferID) {
            OS <<< SM.getIdentifierForBuffer(bufferId)
            LastBufferID = bufferId
        } else {
            OS <<< "line"
        }
        
        let lineAndCol = SM.getLineAndColumn(self, bufferId)
        OS <<< ":" <<< lineAndCol.0 <<< ":" <<< lineAndCol.1
    }
    
    func printLineAndColumn(_ OS: raw_ostream, _ SM: SourceManager, _ BufferID: UInt = 0) {
        if (isInvalid()) {
            OS <<< "<invalid loc>"
            return
        }
        
        let lineAndCol = SM.getLineAndColumn(self, BufferID)
        OS <<< "line:" <<< lineAndCol.0 <<< ":" <<< lineAndCol.1
    }
    
    func print(_ OS: raw_ostream, _ SM: SourceManager) {
        var tmp: UInt = ~0
        print(OS, SM, &tmp)
    }
    
    func dump(_ SM: SourceManager) {
        print(llvm.errs(), SM)
    }
    
}


class SourceManager {

    func findBufferContainingLoc(_ loc: SourceLoc) -> UInt {
unimpl()
    }
    
    func getIdentifierForBuffer(_ bufferId: UInt) -> String {
unimpl()
    }
    
    func getLineAndColumn(_ loc: SourceLoc, _ bufferId: UInt = 0) -> (UInt, UInt) {
unimpl()
    }

}

class SwiftLexer {

    private let sourceMgr: SourceManager
    private let bufferID: UInt
    
    private var bufferStart: UnsafePointer<CChar>

    private var bufferEnd: UnsafePointer<CChar>

    init() {
        unimpl()
    }
    
    private func initialize(offset: UInt, endOffset: UInt) {
        assert(offset <= endOffset)
        

    }
    
}
