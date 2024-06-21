import Foundation
import Combine
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

    internal func logFatal(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .fatal {
            return nil
        }
        return log(.fatal, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
    }

    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func fatal(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        let logger = if let category {
            Logger.custom(category)
        } else {
            Logger.default
        }

        switch privacy {
        case .auto:
            logger.fault("\(message)")
        case .public:
            logger.fault("\(message, privacy: .public)")
        case .private:
            logger.fault("\(message, privacy: .private)")
        }
    }

    internal func logError(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .error {
            return nil
        }
        return log(.error, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
    }

    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func error(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        let logger = if let category {
            Logger.custom(category)
        } else {
            Logger.default
        }

        switch privacy {
        case .auto:
            logger.error("\(message)")
        case .public:
            logger.error("\(message, privacy: .public)")
        case .private:
            logger.error("\(message, privacy: .private)")
        }
    }

    internal func logWarning(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .warn {
            return nil
        }
        return log(.warn, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
    }

    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func warning(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        let logger = if let category {
            Logger.custom(category)
        } else {
            Logger.default
        }

        switch privacy {
        case .auto:
            logger.warning("\(message)")
        case .public:
            logger.warning("\(message, privacy: .public)")
        case .private:
            logger.warning("\(message, privacy: .private)")
        }
    }

    internal func logInfo(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .info {
            return nil
        }
        return log(.info, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
    }

    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func info(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        let logger = if let category {
            Logger.custom(category)
        } else {
            Logger.default
        }

        switch privacy {
        case .auto:
            logger.info("\(message)")
        case .public:
            logger.info("\(message, privacy: .public)")
        case .private:
            logger.info("\(message, privacy: .private)")
        }
    }

    internal func logDebug(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .debug {
            return nil
        }
        return log(.debug, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
    }

    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func debug(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        let logger = if let category {
            Logger.custom(category)
        } else {
            Logger.default
        }

        switch privacy {
        case .auto:
            logger.debug("\(message)")
        case .public:
            logger.debug("\(message, privacy: .public)")
        case .private:
            logger.debug("\(message, privacy: .private)")
        }
    }

    internal func logTrace(_ items: [Any], separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
        if level < .trace {
            return nil
        }
        return log(.trace, items: items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
    }

    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func trace(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
        let logger = if let category {
            Logger.custom(category)
        } else {
            Logger.default
        }

        switch privacy {
        case .auto:
            logger.trace("\(message)")
        case .public:
            logger.trace("\(message, privacy: .public)")
        case .private:
            logger.trace("\(message, privacy: .private)")
        }
    }

    private func log(_ logLevel: PrettyLoggerLevel, items: [Any], separator: String?, terminator: String?, file: String, line: Int, column: Int, function: String, date: Date = Date()) -> String? {
        let separator = separator ?? self.separator
        let terminator = terminator ?? self.terminator

        let message = buildMessageForLogLevel(items, separator: separator)

        let stringToPrint = stringForCurrentStyle(logLevel: logLevel, message: message, terminator: terminator, file: file, line: line, column: column, function: function, date: date)
        print(stringToPrint, terminator: terminator)
        
        let output = PrettyLoggerOutput(level: logLevel,
                                        message: message,
                                        file: (file as NSString).lastPathComponent,
                                        line: line,
                                        column: column,
                                        formatted: stringToPrint)
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

    private func stringForCurrentStyle(logLevel: PrettyLoggerLevel, message: String, terminator: String, file: String, line: Int, column: Int, function: String, date: Date) -> String {
        let level = "\(logLevel.label)"

        let stringDate = "\(mFormatter.string(from: date))"
        let stringLocation = "[\((file as NSString).lastPathComponent):L\(line)]"
        return "\(stringDate) ◉ \(level) \(message) \(stringLocation)"
    }
}

@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
extension Logger {
    private static let subsytem = Bundle.main.bundleIdentifier!
    static let `default` = Logger(subsystem: subsytem, category: "default")

    static func custom(_ category: String) -> Self {
        .init(subsystem: subsytem, category: category)
    }
}
