//
//  AccountManager.swift
//  DeltaClient
//
//  Created by Rohan van Klinken on 6/4/21.
//

import Foundation
import os

class AccountManager {
  func test() {
    MojangAPI.login("username", "password") { response in
      Logger.log("successfully authenticated: \(response)")
    }
  }
}