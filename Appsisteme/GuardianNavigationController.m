//
//  NavigationViewController.m
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "GuardianNavigationController.h"

@interface GuardianNavigationController ()

@end

@implementation GuardianNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"cabecera_vigilante_260 copia.jpg"] forBarMetrics:UIBarMetricsDefault];
    
//    UIBarButtonItem *addContact = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add.png"] style:UIBarButtonItemStylePlain target:nil action:@selector(goToAddContact)];
//    [[UIToolbar appearance] setItems:@[addContact]];
}

//- (void)goToAddContact {
//    
//    [self.navigationController performSegueWithIdentifier:@"add" sender:nil];
//}

@end
