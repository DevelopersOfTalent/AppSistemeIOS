//
//  ViewController.h
//  Appsisteme
//
//  Created by Alumno on 18/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import <OneSignal/OneSignal.h>

@interface ContactsViewController : CoreDataTableViewController


@property (strong, nonatomic) UIImage *image;

- (void) loadContacts;

//-(void) addInsertButton;
//-(void) addButtonWasTapped:(id)sender;

@end

