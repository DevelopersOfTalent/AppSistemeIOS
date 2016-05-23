//
//  SecViewcontrollerViewController.m
//  Appsisteme
//
//  Created by Alumno on 19/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "SecViewcontrollerViewController.h"
#import "Contact.h"
#import "CoreDataManager.h"

@interface SecViewcontrollerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *contactName;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneNumber;

@property (nonatomic, strong) Contact *contact;
@property (nonatomic, strong) NSString *editedContactName;
@property (nonatomic, strong) NSString *editedContactPhoneNumber;
@property (nonatomic, strong) CoreDataManager *coreDataManager;
@property (nonatomic, strong) NSDictionary *contactDic;

@end

@implementation SecViewcontrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveContact:(UIButton *)sender {
    
    self.contactDic = [[NSDictionary alloc]initWithObjects:@[self.contactName.text,self.contactPhoneNumber.text] forKeys:@[@"contact_name",@"contact_phone"]];
    
    [self.coreDataManager addContactIntoCoreDataWithAttributes:self.contactDic];
    
    NSUndoManager *undoManager = [[self.contact managedObjectContext] undoManager];
    [undoManager setActionName:[NSString stringWithFormat:@"%@", self.editedContactName]];
    
    [self.editedContactName setValue:self.contactName forKey:self.editedContactName];
    
    [undoManager setActionName:[NSString stringWithFormat:@"%@", self.editedContactPhoneNumber]];
    
    [self.editedContactPhoneNumber setValue:self.contactPhoneNumber forKey:self.editedContactPhoneNumber];
    
    
}


@end
