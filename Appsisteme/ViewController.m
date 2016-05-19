//
//  ViewController.m
//  Appsisteme
//
//  Created by Alumno on 18/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "Contact.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myContacts;
@property (nonatomic, strong) NSArray *myContacsList;
@property (nonatomic, strong) CoreDataManager *coreDataManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.myContacsList = [self.coreDataManager getEntitiesFromCoreDataWithName:@"Contact"];
    [self.myContacts reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) unwindToViewController:(UIStoryboardSegue *)unwindSegue {
    
}

#pragma mark - Metodods data source de la tabla


//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Mis Contactos";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myContacsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // NSLog(@"%@",indexPath.description);
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Contact *contact =[self.myContacsList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = contact.name;
    
    return cell;
}

#pragma mark - Metodods delegate de la tabla

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath.description);
    
    //[self performSegueWithIdentifier:@"segue" sender:[_listaGrupos objectAtIndex:indexPath.row]];
}


@end
