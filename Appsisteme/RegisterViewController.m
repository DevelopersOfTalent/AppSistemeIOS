//
//  RegisterViewController.m
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "RegisterViewController.h"
#import "Session.h"
#import "UIView+Toast.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

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
    
    if([self isValidEmail:self.email.text] && [self isValidPassword:self.password.text]) {
    
        [self doTheSegue];
    } else if (![self isValidEmail:self.email.text]) {
        
        [self.view makeToast:@"El email introducido no es correcto"];
    } else {
        
        [self.view makeToast:@"La contraseña debe tener entre 6 y 10 caracteres"];
    }

    
    
}

-(BOOL) isValidEmail:(NSString *)email
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(BOOL) isValidPassword:(NSString *)password {
    
    if ( [password length]<6 || [password length]>10 )
        return NO;  // too long or too short
    
    return YES;
}

-(void) doTheSegue {
    
    if ([[[Session sharedSession] userType] isEqualToString:@"guardian"]) {
        [self performSegueWithIdentifier:@"segueToGuardianPath" sender:nil];
    }
    if ([[[Session sharedSession] userType] isEqualToString:@"guarded"]) {
        [self performSegueWithIdentifier:@"segueToGuardedPath" sender:nil];
    }
}


#pragma mark - Before segue function

-(void)receiveUserType:(NSString *) userType {
    
    self.userTypeAux = userType;
}

@end
