//
//  ChunkSection.swift
//  Minecraft
//
//  Created by Rohan van Klinken on 13/1/21.
//

import Foundation

struct ChunkSection {
  var blocks: [UInt16]
  var blockCount: Int16
  
  init() { // used for empty chunks
    blocks = [UInt16](repeating: 0, count: 4096)
    blockCount = 0
  }
  
  init(blockIds: [UInt16], palette: [UInt16], blockCount: Int16) {
    self.blocks = blockIds
    if palette.count != 0 {
      self.blocks = self.blocks.map {
        if $0 >= palette.count {
          print("\($0) out of bounds for list of \(palette.count)")
        }
        return palette[Int($0)]
      }
    }
    self.blockCount = blockCount
  }
  
  func getBlockId(atX x: Int32, y: Int32, andZ z: Int32) -> UInt16 {
    let index = 256*y + 16*z + x
    let blockId = blocks[Int(index)]
    return blockId
  }
  
  mutating func setBlockId(atX x: Int32, y: Int32, andZ z: Int32, to state: UInt16) {
    if getBlockId(atX: x, y: y, andZ: z) == 0 {
      blockCount += 1
    }
    if state == 0 {
      blockCount -= 1
    }
    let index = 256*y + 16*z + x
    self.blocks[Int(index)] = state
  }
}
