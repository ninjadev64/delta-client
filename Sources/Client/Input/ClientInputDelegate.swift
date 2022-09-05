import SwiftUI
import DeltaCore

#if os(macOS)
import Carbon
#endif

final class ClientInputDelegate: InputDelegate {
  /// ``mouseSensitivity`` is multiplied by this factor before use.
  let sensitivityAdjustmentFactor: Float = 0.004

  var mouseSensitivity = ConfigManager.default.config.mouseSensitivity

  var client: Client

  @Binding var cursorCaptured: Bool
  var pressedKeys: Set<Key> = []

  init(for client: Client) {
    self.client = client

    // Use a dummy binding until `bind(_:)` is called.
    _cursorCaptured = Binding<Bool>(get: { true }, set: { _ in })
  }

  func bind(_ cursorCaptured: Binding<Bool>) {
    _cursorCaptured = cursorCaptured
  }

  func onKeyDown(_ key: Key, _ characters: [Character] = []) {
    pressedKeys.insert(key)
    client.press(key, characters)
  }

  func onKeyUp(_ key: Key) {
    pressedKeys.remove(key)
    client.release(key)
  }

  func onMouseMove(_ deltaX: Float, _ deltaY: Float) {
    let sensitivity = sensitivityAdjustmentFactor * mouseSensitivity
    client.moveMouse(sensitivity * deltaX, sensitivity * deltaY)
  }

  func onScroll(_ deltaY: Float) {
    let input: Input
    if deltaY > 0 {
      input = .nextSlot
    } else {
      input = .previousSlot
    }

    client.press(input)
    client.release(input)
  }

  func releaseCursor() {
    for key in pressedKeys {
      client.release(key)
    }

    pressedKeys = []

    #if os(macOS)
    if cursorCaptured {
      CGAssociateMouseAndMouseCursorPosition(1)
      NSCursor.unhide()
    }
    #endif
    cursorCaptured = false
  }

  func captureCursor() {
    #if os(macOS)
    if !cursorCaptured {
      CGAssociateMouseAndMouseCursorPosition(0)
      NSCursor.hide()
    }
    #endif
    cursorCaptured = true
  }
}
