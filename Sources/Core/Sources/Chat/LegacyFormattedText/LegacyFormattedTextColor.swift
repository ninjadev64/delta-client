extension LegacyFormattedText {
  /// A legacy text color formatting code.
  public enum Color: Character {
    case black = "0"
    case darkBlue = "1"
    case darkGreen = "2"
    case darkAqua = "3"
    case darkRed = "4"
    case darkPurple = "5"
    case gold = "6"
    case gray = "7"
    case darkGray = "8"
    case blue = "9"
    case green = "a"
    case aqua = "b"
    case red = "c"
    case lightPurple = "d"
    case yellow = "e"
    case white = "f"
    
    /// The hex value of the color.
    public var hex: String {
      switch self {
        case .black: return "#000000"
        case .darkBlue: return "#0000AA"
        case .darkGreen: return "#00AA00"
        case .darkAqua: return "#00AAAA"
        case .darkRed: return "#AA0000"
        case .darkPurple: return "#AA00AA"
        case .gold: return "#FFAA00"
        case .gray: return "#AAAAAA"
        case .darkGray: return "#555555"
        case .blue: return "#5555FF"
        case .green: return "#55FF55"
        case .aqua: return "#55FFFF"
        case .red: return "#FF5555"
        case .lightPurple: return "#FF55FF"
        case .yellow: return "#FFFF55"
        case .white: return "#FFFFFF"
      }
    }

    public var ansi: String {
      switch self {
        case .black: return "[0;30m"
        case .darkBlue: return "[0;34m"
        case .darkGreen: return "[0;32m"
        case .darkAqua: return "[0;36m"
        case .darkRed: return "[0;31m"
        case .darkPurple: return "[0;35m"
        case .gold: return "[0;33m"
        case .gray: return "[0;37m"
        case .darkGray: return "[0;90m"
        case .blue: return "[0;94m"
        case .green: return "[0;92m"
        case .aqua: return "[0;96m"
        case .red: return "[0;91m"
        case .lightPurple: return "[0;95m"
        case .yellow: return "[0;93m"
        case .white: return "[0;97m"
      }
    }
  }
}
