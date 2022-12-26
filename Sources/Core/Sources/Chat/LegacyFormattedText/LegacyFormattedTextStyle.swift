extension LegacyFormattedText {
  /// A legacy text style formatting code.
  public enum Style: Character {
    // case obfuscated = "k"
    case bold = "l"
    case strikethrough = "m"
    case underline = "n"
    case italic = "o"
    case reset = "r"

    public var ansi: String {
      switch self {
        // case .obfuscated: return "[8m"
        case .bold: return "[1m"
        case .strikethrough: return "[9m"
        case .underline: return "[4m"
        case .italic: return "[3m"
        case .reset: return "[0m"
      }
    }
  }
}
