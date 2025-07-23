import Foundation

public struct PrettyLoggerOutput: Equatable {
    public let level: PrettyLoggerLevel
    public let message: String
    public let file: String?
    public let line: Int?
    public let column: Int?
    public let formatted: String?

    // Convenience initializer for OSLog API (no file/line info)
    public init(level: PrettyLoggerLevel, message: String) {
        self.level = level
        self.message = message
        self.file = nil
        self.line = nil
        self.column = nil
        self.formatted = nil
    }

    // Full initializer for legacy API (with file/line info)
    public init(
        level: PrettyLoggerLevel,
        message: String,
        file: String,
        line: Int,
        column: Int,
        formatted: String
    ) {
        self.level = level
        self.message = message
        self.file = file
        self.line = line
        self.column = column
        self.formatted = formatted
    }
}
