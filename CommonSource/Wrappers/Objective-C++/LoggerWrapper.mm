//
//  LoggerWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 11/12/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "LoggerWrapper.h"
#import "debugging.h"
#import "NSValue+BridgingExtensions.h"

/**
 Casts the specified module to its C++ equivalent.

 @param module The module(s) to type cast.
 @return The equivalent of `module` as `essentia::DebuggingModule`.
 */
essentia::DebuggingModule convertModule(OBJCDebuggingModule module) {
  return (essentia::DebuggingModule)module;
}

@implementation LoggerWrapper

/**
 Logs a message to `stderr` if the active modules include the specified module(s).

 @param modules The module(s) for which `message` is relevant.
 @param message The string to print to `stderr`.
 */
+ (void)debug:(OBJCDebuggingModule)modules message:(NSString *)message {
  [self debug:modules message:message resetHeader:NO];
}

/**
 Logs a message to `stderr` if the active modules include the specified module(s).

 @param modules The module(s) for which `message` is relevant.
 @param message The string to print to `stderr`.
 @param resetHeader Boolean flag indicating whether the next debug logging invocation should
 start a fresh line with a new header.
 */
+ (void)debug:(OBJCDebuggingModule)modules
      message:(NSString *)message
  resetHeader:(BOOL)resetHeader
{

  essentia::loggerInstance.debug(convertModule(modules),
                                 [message cStringUsingEncoding:NSUTF8StringEncoding],
                                 (bool)resetHeader);

}

/**
 Logs a message to `stderr` if 'info' level logging is active.

 @param message The message to print to `stderr`.
 */
+ (void)info:(NSString *)message {
  essentia::loggerInstance.info([message cStringUsingEncoding:NSUTF8StringEncoding]);
}

/**
 Logs a message to `stderr` if 'warning' level logging is active.

 @param message The message to print to `stderr`.
 */
+ (void)warning:(NSString *)message {
  essentia::loggerInstance.warning([message cStringUsingEncoding:NSUTF8StringEncoding]);
}

/**
 Logs a message to `stderr` if 'error' level logging is active.

 @param message The message to print to `stderr`.
 */
+ (void)error:(NSString *)message {
  essentia::loggerInstance.error([message cStringUsingEncoding:NSUTF8StringEncoding]);
}

/**
 Accessor for the flag controlling 'info' level logging.

 @return `YES` if logging is enabled for 'info' level messages and `NO` otherwise.
 */
+ (BOOL)isInfoLevelActive { return (BOOL)essentia::infoLevelActive; }

/**
 Mutator for the flag controlling 'info' level logging.

 @param isActive `YES` to enable logging for 'info' level messages and `NO` to disable them.
 */
+ (void)setInfoLevelActive:(BOOL)isActive { essentia::infoLevelActive = (bool)isActive; }

/**
 Accessor for the flag controlling 'warning' level logging.

 @return `YES` if logging is enabled for 'warning' level messages and `NO` otherwise.
 */
+ (BOOL)isWarningLevelActive { return (BOOL)essentia::warningLevelActive; }

/**
 Mutator for the flag controlling 'warning' level logging.

 @param isActive `YES` to enable logging for 'warning' level messages and `NO` to disable them.
 */
+ (void)setWarningLevelActive:(BOOL)isActive { essentia::warningLevelActive = (bool)isActive; }

/**
 Accessor for the flag controlling 'error' level logging.

 @return `YES` if logging is enabled for 'error' level messages and `NO` otherwise.
 */
+ (BOOL)isErrorLevelActive { return (BOOL)essentia::errorLevelActive; }

/**
 Mutator for the flag controlling 'error' level logging.

 @param isActive `YES` to enable logging for 'error' level messages and `NO` to disable them.
 */
+ (void)setErrorLevelActive:(BOOL)isActive { essentia::errorLevelActive = (bool)isActive; }

/**
 Accessor for the bitmask specifiying which debug modules have logging enabled.

 @return The bitmask of active modules.
 */
+ (OBJCDebuggingModule)activeModules {
  return (OBJCDebuggingModule)essentia::activatedDebugLevels;
}

/**
 Mutator for the bitmask specifiying which debug modules have logging enabled.

 @param modules The bitmask of modules for which logging will be enabled.
 */
+ (void)setActiveModules:(OBJCDebuggingModule)modules {
  essentia::activatedDebugLevels = (int)modules;
}

/**
 Adds the specified modules to the set of debug modules with logging enabled.

 @param modules The bitmask of modules for which logging will be enabled.
 */
+ (void)activate:(OBJCDebuggingModule)modules { essentia::setDebugLevel(convertModule(modules)); }

/**
 Removes the specified modules from the set of debug modules with logging enabled.

 @param modules The bitmask of modules for which logging will be disabled.
 */
+ (void)deactivate:(OBJCDebuggingModule)modules {
  essentia::unsetDebugLevel(convertModule(modules));
}

/**
 Accessor for the number of spaces that follow the header of a debug log statement.

 @return The level of indentation currently in use.
 */
+ (int)indentLevel { return (int)essentia::debugIndentLevel; }

/**
 Mutator for the number of spaces that follow the header of a debug log statement.

 @param indentLevel The new indentation level.
 */
+ (void)setIndentLevel:(int)indentLevel { essentia::debugIndentLevel = (int)indentLevel; }

/**
 Stores the bitmask of modules for which logging is enabled so they may later be restored.
 */
+ (void)saveActiveModules { essentia::saveDebugLevels(); }

/**
 Resets the bitmask of modules for which logging is enabled to the previously saved value.
 */
+ (void)restoreActiveModules { essentia::restoreDebugLevels(); }

/**
 Schedules the enabling/disabling of module-specific logging as described by the specified
 array of schedule events.

 @param events The array of events to schedule wrapped inside instances of `NSValue`.
 */
+ (void)scheduleDebug:(NSArray<NSValue *> *)events {

  essentia::DebuggingScheduleVector schedule;

  for (NSValue *wrappedEvent in events) {
    DebuggingScheduleEvent event = wrappedEvent.eventValue;
    schedule.push_back({{(int)event.start, (int)event.stop}, convertModule(event.modules)});
  }

  essentia::scheduleDebug(schedule);

}

/**
 Activates modules for the specified time index as scheduled via `[LogWrapper scheduleDebug:]`.
 Any modules not currently stored via `[LogWrapper saveActiveModules]` will be deactivated.

 @param index The time index for which scheduled events with indices that include the index
 will have their associated modules activated.
 */
+ (void)activateModulesForTimeIndex:(int)index {
  essentia::setDebugLevelForTimeIndex((int)index);
}

/**
 Accessor for the array of events that have been scheduled via `[LogWrapper scheduleDebug:]` or
 through the C++ interface.

 @return The array of events wrapped inside instances of `NSValue`.
 */
+ (NSArray<NSValue *> *)schedule {

  NSMutableArray *result = [NSMutableArray new];

  for (auto event : essentia::debuggingSchedule()) {

    int start = event.first.first;
    int stop = event.first.second;
    OBJCDebuggingModule modules = (OBJCDebuggingModule)event.second;

    NSValue *wrappedEvent = [NSValue valueWithEvent:{start, stop, modules}];
    [result addObject:wrappedEvent];

  }

  return result;
  
}

@end
