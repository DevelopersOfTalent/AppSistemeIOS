//
//  LogViewController.h
//  Appsisteme
//
//  Created by Alumno on 30/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface LogViewController : CoreDataTableViewController

-(instancetype) initWithContext: (NSManagedObjectContext *) context;

-(void) loadLog;

@end
