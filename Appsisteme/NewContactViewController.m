//
//  SecViewcontrollerViewController.m
//  Appsisteme
//
//  Created by Alumno on 19/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "NewContactViewController.h"
#import "Contact.h"

@interface NewContactViewController ()

@property (weak, nonatomic) IBOutlet UITextField *contactName;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneNumber;

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation NewContactViewController

#pragma mark - Init

-(instancetype) initWithContext: (NSManagedObjectContext *) context {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _context = context;
    }
    return self;
}


#pragma mark - LifeCycle

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.contactName becomeFirstResponder];
}


#pragma mark - Core Data

-(void) saveContact
{
    // Creamos una instancia del nuevo personaje a partir del modelo
    Contact *contact = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Contact"
                            inManagedObjectContext:self.context];
    
    // Asignamos las propiedades
    [contact setName:self.contactName.text];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    //phoneFormatter.numberStyle = NSNumberFormatter;
    NSNumber *phone = [f numberFromString:self.contactPhoneNumber.text];
    [contact setPhoneNumber:phone];
    
    // Lo metemos en nuestro ManagedObjectContext
    [self.context insertObject:contact];
}


#pragma mark - Events

-(IBAction) cancelButtonWasTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction) doneButtonWasTapped
{
    [self saveContact];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
