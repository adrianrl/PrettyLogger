import Foundation

@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
public func fatal(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
    PrettyLogger.shared.fatal(message, category: category, privacy: privacy)
}

@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
public func error(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
    PrettyLogger.shared.error(message, category: category, privacy: privacy)
}

@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
public func warning(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
    PrettyLogger.shared.warning(message, category: category, privacy: privacy)
}

@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
public func info(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
    PrettyLogger.shared.info(message, category: category, privacy: privacy)
}

@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
public func debug(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
    PrettyLogger.shared.debug(message, category: category, privacy: privacy)
}

@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
public func trace(_ message: String, category: String? = nil, privacy: PrettyLoggerPrivacy = .auto) {
    PrettyLogger.shared.trace(message, category: category, privacy: privacy)
}

// MARK: - Deprecations

@available(*, deprecated, renamed: "fatal", message: "Use `fatal` to use the unified OS logger")
@discardableResult
public func logFatal(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
    return PrettyLogger.shared.logFatal(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

@available(*, deprecated, renamed: "error", message: "Use `error` to use the unified OS logger")
@discardableResult
public func logError(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
    return PrettyLogger.shared.logError(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

@available(*, deprecated, renamed: "warning", message: "Use `warning` to use the unified OS logger")
@discardableResult
public func logWarning(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
    return PrettyLogger.shared.logWarning(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

@available(*, deprecated, renamed: "info", message: "Use `info` to use the unified OS logger")
@discardableResult
public func logInfo(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
    return PrettyLogger.shared.logInfo(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

@available(*, deprecated, renamed: "debug", message: "Use `debug` to use the unified OS logger")
@discardableResult
public func logDebug(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
    return PrettyLogger.shared.logDebug(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}

@available(*, deprecated, renamed: "trace", message: "Use `trace` to use the unified OS logger")
@discardableResult
public func logTrace(_ items: Any..., separator: String? = nil, terminator: String? = nil, file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) -> String? {
    return PrettyLogger.shared.logTrace(items, separator: separator, terminator: terminator, file: file, line: line, column: column, function: function)
}
