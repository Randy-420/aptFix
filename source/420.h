#import <Foundation/Foundation.h>
#include <spawn.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface UIDevice ()
- (id)_deviceInfoForKey:(NSString *)key;  
@end

@interface _420Manager : NSObject
//-(instancetype)initWithName:(NSString *)name;
-(void) RunCMD:(NSString *)RunCMD WaitUntilExit:(BOOL)WaitUntilExit;
-(NSString *) RunCMDWithLog:(NSString *)RunCMDWithLog;
-(NSString*) modifyCode:(NSString *)code root:(BOOL)root;
@end

// NSTask.h
//#import <Foundation/NSObject.h>

//@class NSString, NSArray, NSDictionary;

@interface NSTask : NSObject

// Create an NSTask which can be run at a later time
// An NSTask can only be run once. Subsequent attempts to
// run an NSTask will raise.
// Upon task death a notification will be sent
//   { Name = NSTaskDidTerminateNotification; object = task; }
//

- (instancetype)init;

// set parameters
// these methods can only be done before a launch
- (void)setLaunchPath:(NSString *)path;
- (void)setArguments:(NSArray *)arguments;
- (void)setEnvironment:(NSDictionary *)dict;
// if not set, use current
- (void)setCurrentDirectoryPath:(NSString *)path;
// if not set, use current

// set standard I/O channels; may be either an NSFileHandle or an NSPipe
- (void)setStandardInput:(id)input;
- (void)setStandardOutput:(id)output;
- (void)setStandardError:(id)error;

// get parameters
- (NSString *)launchPath;
- (NSArray *)arguments;
- (NSDictionary *)environment;
- (NSString *)currentDirectoryPath;

// get standard I/O channels; could be either an NSFileHandle or an NSPipe
- (id)standardInput;
- (id)standardOutput;
- (id)standardError;

// actions
- (void)launch;

- (void)interrupt; // Not always possible. Sends SIGINT.
- (void)terminate; // Not always possible. Sends SIGTERM.

- (BOOL)suspend;
- (BOOL)resume;

// status
- (int)processIdentifier;
- (BOOL)isRunning;

- (int)terminationStatus;

@end

@interface NSTask (NSTaskConveniences)

+ (NSTask *)launchedTaskWithLaunchPath:(NSString *)path arguments:(NSArray *)arguments;
// convenience; create and launch

- (void)waitUntilExit;
// poll the runLoop in defaultMode until task completes

@end

#define LOCALIZE_1(a) LOCALIZE_2(a, @"aptFix")
#define LOCALIZE_2(a, b) NSLocalizedStringWithDefaultValue(a, b, [NSBundle bundleWithPath:@"/Library/Application Support/aptFix"], nil, nil)
#define FUNC_CHOOSER(_f1, _f2, _f3, ...) _f3
#define FUNC_RECOMPOSER(argsWithParentheses) FUNC_CHOOSER argsWithParentheses
#define CHOOSE_FROM_ARG_COUNT(...) FUNC_RECOMPOSER((__VA_ARGS__, LOCALIZE_2, LOCALIZE_1))
#define MACRO_CHOOSER(...) CHOOSE_FROM_ARG_COUNT(__VA_ARGS__ ())
#define localize(...) MACRO_CHOOSER(__VA_ARGS__)(__VA_ARGS__)
#define NSPrintf(...) printf("%s", [[NSString stringWithFormat: __VA_ARGS__] UTF8String])

FOUNDATION_EXPORT NSString * const NSTaskDidTerminateNotification;