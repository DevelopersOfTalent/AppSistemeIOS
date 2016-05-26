//
//  UserType.m
//  Appsisteme
//
//  Created by Alumno on 26/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "Session.h"

@interface Session ()

- (instancetype)initPrivate;

@end

@implementation Session

@synthesize userType;

#pragma mark Singleton Methods

+ (id)sharedSession {
    
    static Session *sharedSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedSession = [[self alloc] initPrivate];
    });
    
    return sharedSession;
}

- (instancetype)initPrivate {
    
    if (self = [super init]) {
    }
    
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
