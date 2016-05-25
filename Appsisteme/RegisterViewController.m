//
//  RegisterViewController.m
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (copy, nonatomic) NSString *userTypeAux;
@property (copy, nonatomic) NSString *userType;

@property (copy, nonatomic) NSString *idSegue;

@end

@implementation RegisterViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.userType = self.userTypeAux;
}

#pragma mark - Segues

-(IBAction) segueWithUserType:(UIButton *) sender {
    
    if ([self.userType isEqualToString:@"guardian"]) {
        [self performSegueWithIdentifier:@"segueToGuardian" sender:nil];
    }
    if ([self.userType isEqualToString:@"guarded"]) {
        [self performSegueWithIdentifier:@"segueToGuarded" sender:nil];
    }
}

#pragma mark - Before segue function

-(void)receiveUserType:(NSString *) userType {
    
    self.userTypeAux = userType;
}

@end
