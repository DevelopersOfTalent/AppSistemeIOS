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




@interface EditContactViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>



@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSManagedObjectContext *contextAux;

@property (nonatomic, strong) Contact *editedContact;
@property (nonatomic, strong) Contact *editedContactAux;

@property (strong, nonatomic) UIImage *image;



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


#pragma mark - Core Data

- (IBAction)editContact:(id)sender {
    
    if ([self isValidPhone:self.textFieldPhoneNumber.text] && ![self.textFieldName.text isEqualToString:@""]) {
        
        [self.editedContact setName:self.textFieldName.text];
        [self.editedContact setPhoneNumber:self.textFieldPhoneNumber.text];
        
        UIImage *imageResize = [self imageWithImage:self.image scaledToSize:CGSizeMake(56, 56)];
        NSData *imageData = UIImagePNGRepresentation(imageResize);
        [self.editedContact setImage:imageData];
        
        NSError *error;
        [_context save:&error];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if ([self.textFieldName.text isEqualToString:@""]){
        
        [self.view makeToast:@"El campo nombre del contacto no puede estar vacío" duration:2.0 position:CSToastPositionCenter];
    } else {
        
        [self.view makeToast:@"Introduzca un número de teléfono válido" duration:2.0 position:CSToastPositionCenter];
    }
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


#pragma mark - Hide keyboard

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


#pragma mark - Image Picker Controller Delegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
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
