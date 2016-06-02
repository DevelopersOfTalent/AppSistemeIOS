//
//  RegisterTwoViewController.m
//  Appsisteme
//
//  Created by Alumno on 01/06/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "RegisterTwoViewController.h"
#import "WaitViewController.h"
#import "UIView+Toast.h"

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
    
    if([self isValidEmail:self.email.text]) {
        
        [self setIdGuardedAndGuardianMail];
        [self doTheSegue];
        
    } else {
        
        [self.view makeToast:@"El email introducido no es correcto" duration:2.0 position:CSToastPositionCenter];
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


- (void) setIdGuardedAndGuardianMail {
    
    // Read JSON data into array
    NSError *error;
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"servicio" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    if (jsonData == nil) {
        // handle error ...
    }
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (jsonArray == nil) {
        // handle error ...
    }
    
    for (NSDictionary *dict in jsonArray) {
        NSString *emailVigilante = [dict objectForKey:@"email1"];
        if ([emailVigilante isEqualToString:self.email.text]) {
            
            self.idGuardedJSON = (int)[dict objectForKey:@"id"];
        }
    }
}


-(void) doTheSegue {
    
   [self performSegueWithIdentifier:@"segueToWait" sender:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        
    WaitViewController *waitVC = (WaitViewController *)[segue destinationViewController];
        
    waitVC.idGuardianJSON = self.idGuardianJSON;
    waitVC.idGuardedJSON = self.idGuardedJSON;
}

#pragma mark - Hide keyboard

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
