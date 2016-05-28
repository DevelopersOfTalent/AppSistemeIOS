//
//  EditContactViewController.m
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "EditContactViewController.h"
#import "Contact.h"




@interface EditContactViewController ()



@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSManagedObjectContext *contextAux;

@property (nonatomic, strong) Contact *editedContact;
@property (nonatomic, strong) Contact *editedContactAux;



@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.context = self.contextAux;
    self.editedContact = self.editedContactAux;
    
    self.textFieldName.text = self.editedContact.name;
    self.textFieldPhoneNumber.text = self.editedContact.phoneNumber;
    
}



-(void) receiveContext:(NSManagedObjectContext *) context andContact:(Contact *) editedContact{
    
    self.contextAux = context;
    self.editedContactAux = editedContact;
}

-(instancetype) initWithContext: (NSManagedObjectContext *) context {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _context = context;
    }
    return self;
}

- (IBAction)editContact:(id)sender {
    
    
    [self.editedContact setName:self.textFieldName.text];
    [self.editedContact setPhoneNumber:self.textFieldPhoneNumber.text];
    
    NSError *error;
    [_context save:&error];
    
    [self.navigationController popViewControllerAnimated:YES];
}

    

- (IBAction)deleteContact:(id)sender {
    
    
    [_context deleteObject:_editedContact];
    
    NSError *error;
    [_context save:&error];
    
//    NSError *error = nil;
//    if (_context != nil) {
//        if ([_context hasChanges] && ![_context save:&error]) {
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }
//    }
    
    [self.navigationController popViewControllerAnimated:YES];

}
    


@end
