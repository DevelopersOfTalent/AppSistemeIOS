//
//  SecViewcontrollerViewController.h
//  Appsisteme
//
//  Created by Alumno on 19/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewContactViewController : UIViewController

-(instancetype) initWithContext: (NSManagedObjectContext *) context;

-(void) saveContact;

-(void) receiveContext:(NSManagedObjectContext *) context;

@end
