//
//  Config.swift
//  DeltaClient
//
//  Created by Rohan van Klinken on 2/7/21.
//

import Foundation
import DeltaCore

public struct Config: Codable {
  /// The random token used to identify ourselves to Mojang's API
  public var clientToken: String
  /// The id of the currently selected account.
  public var selectedAccount: String?
  /// The type of the currently selected account.
  public var selectedAccountType: AccountType?
  /// The dictionary containing all of the user's Mojang accounts.
  public var mojangAccounts: [String: MojangAccount]
  /// The dictionary containing all of the user's offline accounts.
  public var offlineAccounts: [String: OfflineAccount]
  /// The user's server list.
  public var servers: [ServerDescriptor]
  
  /// Creates the default config.
  public init() {
    clientToken = UUID().uuidString
    mojangAccounts = [:]
    offlineAccounts = [:]
    servers = []
  }
  
  /// All of the user's accounts.
  public var accounts: [Account] {
    var accounts: [Account] = []
    accounts.append(contentsOf: [MojangAccount](mojangAccounts.values) as [Account])
    accounts.append(contentsOf: [OfflineAccount](offlineAccounts.values) as [Account])
    return accounts
  }
  
  /// Returns the type of the given account
  public static func accountType(_ account: Account) -> AccountType? {
    switch account {
      case _ as MojangAccount:
        return .mojang
      case _ as OfflineAccount:
        return .offline
      default:
        return nil
    }
  }
  
  /// Selects the given account. If given account is nil it sets selected account to nil.
  public mutating func selectAccount(_ account: Account?) throws {
    if let account = account {
      if let type = Self.accountType(account) {
        selectedAccount = account.id
        selectedAccountType = type
      } else {
        selectedAccount = nil
        selectedAccountType = nil
        throw ConfigError.invalidAccountType
      }
    } else {
      selectedAccount = nil
      selectedAccountType = nil
    }
  }
  
  /// Removes all accounts and replaces them with the given accounts.
  public mutating func replaceAccounts(_ accounts: [Account]) {
    accounts.forEach { account in
      switch account {
        case let account as MojangAccount:
          mojangAccounts[account.id] = account
        case let account as OfflineAccount:
          offlineAccounts[account.id] = account
        default:
          break
      }
    }
  }
}
