//
//  Client.swift
//  DeltaClient
//
//  Created by Rohan van Klinken on 12/1/21.
//

import Foundation
import os

// pretty much the backend class for the whole game
class Client {
  var state: ClientState = .idle
  var server: Server
  
  var managers: Managers
  
  enum ClientState {
    case idle
    case initialising
    case connecting
    case play
  }
  
  init(managers: Managers, serverInfo: ServerInfo) {
    self.managers = managers
    
    self.server = Server(withInfo: serverInfo, managers: managers)
  }
  
  // TEMP
  func play() {
    server.login()
  }
  
  func runCommand(_ command: String) {
    let logger = Logger(subsystem: "Minecraft", category: "commands")
    logger.log("running command `\(command)`")
    let parts = command.split(separator: " ")
    if let command = parts.first {
      let options = parts.dropFirst().map {
        return String($0)
      }
      switch command {
        case "say":
          let message = options.joined(separator: " ")
          let packet = ChatMessageServerboundPacket(message: message)
          server.sendPacket(packet)
        case "swing":
          if options.count > 0 {
            if options.first == "offhand" {
              let packet = AnimationServerboundPacket(hand: .offHand)
              server.sendPacket(packet)
              Logger.log("swung off hand")
              return
            }
          }
          let packet = AnimationServerboundPacket(hand: .mainHand)
          server.sendPacket(packet)
          Logger.log("swung main hand")
        case "tablist":
          Logger.log("-- BEGIN TABLIST --")
          for playerInfo in server.tabList.players {
            Logger.log("[\(playerInfo.value.displayName?.toText() ?? playerInfo.value.name)] ping=\(playerInfo.value.ping)ms")
          }
          Logger.log("-- END TABLIST --")
        case "getblock":
          if options.count == 3 {
            guard
              let x = Int(options[0]),
              let y = Int(options[1]),
              let z = Int(options[2])
            else {
              Logger.log("x y z must be integers")
              return
            }
            let position = Position(x: x, y: y, z: z)
            let block = server.currentWorld?.getBlock(at: position) ?? 0
            Logger.log("block has state \(block)")
          } else {
            Logger.log("usage: getblock x y z")
          }
        default:
          Logger.log("invalid command")
      }
    }
  }
}
