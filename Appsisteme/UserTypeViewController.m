//
//  UserTypeViewController.m
//  Appsisteme
//
//  Created by Alumno on 24/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "UserTypeViewController.h"
#import "RegisterViewController.h"
#import "Session.h"

@interface UserTypeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *guardian;

@property (weak, nonatomic) IBOutlet UIButton *guarded;

@property (nonatomic, copy) NSString *userType;

@end

@implementation UserTypeViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - segues

- (IBAction) setUser:(UIButton *) sender {
    
    if ([sender.titleLabel.text isEqualToString:self.guardian.titleLabel.text]) {
        [[Session sharedSession] setUserType:@"guardian"];
    }
    if ([sender.titleLabel.text isEqualToString:self.guarded.titleLabel.text]) {
        [[Session sharedSession] setUserType:@"guarded"];
    }
    
    [self performSegueWithIdentifier:@"segueToRegister" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"segueToRegister"]) {
        
        RegisterViewController *registerVC = (RegisterViewController *)[segue destinationViewController];
        
        [registerVC receiveUserType:self.userType];
    }
}

@end
