//
//  RegisterTwoViewController.m
//  Appsisteme
//
//  Created by Alumno on 01/06/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "RegisterTwoViewController.h"

@interface RegisterTwoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation RegisterTwoViewController

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *emailUser = [user stringForKey: @"emailTwo"];

    
    self.email.text = emailUser;

}


- (IBAction)save:(id)sender {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject: self.email.text forKey:(@"emailTwo")];

}



@end
