//
//  PlayerPositionAndLookClientboundPacket.swift
//  DeltaCore
//
//  Created by Rohan van Klinken on 14/2/21.
//

import Foundation

public struct PlayerPositionAndLookClientboundPacket: ClientboundPacket {
  public static let id: Int = 0x35
  
  public var position: EntityPosition
  public var yaw: Float
  public var pitch: Float
  public var flags: PositionAndLookFlags
  public var teleportId: Int
  
  public struct PositionAndLookFlags: OptionSet {
    public let rawValue: UInt8
    
    public init(rawValue: UInt8) {
      self.rawValue = rawValue
    }
    
    public static let x = PositionAndLookFlags(rawValue: 0x01)
    public static let y = PositionAndLookFlags(rawValue: 0x02)
    public static let z = PositionAndLookFlags(rawValue: 0x04)
    public static let yRot = PositionAndLookFlags(rawValue: 0x08)
    public static let xRot = PositionAndLookFlags(rawValue: 0x10)
  }

  public init(from packetReader: inout PacketReader) throws {
    position = packetReader.readEntityPosition()
    yaw = packetReader.readFloat()
    pitch = packetReader.readFloat()
    flags = PositionAndLookFlags(rawValue: packetReader.readUnsignedByte())
    teleportId = packetReader.readVarInt()
  }
  
  public func handle(for client: Client) throws {
    let teleportConfirm = TeleportConfirmPacket(teleportId: teleportId)
    client.sendPacket(teleportConfirm)
    
    client.server?.player.update(with: self)
  }
}