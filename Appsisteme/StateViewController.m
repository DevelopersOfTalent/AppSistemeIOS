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
    
   _idUser= @"eed57d57-4b88-44b5-895e-0be1fda91bcd";
    
   _oneSignal = [[AppDelegate appDelegate] oneSignal];
   [_oneSignal postNotification:@{
                                 @"contents" : @{@"en": @"Hola"},
                                 @"include_player_ids": @[_idUser]
                                 }];
};

- (IBAction)sendState:(id)sender {
    
    _idUser= @"eed57d57-4b88-44b5-895e-0be1fda91bcd";
    _oneSignal = [[AppDelegate appDelegate] oneSignal];
    NSString *buttonName = [sender titleForState:UIControlStateNormal];
    
    Log *log = [NSEntityDescription
                insertNewObjectForEntityForName:@"Log"
                inManagedObjectContext:self.context];
    
    
    [self.context insertObject:log];
    
    NSTimeInterval timeInSeconds = [[NSDate date] timeIntervalSince1970];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInSeconds];
    
    [log setDate:date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH:mm d/MM/yy "];
    
    NSString * dateString = [dateFormatter stringFromDate: date];
    
    if ([buttonName isEqual: @"Good"]) {
        _oneSignal = [[AppDelegate appDelegate] oneSignal];
        [_oneSignal postNotification:@{
                                       @"contents" : @{@"en": @"Bien"},
                                       @"data" : @{@"state" : @"1",@"date" : dateString},
                                       @"include_player_ids": @[_idUser]
                                       }];
        [log setState:@"1"];
    }
    
    else if ([buttonName isEqual: @"Bad"]){
        _oneSignal = [[AppDelegate appDelegate] oneSignal];
        [_oneSignal postNotification:@{
                                       @"contents" : @{@"en": @"Mal"},
                                       @"data" : @{@"state" : @"2",@"date" : dateString},
                                       @"include_player_ids": @[_idUser]
                                       }];
        [log setState:@"2"];
    }
    
    else if ([buttonName isEqual: @"CallMe"]){
        _oneSignal = [[AppDelegate appDelegate] oneSignal];
        [_oneSignal postNotification:@{
                                       @"contents" : @{@"en": @"Llamame"},
                                       @"data" : @{@"state" : @"3",@"date" : dateString},
                                       @"include_player_ids": @[_idUser]
                                       }];
        [log setState:@"3"];
    }
}

-(void) reciveNotification: (NSDictionary *)dataDictionary {
    
    _context = [[[AppDelegate appDelegate] coreDataStack] managedObjectContext];
    
    NSString *reciveState= [dataDictionary objectForKey:@"state"];
    NSString *reciveDate= [dataDictionary objectForKey:@"date"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm d/MM/yy "];
    NSDate *convertedDate = [dateFormatter dateFromString:reciveDate];
    
    Log *log = [NSEntityDescription
                insertNewObjectForEntityForName:@"Log"
                inManagedObjectContext:self.context];
    
    [log setState:reciveState];
    [log setDate:convertedDate];
    
}

@end
