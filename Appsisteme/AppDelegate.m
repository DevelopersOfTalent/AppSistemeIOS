//
//  AppDelegate.m
//  Appsisteme
//
//  Created by Alumno on 18/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "AppDelegate.h"


#import "ContactsViewController.h"

@interface AppDelegate ()



@end


@implementation AppDelegate

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
    
    //save context when terminate
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

@end
