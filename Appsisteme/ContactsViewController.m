//
//  ViewController.m
//  Appsisteme
//
//  Created by Alumno on 18/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "ContactsViewController.h"
#import "Contact.h"
#import "NewContactViewController.h"


@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSManagedObjectContext *context;

@end


@implementation ContactsViewController

- (id) initWithContext: (NSManagedObjectContext *) context {
    
    //Creo que esto voy a tener que modificarlo
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _context = context;
    }
    return self;
}


#pragma mark - Core Data

- (void) loadContacts {
    
    //Fetch
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:@"contacts" inManagedObjectContext:self.context]];
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = results;
}


#pragma mark - Table View DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Contact *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = contact.name;
    
    return cell;
}


#pragma mark - Interface

-(void) addInsertButton
{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonWasTapped:)];
    self.navigationItem.rightBarButtonItem = addButton;
}


#pragma mark - Events

-(void) addButtonWasTapped:(id)sender
{
    NewContactViewController *newContactVC = [[NewContactViewController alloc] initWithContext:self.context];
    [self presentViewController:newContactVC animated:YES completion:nil];
}

@end












