#import <UIKit/UIKit.h>
#include "420.h"

id CC(NSString *CMD) {
	return [NSString stringWithFormat:@"echo \"%@\" | gap",CMD];
}

int main(int argc, char *argv[]) {
	_420Manager *fix = [[_420Manager alloc] init];

	NSFileManager *fm = [[NSFileManager alloc] init];

	NSString *runCode = @"whoami";
	NSString *whoami = [fix RunCMDWithLog:runCode];

	runCode = @"killall Cydia;killall apt apt-get;rm -rf /var/log/apt;mkdir /var/log/apt;rm -f /var/lib/apt/lists/lock;rm -f /var/lib/dpkg/lock-frontend;rm -f /var/cache/apt/archives/lock;rm -f /var/lib/dpkg/lock;dpkg --configure -a >/dev/null 2>&1";

	if ([whoami isEqualToString:@"mobile\n"]){
		if ([fm fileExistsAtPath:@"/usr/bin/gap"]){
			runCode = [runCode stringByReplacingOccurrencesOfString:@"a >/dev/null 2>&1" withString:@"a"];
			runCode = CC(runCode);
		}else{
			printf("\n\nPLEASE RUN AS ROOT USER \n\n");
			exit(1);
		}
	} else {
		runCode = [runCode stringByReplacingOccurrencesOfString:@";" withString:@" >/dev/null 2>&1;"];
	}

	[fix RunCMD:runCode WaitUntilExit:YES];
	printf("Done ( ͡° ͜ʖ ͡°)\nPackage Managers should now work!\n");
	return 0;
}