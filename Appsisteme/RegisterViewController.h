//
//  RegisterViewController.h
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
-(void)receiveUserType:(NSString *) userType;

@end
