//
//  Debugging.swift
//  Essentia
//
//  Created by Jason Cardwell on 11/12/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

extension OBJCDebuggingModule: CustomStringConvertible {

  /// A description for the specified module(s) as might appear in the header of a debug.
  /// log message.
  public var description: String {

    guard self != .none else { return "None" }
    guard self != .all  else { return "All"  }

    var modules: [String] = []

    if self.contains(.algorithm)  { modules.append("Algorithm")  }
    if self.contains(.connectors) { modules.append("Connectors") }
    if self.contains(.factory)    { modules.append("Factory")    }
    if self.contains(.network)    { modules.append("Network")    }
    if self.contains(.graph)      { modules.append("Graph")      }
    if self.contains(.execution)  { modules.append("Execution")  }
    if self.contains(.memory)     { modules.append("Memory")     }
    if self.contains(.scheduler)  { modules.append("Scheduler")  }
    if self.contains(.python)     { modules.append("Python")     }
    if self.contains(.pyBindings) { modules.append("PyBindings") }
    if self.contains(.unittest)   { modules.append("Unittest")   }
    if self.contains(.user1)      { modules.append("User1")      }
    if self.contains(.user2)      { modules.append("User2")      }

    guard !modules.isEmpty else { return "None" }

    return "[" + modules.joined(separator: ", ") + "]"

  }

}

extension DebuggingScheduleEvent: CustomStringConvertible {

  /// A description comprised of the event's start and stop indices and the affected modules.
  public var description: String {
    return "{start: \(start); stop: \(stop == CInt.max ? "never" : "\(stop)"); modules: \(modules)"
  }

}

extension DebuggingScheduleEvent: Equatable {

  /// Equality operator support for `Equatable`.
  ///
  /// - Parameters:
  ///   - lhs: The first of the two events.
  ///   - rhs: The second of the two events.
  /// - Returns: `true` if all event fields match and `false` otherwise.
  public static func ==(lhs: DebuggingScheduleEvent, rhs: DebuggingScheduleEvent) -> Bool {
    return lhs.start == rhs.start && lhs.stop == rhs.stop && lhs.modules == rhs.modules
  }

}

/// An enumeration for debugging/logging-related functionality.
public enum Log {

  /// The type used to specify a module.
  public typealias Module = OBJCDebuggingModule

  /// The type used to specify scheduled events.
  public typealias Event = DebuggingScheduleEvent

  /// The number of spaces that follow the header of a debug log statement.
  public static var indentLevel: Int {
    get { return Int(LoggerWrapper.indentLevel()) }
    set { LoggerWrapper.setIndentLevel(CInt(newValue)) }
  }

  /// The bitmask specifiying which debug modules have logging enabled.
  public static var activeModules: Module {
    get { return LoggerWrapper.activeModules() }
    set { LoggerWrapper.setActiveModules(newValue) }
  }

  /// The flag controlling 'info' level logging.
  public static var infoLevelActive: Bool {
    get { return LoggerWrapper.isInfoLevelActive() }
    set { LoggerWrapper.setInfoLevelActive(newValue) }
  }

  /// The flag controlling 'warning' level logging.
  public static var activateWarningLevel: Bool {
    get { return LoggerWrapper.isWarningLevelActive() }
    set { LoggerWrapper.setWarningLevelActive(newValue) }
  }

  /// The flag controlling 'error' level logging.
  public static var activateErrorLevel: Bool {
    get { return LoggerWrapper.isErrorLevelActive() }
    set { LoggerWrapper.setErrorLevelActive(newValue) }
  }

  /// Adds the specified modules to the set of debug modules with logging enabled.
  ///
  /// - Parameter modules: The set of modules to activate.
  public func activate(modules: Module) { LoggerWrapper.activate(modules) }

  /// Removes the specified modules from the set of debug modules with logging enabled.
  ///
  /// - Parameter modules: The set of modules to deactivate.
  public func deactivate(modules: Module) { LoggerWrapper.deactivate(modules) }

  /// Stores the currently active modules so they may later be restored.
  public static func saveActiveModules() { LoggerWrapper.saveActiveModules() }

  /// Resets the currenlty active modules using the previously saved value.
  public static func restoreSavedModules() { LoggerWrapper.restoreActiveModules() }

  /// Logs a message to `stderr` if the active modules include the specified module(s).
  ///
  /// - Parameters:
  ///   - modules: The module(s) for which `message` is relevant.
  ///   - message: The string to print to `stderr`.
  ///   - resetHeader: Boolean flag indicating whether the next debug logging invocation should
  ///                  start a fresh line with a new header.
  public static func debug(modules: Module, message: String, resetHeader: Bool = false) {
    LoggerWrapper.debug(modules, message: message, resetHeader: resetHeader)
  }

  /// Logs a message to `stderr` if 'info' level logging is active.
  ///
  /// - Parameter message: The message to print to `stderr`.
  public static func info(message: String) { LoggerWrapper.info(message) }

  /// Logs a message to `stderr` if 'warning' level logging is active.
  ///
  /// - Parameter message: The message to print to `stderr`.
  public static func warning(message: String) { LoggerWrapper.warning(message) }

  /// Logs a message to `stderr` if 'error' level logging is active.
  ///
  /// - Parameter message: The message to print to `stderr`.
  public static func error(message: String) { LoggerWrapper.error(message) }

  /// Schedules the enabling/disabling of module-specific logging as described by the specified
  /// array of event tuples.
  ///
  /// - Parameter events: The array of events to schedule.
  public static func scheduleDebug(events: [Event]) {
    LoggerWrapper.scheduleDebug(events.map(NSValue.init(event:)))
  }

  /// Activates modules for the specified time index as scheduled via `Log.scheduleDebug(events:)`.
  /// Any modules not currently stored via `Log.saveActiveModules()` will be deactivated.
  ///
  /// - Parameter timeIndex: The time index for which scheduled events with indices that include
  ///                        the index will have their associated modules activated.
  public static func activateScheduledModules(for timeIndex: Int) {
    LoggerWrapper.activateModules(forTime: CInt(timeIndex))
  }

  /// The array of currently scheduled events.
  public static var schedule: [Event] {
    return LoggerWrapper.schedule().map(\.eventValue)
  }

}

