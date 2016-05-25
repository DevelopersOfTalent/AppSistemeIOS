//
//  EditContactViewController.m
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "EditContactViewController.h"
#import "Contact.h"
#import "CoreDataStack.h"

@interface EditContactViewController ()



@property (weak, nonatomic) IBOutlet UITextField *contactName;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneNumber;

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
    
    self.contactName.text = self.editedContact.name;
    self.contactPhoneNumber.text = self.editedContact.phoneNumber;
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

-(void) editContact
{
    
    
    
    
}

@end
