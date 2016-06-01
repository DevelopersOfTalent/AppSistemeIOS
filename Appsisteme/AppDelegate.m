//
//  AppDelegate.m
//  Appsisteme
//
//  Created by Alumno on 18/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "AppDelegate.h"
#import "StateViewController.h"
#import "ContactsViewController.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

@synthesize oneSignal = _oneSignal;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.coreDataStack = [[CoreDataStack alloc] init];
//    NSManagedObjectContext *context = [self.coreDataStack managedObjectContext];
    
    
//    ContactsViewController *contactsVC = [[ContactsViewController alloc] initWithContext:context];
//    UINavigationController *navContacts = [[UINavigationController alloc] initWithRootViewController:contactsVC];
//    
//    self.window.rootViewController = navContacts;
//    
//    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    //One signal
    self.oneSignal = [[OneSignal alloc] initWithLaunchOptions:launchOptions
                                                        appId:@"bdf1bce9-c220-4631-8784-045722fa5861"
                                           handleNotification:^(NSString* message, NSDictionary* additionalData, BOOL isActive) {
                                               NSLog(@"OneSignal Notification opened:\nMessage: %@", message);
                                               
                                               
                                               if (additionalData) {
                                                   
                                                   _dataDictionary = additionalData;
                                                   
                                                   StateViewController *stateViewController = [[StateViewController alloc] initWithNibName:nil bundle:nil];
                                                   [stateViewController reciveNotification:_dataDictionary ];
                                                   
                                                   
                                                   
                                                   // Check for and read any custom values you added to the notification
                                                   // This done with the "Additional Data" section the dashboard.
                                                   // OR setting the 'data' field on our REST API.
                                                   NSString* data = additionalData[@"data"];
                                                   if (data)
                                                       NSLog(@"customKey: %@", data);
                                               }
                                           }];
    
    [_oneSignal enableInAppAlertNotification:true];
    
    [_oneSignal IdsAvailable:^(NSString* userId, NSString* pushToken) {
        NSLog(@"UserId:%@", userId);
        _userId = userId;
        
        if (pushToken != nil)
            NSLog(@"pushToken:%@", pushToken);
        
    }];
                        
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self.coreDataStack saveContext];

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    [self.coreDataStack saveContext];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    [self.coreDataStack saveContext];
}

#pragma mark - Utils

/**
 * Returns the application delegate
 *
 * @return The app delegate.
 */
+ (AppDelegate *)appDelegate {
    
    static AppDelegate *appDelegate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    });
    
    return appDelegate;
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo: %@",userInfo);
    if ( application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground  )
    {
        //opened from a push notification when the app was on background
        NSDictionary *notification = [userInfo objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        NSLog(@"Notificacion: %@",notification);
    }
}

@end
