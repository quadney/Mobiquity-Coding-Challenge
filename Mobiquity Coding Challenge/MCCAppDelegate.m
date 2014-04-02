//
//  MCCAppDelegate.m
//  Mobiquity Coding Challenge
//
//  Created by Sydney Richardson on 3/31/14.
//  Copyright (c) 2014 Sydney Richardson. All rights reserved.
//

#import "MCCAppDelegate.h"
#import <Dropbox/Dropbox.h>

@implementation MCCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController = [storyboard instantiateInitialViewController];
    
    
    
    // Override point for customization after application launch.
    DBAccountManager *accountManager = [[DBAccountManager alloc] initWithAppKey:@"7viqsfmzctjrefs"
                                                                         secret:@"v7qytclym3ytwkq"];
    [DBAccountManager setSharedManager:accountManager];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
  sourceApplication:(NSString *)source annotation:(id)annotation {
    DBAccount *account = [[DBAccountManager sharedManager] handleOpenURL:url];
    if (account) {
        NSLog(@"App linked successfully!");
        return YES;
    }
    return NO;
}

@end
