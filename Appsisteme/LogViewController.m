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
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"state" ascending:YES]];
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
    cell.labelLogState.text = log.state;
    cell.labelLogDate.text = log.date;
    
    
    return cell;
}





@end
