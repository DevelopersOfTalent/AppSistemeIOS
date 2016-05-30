//
//  StateViewController.m
//  Appsisteme
//
//  Created by Alumno on 30/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "StateViewController.h"
#import "AppDelegate.h"
#import "Log.h"
#import "CoreDataTableViewController.h"

@interface StateViewController ()
@property (weak, nonatomic) IBOutlet UIButton *requestButton;
@property (strong,nonatomic) OneSignal *oneSignal;
@property (strong,nonatomic) NSString *idUser;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSManagedObjectContext *contextAux;

@end

@implementation StateViewController

#pragma mark - Init

-(instancetype) initWithContext: (NSManagedObjectContext *) context {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _context = context;
    }
    return self;
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[AppDelegate appDelegate] oneSignal] sendTag:@"key" value:@"value"];
    
    _context = [[[AppDelegate appDelegate] coreDataStack] managedObjectContext];
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.context = self.contextAux;
    [super viewWillAppear:animated];

    
    
    
    _context = [[[AppDelegate appDelegate] coreDataStack] managedObjectContext];

}


- (IBAction)requestState:(id)sender {
    
   _idUser= @"b73ec819-fac7-418d-a663-a8c7b12cc9c6";
    
   _oneSignal = [[AppDelegate appDelegate] oneSignal];
   [_oneSignal postNotification:@{
                                 @"contents" : @{@"en": @"Hola"},
                                 @"include_player_ids": @[_idUser]
                                 }];
};

- (IBAction)sendState:(id)sender {
    
    _idUser= @"b73ec819-fac7-418d-a663-a8c7b12cc9c6";
    _oneSignal = [[AppDelegate appDelegate] oneSignal];
    NSString *buttonName = [sender titleForState:UIControlStateNormal];
    
    Log *log = [NSEntityDescription
                insertNewObjectForEntityForName:@"Log"
                inManagedObjectContext:self.context];
    
    [log setState:buttonName];
    [log setDate:@"Hoy"];
    
    [self.context insertObject:log];
    
    
    if ([buttonName   isEqual: @"Good"]) {
        _oneSignal = [[AppDelegate appDelegate] oneSignal];
        [_oneSignal postNotification:@{
                                       @"contents" : @{@"en": @"Bien"},
                                       @"data" : @{@"calle" : @"8",@"calle2" : @"18"},
                                       @"include_player_ids": @[_idUser]
                                       }];
    }
    
    else if ([buttonName  isEqual: @"Bad"]){
        _oneSignal = [[AppDelegate appDelegate] oneSignal];
        [_oneSignal postNotification:@{
                                       @"contents" : @{@"en": @"Mal"},
                                       @"include_player_ids": @[_idUser]
                                       }];
    }
    
    else if ([buttonName  isEqual: @"CallMe"]){
        _oneSignal = [[AppDelegate appDelegate] oneSignal];
        [_oneSignal postNotification:@{
                                       @"contents" : @{@"en": @"Llamame"},
                                       @"include_player_ids": @[_idUser]
                                       }];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
