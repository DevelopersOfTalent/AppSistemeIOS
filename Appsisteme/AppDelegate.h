//
//  AppDelegate.h
//  Appsisteme
//
//  Created by Alumno on 18/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import <OneSignal/OneSignal.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CoreDataStack *coreDataStack;

@property (strong, nonatomic) OneSignal *oneSignal;

@property (nonatomic) NSString *userId;

@property (nonatomic) NSDictionary *dataDictionary;

/**
 * Returns the application delegate
 *
 * @return The app delegate.
 */
+ (AppDelegate *)appDelegate;

@end

