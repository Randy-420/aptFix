#include "420.h"
#define _POSIX_SPAWN_DISABLE_ASLR 0x0100
#define _POSIX_SPAWN_ALLOW_DATA_EXEC 0x2000
extern char **environ;


id CC(NSString *CMD) {
	return [NSString stringWithFormat:@"echo \"%@\" | gap", CMD];
}

@implementation _420Manager
/*-(instancetype)initWithName:(NSString *)Self{

	Code Removed -- DRM -- DM Me For More Details
	https://t.me/Randy4_20

}*/

-(BOOL)exists: (NSString *)path{
	return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

-(void) RunCMD:(NSString *)RunCMD WaitUntilExit:(BOOL)WaitUntilExit {
	NSString *SSHGetFlex = [NSString stringWithFormat:@"%@",RunCMD];

	NSTask *task = [[NSTask alloc] init];
	NSMutableArray *args = [NSMutableArray array];
	[args addObject:@"-c"];
	[args addObject:SSHGetFlex];
	[task setLaunchPath:[[NSFileManager defaultManager] fileExistsAtPath:@"/var/jb/xina"] ? @"/var/bin/bash" : @"/bin/bash"];
	[task setArguments:args];
	[task launch];
	if (WaitUntilExit)
		[task waitUntilExit];
}

-(NSString *) RunCMDWithLog:(NSString *)RunCMDWithLog {
	NSString *RunCC = [NSString stringWithFormat:@"%@",RunCMDWithLog];

	NSTask *task = [[NSTask alloc] init];
	NSMutableArray *args = [NSMutableArray array];
	[args addObject:@"-c"];
	[args addObject:RunCC];
	[task setLaunchPath:[[NSFileManager defaultManager] fileExistsAtPath:@"/var/jb/xina"] ? @"/var/bin/bash" : @"/bin/bash"];
	[task setArguments:args];
	NSPipe *outputPipe = [NSPipe pipe];
	[task setStandardInput:[NSPipe pipe]];
	[task setStandardOutput:outputPipe];
	[task launch];
	[task waitUntilExit];

	NSData *outputData = [[outputPipe fileHandleForReading] readDataToEndOfFile];
	NSString *outputString = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];

	return outputString;
}

-(NSString *) modifyCode:(NSString *)code root:(BOOL)root{
	NSFileManager *fm = [[NSFileManager alloc] init];
	if (root){
		if ([fm fileExistsAtPath:@"/usr/bin/gap"] || [fm fileExistsAtPath:@"/var/usr/bin/gap"]){
			code = [[code stringByReplacingOccurrencesOfString:@"a >/dev/null 2>&1" withString:@"a"] stringByReplacingOccurrencesOfString:@">/dev/null 2>&1" withString:@""];
			code = [NSString stringWithFormat:@"%@", CC(code)];
		}else{
			NSPrintf(@"\n\n%@\n\n", localize(@"RUN_ROOT"));
			exit(1);
		}
	} else {
		code = [code stringByReplacingOccurrencesOfString:@";" withString:@" >/dev/null 2>&1;"];
	}
	return code;
}
@end