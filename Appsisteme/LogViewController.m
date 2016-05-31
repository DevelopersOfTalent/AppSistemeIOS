//
//  LogViewController.m
//  Appsisteme
//
//  Created by Alumno on 30/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "LogViewController.h"
#import "AppDelegate.h"
#import "LogTableViewCell.h"
#import "Log.h"

@interface LogViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSManagedObjectContext *context;

@property (strong,nonatomic) AppDelegate *appDelegate;

@property (strong,nonatomic) NSString *state;

@end

@implementation LogViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [[[AppDelegate appDelegate] oneSignal] sendTag:@"key" value:@"value"];
    
    _context = [[[AppDelegate appDelegate] coreDataStack] managedObjectContext];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self loadLog];
    _context = [[[AppDelegate appDelegate] coreDataStack] managedObjectContext];
    [self loadLog];
    
    
}

#pragma mark - Init

-(instancetype) initWithContext: (NSManagedObjectContext *) context {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _context = context;
    }
    return self;
}

#pragma mark - Core Data

- (void) loadLog {
    
    //Fetch
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:@"Log" inManagedObjectContext:self.context]];
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = results;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cellLog";
    LogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
 
    
    Log *log = [self.fetchedResultsController objectAtIndexPath:indexPath];
 
   
      if ([log.state isEqual: @"1"] ) {
        _state = @"Bien";
          
      } else if ([log.state isEqual: @"2"]){
          _state =@"Mal";
          
      } else if ([log.state isEqual: @"3"]){
          _state = @"Llamame";
      }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    
    NSString * dateString = [dateFormatter stringFromDate: log.date];
    
    
    cell.labelLogState.text = _state;
    cell.labelLogDate.text = dateString;
    
    
    
    return cell;
}





@end
