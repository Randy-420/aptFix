#import <UIKit/UIKit.h>
#include "420.h"

int main(int argc, char *argv[]) {
	_420Manager *fix = [[_420Manager alloc] init];

	NSString *runCode = @"whoami";
	NSString *whoami = [fix RunCMDWithLog:runCode];
	BOOL root = ![whoami isEqualToString:@"mobile\n"];
	NSArray *packageManagers = @[@"Cydia", @"Zebra", @"Installer", @"Sileo", @"Saily", @"apt apt-get"];

	for (NSString *manager in packageManagers){
		runCode = [NSString stringWithFormat:@"killall %@ >/dev/null 2>&1", manager];
		runCode = [fix modifyCode:runCode root:root];
		[fix RunCMD:runCode WaitUntilExit:YES];
	}

	runCode = [fix modifyCode:@"rm -rf /var/log/apt;mkdir /var/log/apt;rm -f /var/lib/apt/lists/lock;rm -f /var/lib/dpkg/lock-frontend;rm -f /var/cache/apt/archives/lock;rm -f /var/lib/dpkg/lock;dpkg --configure -a >/dev/null 2>&1" root:root];

	[fix RunCMD:runCode WaitUntilExit:YES];
	NSPrintf(@"%@ ( ͡° ͜ʖ ͡°)\n%@!\n", localize(@"DONE"), localize(@"FINISH"));

	return 0;
}