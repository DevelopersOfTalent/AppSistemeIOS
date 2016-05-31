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
#import "ContactsViewController.h"

@interface NewContactViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *contactName;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneNumber;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSManagedObjectContext *contextAux;

@property (strong, nonatomic) UIImage *image;
@property (nonatomic) BOOL isPhotoEdited;

@end

@implementation NewContactViewController

#pragma mark - Init

-(instancetype) initWithContext: (NSManagedObjectContext *) context {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _context = context;
    }
    return self;
}


#pragma mark - Before segue function

-(void) receiveContext:(NSManagedObjectContext *) context {
    
    self.contextAux = context;
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
    
    if (self.isPhotoEdited) {
        
        UIImage *imageResize = [self imageWithImage:self.image scaledToSize:CGSizeMake(56, 56)];
        NSData *imageData = UIImagePNGRepresentation(imageResize);
        [contact setImage:imageData];
        self.isPhotoEdited = NO;
    } else {
        
        self.image = [UIImage imageNamed:@"fotoUser.png"];
        UIImage *imageResize = [self imageWithImage:self.image scaledToSize:CGSizeMake(56, 56)];
        NSData *imageData = UIImagePNGRepresentation(imageResize);
        [contact setImage:imageData];
    }
    
    
    
    // Lo metemos en nuestro ManagedObjectContext
    [self.context insertObject:contact];
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)targetSize;

{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else {
            scaleFactor = heightFactor;
        } // scale to fit width
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
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


#pragma mark - Hide keyboard

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


#pragma mark - Image Picker Controller Delegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    self.isPhotoEdited = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    self.image = [UIImage imageNamed:@"fotoUser.png"];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Actions

- (IBAction)openGalery:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
}


@end
