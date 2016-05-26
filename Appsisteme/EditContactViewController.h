//
//  EditContactViewController.h
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Contact;



// These methods are used by the AddViewController, so are declared here, but they are private to these classes.

@interface EditContactViewController : UIViewController


-(instancetype) initWithContext: (NSManagedObjectContext *) context;



-(void) receiveContext:(NSManagedObjectContext *) context andContact:(Contact *) editedContact;

@end










