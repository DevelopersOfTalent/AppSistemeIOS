//
//  WaitViewController.m
//  Appsisteme
//
//  Created by Andrea Cerrato on 1/6/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "WaitViewController.h"
#import "Session.h"

@interface WaitViewController ()

@end

@implementation WaitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self doTheSegue];
}

-(void) doTheSegue {
    
    if ([[[Session sharedSession] userType] isEqualToString:@"guardian"]) {
        
        if (self.idGuardianJSON == self.idGuardedJSON) {
            
            [self performSegueWithIdentifier:@"segueTabBarGuardian" sender:nil];
        }
    }
    if ([[[Session sharedSession] userType] isEqualToString:@"guarded"]) {
        
        if (![self.guardianMail isEqualToString:@""]){
            
            [self performSegueWithIdentifier:@"segueTabBarGuarded" sender:nil];
        }
    }
}

@end
