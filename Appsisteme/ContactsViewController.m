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
#import "AppDelegate.h"
#import "ContactsTableViewCell.h"
#import "EditContactViewController.h"


@interface ContactsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSManagedObjectContext *context;

@end


@implementation ContactsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _context = [[[AppDelegate appDelegate] coreDataStack] managedObjectContext];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadContacts];
}

#pragma mark - Core Data

- (void) loadContacts {
    
    //Fetch
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:@"Contact" inManagedObjectContext:self.context]];
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = results;
}


#pragma mark - Table View DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.preferencesButton.tag = indexPath.row;
    [cell.preferencesButton addTarget:self action:@selector(editContact:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    
    Contact *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.labelContactsName.text = contact.name;
    
    return cell;
}

- (void)editContact:(UIButton *)sender {
    [self performSegueWithIdentifier:@"edit" sender:sender];
    
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    Contact *contact =[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: contact.name
                                                                   message:@"¿Que desea hacer?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Llamar"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              NSString *phNo = contact.phoneNumber;
                                                              
                                                              [self makeCall:phNo];
                                                              
                                                              }];
    UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"Atras"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               
                                                               
                                                           }];
    [alert addAction:defaultAction];
    [alert addAction:defaultAction2];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"add"]) {

        NewContactViewController *newContactVC = (NewContactViewController *)[segue destinationViewController];
        
        [newContactVC receiveContext:_context];
    }
    
    if ([[segue identifier] isEqualToString:@"edit"]) {
        
        //button
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:((UIView*)sender).tag inSection:0];
        
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Contact *selectedContact = (Contact *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        
        
        EditContactViewController *editContactViewController = (EditContactViewController *)[segue destinationViewController];
        
        [editContactViewController receiveContext:self.context andContact:selectedContact];
    }
}

-(IBAction)unwindToContactsView:(UIStoryboardSegue *)sender {
    
}

-(void) makeCall: (NSString *)phNo {
    
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        
        [[UIApplication sharedApplication] openURL:phoneUrl];
        
    } else
    {
        UIAlertController* alert2 = [UIAlertController alertControllerWithTitle: @"Alert"                                                                                                                                 message:@"Call facility is not available!!!"
            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* alertIn = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            
                                                            
                                                        }];
        [alert2 addAction:alertIn];
    }
    
}



@end












