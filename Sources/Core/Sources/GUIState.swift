public struct GUIState {
  /// Whether the HUD (health, hotbar, hunger, etc.) is visible or not.
  public var showHUD = true
  /// Whether the debug screen is visible or not.
  public var showDebugScreen = false
  /// Whether the inventory is open or not.
  public var showInventory = false

  /// The chat history including messages received from other players.
  public var chat = Chat()
  /// The current contents of the chat message input. Non-`nil` if and only if chat is open.
  public var messageInput: String?
  /// The message that the user was composing before they used the up arrow to replace it with
  /// a historical message. Allows users to return to their message by hitting the down arrow a
  /// sufficient number of times.
  public var stashedMessageInput: String?
  /// All messages that the player has sent.
  public var playerMessageHistory: [String] = []
  /// The index of the currently selected historical message (changed by using the up
  /// and down arrow keys while composing a chat message). Indexes into ``playerMessageHistory``.
  public var currentMessageIndex: Int?

  /// A small default size would cause more text wrapping and slow down game
  /// ticks (even if not rendering). Haven't measured, just a hunch. Renderers
  /// must set this value to their drawable size to ensure that mouse interaction
  /// functions correctly.
  public var drawableSize = Vec2i(2000, 2000)
  /// The scaling factor from true pixels to drawable pixels. Should be set by
  /// renderers so that mouse coordinates can be correctly converted to drawable
  /// coordinates by GUI code.
  public var drawableScalingFactor: Float = 1

  /// The cursor position in the message input. 0 is the end of the message,
  /// and the maximum value is the beginning of the message.
  public var messageInputCursor: Int = 0

  /// The chat input field cursor as an index into ``messageInput``.
  public var messageInputCursorIndex: String.Index {
    if let messageInput = messageInput {
      return messageInput.index(messageInput.endIndex, offsetBy: -messageInputCursor)
    } else {
      return "".endIndex
    }
  }

  /// Whether chat is open or not.
  public var showChat: Bool {
    return messageInput != nil
  }

  /// Whether the player is allowed to move, as opposed to being in a
  /// menu or having chat open.
  public var movementAllowed: Bool {
    return !showChat && !showInventory
  }
}
