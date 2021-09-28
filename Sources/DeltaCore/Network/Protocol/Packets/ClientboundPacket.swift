//
//  ClientboundPacket.swift
//  DeltaCore
//
//  Created by Rohan van Klinken on 12/12/20.
//

import Foundation

public enum ClientboundPacketError: LocalizedError {
  case invalidDifficulty
  case invalidGamemode
  case invalidServerId
  case invalidSkyLightMask
  case invalidBlockLightMask
  case disconnect(reason: String)
}

public protocol ClientboundPacket {
  static var id: Int { get }
  
  init(from packetReader: inout PacketReader) throws
  func handle(for client: Client) throws
  func handle(for pinger: Pinger) throws
}

extension ClientboundPacket {
  public func handle(for client: Client) {
    return
  }
  
  public func handle(for pinger: Pinger) {
    return
  }
}