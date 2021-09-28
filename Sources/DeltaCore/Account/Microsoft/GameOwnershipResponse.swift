//
//  GameOwnershipResponse.swift
//  DeltaCore
//
//  Created by Rohan van Klinken on 24/4/21.
//

import Foundation

public struct GameOwnershipResponse: Codable {
  public struct License: Codable {
    public var name: String
    public var signature: String
  }
  
  public var items: [License]
  public var signature: String
  public var keyId: String
}