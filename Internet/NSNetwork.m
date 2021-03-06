//
//  NSNetwork.m
//  SriBalajiSaiRam_Chit
//
//  Created by kireeti on 09/02/19.
//  Copyright © 2019 KireetiSoftSolutions. All rights reserved.

#import "NSNetwork.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#include <netdb.h>

NSString* const NSNetworkReachabilityChangedNotification = @"NSNetworkReachabilityChangedNotification";

@interface NSNetwork ()

@property (copy) NSString* hostname;
@property (copy) NSString* address;

- (BOOL)_setupReachability;
- (void)_reachabilityUpdatedWithFlags:(SCNetworkReachabilityFlags)flags;

@end

@implementation NSNetwork

@synthesize hostname = _hostname;
@synthesize address = _address;

static CFMutableDictionaryRef	_networkMap = NULL;
static NSNetwork*				_defaultNetwork = nil;

static void 
__SCNetworkReachabilityCallBack( SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info )
{
	NSNetwork*	net = (__bridge NSNetwork*)info;
	[net _reachabilityUpdatedWithFlags:flags];
}

+ (void)initialize
{
	if ( !_networkMap) 
		_networkMap = CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, NULL);
}

+ (NSNetwork*)defaultNetwork
{
	if ( !_defaultNetwork )
		_defaultNetwork = [[NSNetwork alloc] initWithAddress:@"0.0.0.0"];
	return _defaultNetwork ;
}

+ (NSNetwork*)networkWithHost:(NSString*)hostname
{
	return [[NSNetwork alloc] initWithHost:hostname];
}

+ (NSNetwork*)networkWithAddress:(NSString*)address
{
	return [[NSNetwork alloc] initWithAddress:address];
}

- (void)_reachabilityUpdatedWithFlags:(SCNetworkReachabilityFlags)flags
{
	_flags = flags;
	[[NSNotificationCenter defaultCenter] postNotificationName:NSNetworkReachabilityChangedNotification object:self];
}

- (NSString*)description
{
	NSMutableString*	output = [NSMutableString stringWithFormat:@"%@ {\n", [super description]];
	
	if ( _flags & kSCNetworkReachabilityFlagsTransientConnection )
		[output appendFormat:@"\t%@\n", @"kSCNetworkReachabilityFlagsTransientConnection"];
	if ( _flags & kSCNetworkReachabilityFlagsReachable )
		[output appendFormat:@"\t%@\n", @"kSCNetworkReachabilityFlagsReachable"];
	if ( _flags & kSCNetworkReachabilityFlagsConnectionRequired )
		[output appendFormat:@"\t%@\n", @"kSCNetworkReachabilityFlagsConnectionRequired"];
	if ( _flags & kSCNetworkReachabilityFlagsConnectionAutomatic )
		[output appendFormat:@"\t%@\n", @"kSCNetworkReachabilityFlagsConnectionAutomatic"];
	if ( _flags & kSCNetworkReachabilityFlagsInterventionRequired )
		[output appendFormat:@"\t%@\n", @"kSCNetworkReachabilityFlagsInterventionRequired"];
	if ( _flags & kSCNetworkReachabilityFlagsIsLocalAddress )
		[output appendFormat:@"\t%@\n", @"kSCNetworkReachabilityFlagsIsLocalAddress"];
	if ( _flags & kSCNetworkReachabilityFlagsIsDirect )
		[output appendFormat:@"\t%@\n", @"kSCNetworkReachabilityFlagsIsDirect"];
		
#if	TARGET_OS_IPHONE
	if ( _flags & kSCNetworkReachabilityFlagsIsWWAN )
		[output appendFormat:@"\t%@\n", @"kSCNetworkReachabilityFlagsIsWWAN"];
#endif

	[output appendFormat:@"}"];
	
	return output;
}

- (id)init
{
	self = [super init];
	return self;
}

- (id)initWithHost:(NSString*)hostname
{
	if ( CFDictionaryContainsKey( _networkMap, (__bridge const void *)(hostname) ) )
		return (NSNetwork*)CFDictionaryGetValue( _networkMap, (__bridge const void *)(hostname));
		
	self = [self init];
	self.hostname = hostname;
	if ( ![self _setupReachability] )
	{
		return nil;
	}
	return self;
}

- (id)initWithAddress:(NSString*)address;
{
	if ( CFDictionaryContainsKey( _networkMap, (__bridge const void *)(address) ) )
		return (NSNetwork*)CFDictionaryGetValue( _networkMap, (__bridge const void *)(address)) ;

	self = [self init];
	self.address = address;
	if ( ![self _setupReachability] )
	{
		return nil;
	}
	return self;
}

- (BOOL)_setupReachability
{
	if ( _reachRef )
	{
		CFRelease(_reachRef);
		_reachRef = NULL;
	}
	
	_flags = 0;
	
	if ( _address )
	{
		struct sockaddr_in	address_in;
		memset( (char *)&address_in, 0, sizeof(struct sockaddr_in) );
		address_in.sin_family = AF_INET;
		address_in.sin_len = sizeof(struct sockaddr_in);
		inet_aton( [_address UTF8String], &address_in.sin_addr);
		_reachRef = SCNetworkReachabilityCreateWithAddress( NULL, (struct sockaddr *)&address_in );
		if ( _reachRef )
			CFDictionarySetValue( _networkMap, (void*)_address, (__bridge const void *)(self) );
	}
	else if ( _hostname )
	{
		_reachRef = SCNetworkReachabilityCreateWithName( NULL, [_hostname UTF8String] );
		if ( _reachRef )
			CFDictionarySetValue( _networkMap, (void*)_hostname, (__bridge const void *)(self) );
	}
	
	if ( _reachRef )
	{
		SCNetworkReachabilityContext	cntxt = { 0, (__bridge void *)(self), NULL, NULL, NULL };
		SCNetworkReachabilitySetCallback( _reachRef, __SCNetworkReachabilityCallBack, &cntxt );
		SCNetworkReachabilityScheduleWithRunLoop( _reachRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode );
		SCNetworkReachabilityGetFlags( _reachRef, &_flags );
		[self _reachabilityUpdatedWithFlags:_flags];
		
	}
	
	return _reachRef != NULL;
}

- (void)dealloc
{
	if ( self.address )
		CFDictionaryRemoveValue( _networkMap, (void*)_address );
	else if ( self.hostname )
		CFDictionaryRemoveValue( _networkMap, (void*)_hostname );
		
	if ( _reachRef )
		CFRelease(_reachRef);
	_reachRef = NULL;
	self.address = nil;
	self.hostname = nil;
}

- (BOOL)canBeReached
{
	NSLog(@"_flags  %d kSCNetworkReachabilityFlagsReachable %d",_flags,kSCNetworkReachabilityFlagsReachable);
	return _flags & kSCNetworkReachabilityFlagsReachable;
}

- (BOOL)canBeReachedViaCellNetwork
{
	return _flags & kSCNetworkReachabilityFlagsIsWWAN;
}

- (BOOL)connectionRequired
{
	return _flags & kSCNetworkReachabilityFlagsConnectionRequired;
}

- (BOOL)willConnectOnTraffic
{
	return _flags & kSCNetworkReachabilityFlagsConnectionOnTraffic;
}

- (BOOL)interventionRequired
{
	return _flags & kSCNetworkReachabilityFlagsInterventionRequired;
}

- (BOOL)isLocalAddress
{
	return _flags & kSCNetworkReachabilityFlagsIsLocalAddress;
}

- (BOOL)isDirect
{
	return _flags & kSCNetworkReachabilityFlagsIsDirect;
}


@end






