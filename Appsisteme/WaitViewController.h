//
//  WaitViewController.h
//  Appsisteme
//
//  Created by Andrea Cerrato on 1/6/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitViewController : UIViewController

@property (nonatomic) int idGuardianJSON;
@property (nonatomic) int idGuardedJSON;
@property (copy, nonatomic) NSString *guardianMail;

@end
