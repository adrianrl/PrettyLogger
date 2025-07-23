import Combine
import Foundation
import OSLog

public class PrettyLogger {
    public static let shared = PrettyLogger()

    public var level: PrettyLoggerLevel = .all
    public var separator: String = " "
    public var terminator: String = "\n"
    public let output = PassthroughSubject<PrettyLoggerOutput, Never>()

    private let mFormatter = DateFormatter(dateFormat: "HH:mm:ss.SSS")

    internal init() {

    }

    // MARK: - Primary OSLog-based API

    public func logFatal(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        // Check level filtering
        if level < .fatal {
            return
        }

        let logger = createLogger(for: category)
        logWithPrivacy(logger: logger, level: .fault, message: message, privacy: privacy)

        // Send to output stream
        let output = PrettyLoggerOutput(level: .fatal, message: message)
        self.output.send(output)
    }

    public func logError(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        if level < .error {
            return
        }

        let logger = createLogger(for: category)
        logWithPrivacy(logger: logger, level: .error, message: message, privacy: privacy)

        // Send to output stream
        let output = PrettyLoggerOutput(level: .error, message: message)
        self.output.send(output)
    }

    public func logWarning(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        if level < .warn {
            return
        }

        let logger = createLogger(for: category)
        logWithPrivacy(logger: logger, level: .default, message: message, privacy: privacy)

        // Send to output stream
        let output = PrettyLoggerOutput(level: .warn, message: message)
        self.output.send(output)
    }

    public func logInfo(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        if level < .info {
            return
        }

        let logger = createLogger(for: category)
        logWithPrivacy(logger: logger, level: .info, message: message, privacy: privacy)

        // Send to output stream
        let output = PrettyLoggerOutput(level: .info, message: message)
        self.output.send(output)
    }

    public func logDebug(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        if level < .debug {
            return
        }

        let logger = createLogger(for: category)
        logWithPrivacy(logger: logger, level: .debug, message: message, privacy: privacy)

        // Send to output stream
        let output = PrettyLoggerOutput(level: .debug, message: message)
        self.output.send(output)
    }

    public func logTrace(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        if level < .trace {
            return
        }

        let logger = createLogger(for: category)
        logWithPrivacy(logger: logger, level: .debug, message: message, privacy: privacy)

        // Send to output stream
        let output = PrettyLoggerOutput(level: .trace, message: message)
        self.output.send(output)
    }

    // MARK: - Legacy print-based API (internal)

    internal func logFatalLegacy(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .fatal {
            return nil
        }
        return log(
            .fatal, items: items, separator: separator, terminator: terminator, file: file,
            line: line, column: column, function: function)
    }

    internal func logErrorLegacy(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .error {
            return nil
        }
        return log(
            .error, items: items, separator: separator, terminator: terminator, file: file,
            line: line, column: column, function: function)
    }

    internal func logWarningLegacy(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .warn {
            return nil
        }
        return log(
            .warn, items: items, separator: separator, terminator: terminator, file: file,
            line: line, column: column, function: function)
    }

    internal func logInfoLegacy(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .info {
            return nil
        }
        return log(
            .info, items: items, separator: separator, terminator: terminator, file: file,
            line: line, column: column, function: function)
    }

    internal func logDebugLegacy(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .debug {
            return nil
        }
        return log(
            .debug, items: items, separator: separator, terminator: terminator, file: file,
            line: line, column: column, function: function)
    }

    internal func logTraceLegacy(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .trace {
            return nil
        }
        return log(
            .trace, items: items, separator: separator, terminator: terminator, file: file,
            line: line, column: column, function: function)
    }

    // MARK: - Private helpers

    private func createLogger(for category: String?) -> Logger {
        let subsystem = Bundle.main.bundleIdentifier ?? "com.prettylogger.default"
        let categoryName = category ?? "default"
        return Logger(subsystem: subsystem, category: categoryName)
    }

    private func logWithPrivacy(
        logger: Logger, level: OSLogType, message: String, privacy: PrettyLoggerPrivacy
    ) {
        switch privacy {
        case .auto:
            logger.log(level: level, "\(message)")
        case .public:
            logger.log(level: level, "\(message, privacy: .public)")
        case .private:
            logger.log(level: level, "\(message, privacy: .private)")
        }
    }

    private func log(
        _ logLevel: PrettyLoggerLevel, items: [Any], separator: String?, terminator: String?,
        file: String, line: Int, column: Int, function: String, date: Date = Date()
    ) -> String? {
        let separator = separator ?? self.separator
        let terminator = terminator ?? self.terminator

        let message = buildMessageForLogLevel(items, separator: separator)

        let stringToPrint = stringForCurrentStyle(
            logLevel: logLevel, message: message, terminator: terminator, file: file, line: line,
            column: column, function: function, date: date)
        print(stringToPrint, terminator: terminator)

        let output = PrettyLoggerOutput(
            level: logLevel,
            message: message,
            file: (file as NSString).lastPathComponent,
            line: line,
            column: column,
            formatted: stringToPrint
        )
        self.output.send(output)

        return stringToPrint
    }

    private func buildMessageForLogLevel(_ items: [Any], separator: String) -> String {
        var message = ""

        for (index, item) in items.enumerated() {
            message += String(describing: item) + (index == items.count - 1 ? "" : separator)
        }

        return message
    }

    private func stringForCurrentStyle(
        logLevel: PrettyLoggerLevel, message: String, terminator: String, file: String, line: Int,
        column: Int, function: String, date: Date
    ) -> String {
        let level = "\(logLevel.label)"

        let stringDate = "\(mFormatter.string(from: date))"
        let stringLocation = "[\((file as NSString).lastPathComponent):L\(line)]"
        return "\(stringDate) ◉ \(level) \(message) \(stringLocation)"
    }
}
