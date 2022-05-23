#import <UIKit/UIKit.h>
#include "420.h"

static NSString *local(NSString *local, NSString *def){
	NSString *path = @"/Library/Application Support/aptFix";
	NSString *tPath;
	NSArray *languages = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
	NSArray *preferredLanguages = [NSLocale preferredLanguages];

	for (NSString *preferredLanguage in preferredLanguages){
		for (NSString *language in languages){
			if ([preferredLanguage hasPrefix:[language stringByReplacingOccurrencesOfString:@".lproj" withString:@""]]){
				tPath = [path stringByAppendingPathComponent:language];
				if ([[NSFileManager defaultManager] fileExistsAtPath:tPath]){
					path = tPath;
					return [[NSBundle bundleWithPath:path] localizedStringForKey:local value:def table:@"aptFix"];
				}
			}
		}
	}

	return def;//[[NSBundle bundleWithPath:path] localizedStringForKey:local value:def table:@"aptFix"];
}

id CC(NSString *CMD) {
	return [NSString stringWithFormat:@"echo \"%@\" | gap",CMD];
}

int main(int argc, char *argv[]) {
	_420Manager *fix = [[_420Manager alloc] init];
/*	NSLog(@"Shared container data:%@",[fix listFileAtPath:APP_GROUP_PATH]);

		exit(0);*/

	NSFileManager *fm = [[NSFileManager alloc] init];

	NSString *runCode = @"whoami";
	NSString *whoami = [fix RunCMDWithLog:runCode];

	runCode = @"killall Cydia;killall apt apt-get;rm -rf /var/log/apt;mkdir /var/log/apt;rm -f /var/lib/apt/lists/lock;rm -f /var/lib/dpkg/lock-frontend;rm -f /var/cache/apt/archives/lock;rm -f /var/lib/dpkg/lock;dpkg --configure -a >/dev/null 2>&1";

	if ([whoami isEqualToString:@"mobile\n"]){
		if ([fm fileExistsAtPath:@"/usr/bin/gap"]){
			runCode = [runCode stringByReplacingOccurrencesOfString:@"a >/dev/null 2>&1" withString:@"a"];
			runCode = CC(runCode);
		}else{
			printf("\n\n%s\n\n", local(@"RUN_ROOT", @"PLEASE RUN AS ROOT USER").UTF8String);
			exit(1);
		}
	} else {
		runCode = [runCode stringByReplacingOccurrencesOfString:@";" withString:@" >/dev/null 2>&1;"];
	}

	[fix RunCMD:runCode WaitUntilExit:YES];
	printf("%s ( ͡° ͜ʖ ͡°)\n%s!\n", local(@"DONE", @"Done").UTF8String, local(@"FINISH", @"Package Managers should now work").UTF8String);
	return 0;
}