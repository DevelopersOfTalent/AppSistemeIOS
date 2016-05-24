//
//  AppSistemeViewController.m
//  Appsisteme
//
//  Created by Alumno on 24/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "AppSistemeViewController.h"

@interface AppSistemeViewController ()

@property NSTimer *timer;

@end

@implementation AppSistemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(segueToNextViewController) userInfo:nil repeats:NO];
}

-(void) segueToNextViewController {
    
    [self performSegueWithIdentifier:@"segueToRegister" sender:nil];
}


@end
