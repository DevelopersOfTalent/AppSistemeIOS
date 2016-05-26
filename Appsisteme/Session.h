//
//  UserType.h
//  Appsisteme
//
//  Created by Alumno on 26/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

@property (nonatomic, retain) NSString *userType;

+ (id)sharedSession;


@end
