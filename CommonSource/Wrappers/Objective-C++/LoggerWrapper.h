//
//  LoggerWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 11/12/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>

/**
 An enumeration mimicking the C++ enumeration `DebuggingModule`.
 */
typedef NS_OPTIONS(int, OBJCDebuggingModule) {
  OBJCDebuggingModuleAlgorithm   = 1 << 0,
  OBJCDebuggingModuleConnectors  = 1 << 1,
  OBJCDebuggingModuleFactory     = 1 << 2,
  OBJCDebuggingModuleNetwork     = 1 << 3,
  OBJCDebuggingModuleGraph       = 1 << 4,
  OBJCDebuggingModuleExecution   = 1 << 5,
  OBJCDebuggingModuleMemory      = 1 << 6,  // for mem operations, such as new/delete
  OBJCDebuggingModuleScheduler   = 1 << 7,

  OBJCDebuggingModulePython      = 1 << 20, // for use in python scripts
  OBJCDebuggingModulePyBindings  = 1 << 21, // for use in python/C module
  OBJCDebuggingModuleUnittest    = 1 << 22,

  OBJCDebuggingModuleUser1       = 1 << 25, // freely available for the user
  OBJCDebuggingModuleUser2       = 1 << 26, // freely available for the user

  OBJCDebuggingModuleNone        = 0,
  OBJCDebuggingModuleAll         = (1 << 30) - 1
};

NS_ASSUME_NONNULL_BEGIN

/**
 A structure for specifying a period of time during which a set of modules will have logging
 enabled. An array of `DebuggingScheduleEvent` instances may be passed to `LoggerWrapper` to
 automate module-specific logging.

 Example:
 @code
 [LoggerWrapper scheduleDebug:@[

   // Always active.
   [NSValue
     valueWithEvent: { 0, INT_MAX, OBJCDebuggingModuleAlgorithm }]

   // From time index 500 until the end.
   [NSValue
     valueWithEvent: { 500, INT_MAX, OBJCDebuggingModuleNetwork|OBJCDebuggingModuleMemory }]

   // Only for time index 782.
   [NSValue
     valueWithEvent: { 782, 782, OBJCDebuggingModuleScheduler }]

 ]];
 @endcode

 @field start The time index at which logging should be enabled for `modules`.
 @field stop The time index at which logging should be disabled for `modules`.
 @field modules The bitmask of debug modules to be automated.
 */
typedef struct _DebuggingScheduleEvent {
  int start;
  int stop;
  OBJCDebuggingModule modules;
} DebuggingScheduleEvent;

/**
 A class composed entirely of class methods that serve as an interface for the current
 global instance of the C++ `Logger`.
 */
@interface LoggerWrapper : NSObject

/**
 Logs a message to `stderr` if the active modules include the specified module(s).

 @param modules The module(s) for which `message` is relevant.
 @param message The string to print to `stderr`.
 */
+ (void)debug:(OBJCDebuggingModule)modules message:(NSString *)message;

/**
 Logs a message to `stderr` if the active modules include the specified module(s).

 @param modules The module(s) for which `message` is relevant.
 @param message The string to print to `stderr`.
 @param resetHeader Boolean flag indicating whether the next debug logging invocation should
                    start a fresh line with a new header.
 */
+ (void)debug:(OBJCDebuggingModule)modules
      message:(NSString *)message
  resetHeader:(BOOL)resetHeader;

/**
 Logs a message to `stderr` if 'info' level logging is active.

 @param message The message to print to `stderr`.
 */
+ (void)info:(NSString *)message;

/**
 Logs a message to `stderr` if 'warning' level logging is active.

 @param message The message to print to `stderr`.
 */
+ (void)warning:(NSString *)message;

/**
 Logs a message to `stderr` if 'error' level logging is active.

 @param message The message to print to `stderr`.
 */
+ (void)error:(NSString *)message;

/**
 Accessor for the flag controlling 'info' level logging.

 @return `YES` if logging is enabled for 'info' level messages and `NO` otherwise.
 */
+ (BOOL)isInfoLevelActive;

/**
 Mutator for the flag controlling 'info' level logging.

 @param isActive `YES` to enable logging for 'info' level messages and `NO` to disable them.
 */
+ (void)setInfoLevelActive:(BOOL)isActive;

/**
 Accessor for the flag controlling 'warning' level logging.

 @return `YES` if logging is enabled for 'warning' level messages and `NO` otherwise.
 */
+ (BOOL)isWarningLevelActive;

/**
 Mutator for the flag controlling 'warning' level logging.

 @param isActive `YES` to enable logging for 'warning' level messages and `NO` to disable them.
 */
+ (void)setWarningLevelActive:(BOOL)isActive;

/**
 Accessor for the flag controlling 'error' level logging.

 @return `YES` if logging is enabled for 'error' level messages and `NO` otherwise.
 */
+ (BOOL)isErrorLevelActive;

/**
 Mutator for the flag controlling 'error' level logging.

 @param isActive `YES` to enable logging for 'error' level messages and `NO` to disable them.
 */
+ (void)setErrorLevelActive:(BOOL)isActive;

/**
 Accessor for the bitmask specifiying which debug modules have logging enabled.

 @return The bitmask of active modules.
 */
+ (OBJCDebuggingModule)activeModules;

/**
 Mutator for the bitmask specifiying which debug modules have logging enabled.

 @param modules The bitmask of modules for which logging will be enabled.
 */
+ (void)setActiveModules:(OBJCDebuggingModule)modules;

/**
 Adds the specified modules to the set of debug modules with logging enabled.

 @param modules The bitmask of modules for which logging will be enabled.
 */
+ (void)activate:(OBJCDebuggingModule)modules;

/**
 Removes the specified modules from the set of debug modules with logging enabled.

 @param modules The bitmask of modules for which logging will be disabled.
 */
+ (void)deactivate:(OBJCDebuggingModule)modules;

/**
 Accessor for the number of spaces that follow the header of a debug log statement.

 @return The level of indentation currently in use.
 */
+ (int)indentLevel;

/**
 Mutator for the number of spaces that follow the header of a debug log statement.

 @param indentLevel The new indentation level.
 */
+ (void)setIndentLevel:(int)indentLevel;

/**
 Stores the bitmask of modules for which logging is enabled so they may later be restored.
 */
+ (void)saveActiveModules;

/**
 Resets the bitmask of modules for which logging is enabled to the previously saved value.
 */
+ (void)restoreActiveModules;

/**
 Schedules the enabling/disabling of module-specific logging as described by the specified
 array of schedule events.

 @param events The array of events to schedule wrapped inside instances of `NSValue`.
 */
+ (void)scheduleDebug:(NSArray<NSValue *> *)events;

/**
 Activates modules for the specified time index as scheduled via `[LogWrapper scheduleDebug:]`.
 Any modules not currently stored via `[LogWrapper saveActiveModules]` will be deactivated.

 @param index The time index for which scheduled events with indices that include the index
              will have their associated modules activated.
 */
+ (void)activateModulesForTimeIndex:(int)index;

/**
 Accessor for the array of events that have been scheduled via `[LogWrapper scheduleDebug:]` or
 through the C++ interface.

 @return The array of events wrapped inside instances of `NSValue`.
 */
+ (NSArray<NSValue *> *)schedule;

@end

NS_ASSUME_NONNULL_END
