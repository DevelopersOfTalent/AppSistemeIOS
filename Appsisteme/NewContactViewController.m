//
//  SecViewcontrollerViewController.m
//  Appsisteme
//
//  Created by Alumno on 19/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "NewContactViewController.h"
#import "Contact.h"
#import "UIView+Toast.h"

@interface NewContactViewController ()

@property (weak, nonatomic) IBOutlet UITextField *contactName;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneNumber;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSManagedObjectContext *contextAux;

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
    
    self.context = self.contextAux;
    
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
    [contact setPhoneNumber:self.contactPhoneNumber.text];
    
    // Lo metemos en nuestro ManagedObjectContext
    [self.context insertObject:contact];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Events
- (IBAction)cancelContact:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)aceptContact:(UIButton *)sender {
    
    if ([self isValidPhone:self.contactPhoneNumber.text] && ![self.contactName.text isEqualToString:@""]) {
        
        [self saveContact];
        
        NSError *error;
        [_context save:&error];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([self.contactName.text isEqualToString:@""]){
    
        [self.view makeToast:@"El campo nombre del contacto no puede estar vacío" duration:2.0 position:CSToastPositionCenter];
        
    } else {
        
        [self.view makeToast:@"Introduzca un número de teléfono válido" duration:2.0 position:CSToastPositionCenter];
    }
}

-(BOOL) isValidPhone:(NSString *) phone {
    
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    
    NSRange inputRange = NSMakeRange(0, [phone length]);
    NSArray *matches = [detector matchesInString:phone options:0 range:inputRange];
    
    // no match at all
    if ([matches count] == 0) {
        return NO;
    }
    
    // found match but we need to check if it matched the whole string
    NSTextCheckingResult *result = (NSTextCheckingResult *)[matches objectAtIndex:0];
    
    if ([result resultType] == NSTextCheckingTypePhoneNumber && result.range.location == inputRange.location && result.range.length == inputRange.length) {
        // it matched the whole string
        return YES;
    }
    else {
        // it only matched partial string
        return NO;
    }
}


#pragma mark - Before segue function

-(void) receiveContext:(NSManagedObjectContext *) context {
    
    self.contextAux = context;
}


@end
