//
//  EditContactViewController.m
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "EditContactViewController.h"
#import "Contact.h"
#import "UIView+Toast.h"




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
    
    if ([self isValidPhone:self.textFieldPhoneNumber.text] && ![self.textFieldName.text isEqualToString:@""]) {
        
        [self.editedContact setName:self.textFieldName.text];
        [self.editedContact setPhoneNumber:self.textFieldPhoneNumber.text];
        
        NSError *error;
        [_context save:&error];
        
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([self.textFieldName.text isEqualToString:@""]){
        
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
