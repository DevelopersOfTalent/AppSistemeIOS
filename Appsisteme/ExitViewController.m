//
//  ExitViewController.m
//  Appsisteme
//
//  Created by Andrea Cerrato on 29/5/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "ExitViewController.h"
#import "AppDelegate.h"

@interface ExitViewController ()

//@property (nonatomic, strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UITextField *exitTextField;

@end

@implementation ExitViewController

- (IBAction)exit:(UIButton *)sender {
    
    if ([self.exitTextField.text isEqualToString:@"salir"]) {
        NSLog(@"Entra if exit");
        
        [[self tabBarController] dismissViewControllerAnimated:YES completion:^{
           
            UINavigationController *navController = (UINavigationController *)[[[AppDelegate appDelegate] window] rootViewController];
            
            [navController popToRootViewControllerAnimated:YES];
        }];
    }
}

- (IBAction)cancelExit:(UIButton *)sender {
    
    [self.tabBarController setSelectedIndex:0];
}


#pragma mark - Hide keyboard

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
