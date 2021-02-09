//
//  ParticlePacket.swift
//  Minecraft
//
//  Created by Rohan van Klinken on 9/2/21.
//

import Foundation

struct ParticlePacket: Packet {
  typealias PacketType = ParticlePacket
  static let id: Int = 0x23
  
  var particleId: Int32
  var isLongDistance: Bool
  var position: EntityPosition
  var offsetX: Float
  var offsetY: Float
  var offsetZ: Float
  var particleData: Float
  var particleCount: Int32

  init(fromReader packetReader: inout PacketReader) throws {
    particleId = packetReader.readInt()
    isLongDistance = packetReader.readBool()
    position = packetReader.readEntityPosition()
    offsetX = packetReader.readFloat()
    offsetY = packetReader.readFloat()
    offsetZ = packetReader.readFloat()
    particleData = packetReader.readFloat()
    particleCount = packetReader.readInt()
    
    // IMPLEMENT: there is also a data field but i really don't feel like decoding it rn
  }
}
