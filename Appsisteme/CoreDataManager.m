//
//  CoreDataManager.m
//  Appsisteme
//
//  Created by Alumno on 18/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "CoreDataManager.h"
#import "Contact.h"

@implementation CoreDataManager

/**
 * Return the entities stored into Code Data
 *
 * @param entityName. The Core Data entity name
 */
- (NSArray *)getEntitiesFromCoreDataWithName:(NSString *)entityName {
    
    NSError *error;
    NSManagedObjectContext *managedObjContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjContext];
    [fetchRequest setEntity:entity]; //SELECT * FROM entityName
    
    NSArray *result = [managedObjContext executeFetchRequest:fetchRequest error:&error];
    
    return result;
}

/**
 * Write a TwitterUser into Core Data storage
 *
 * @param attributes. The entity attributes
 */
- (void)addContactIntoCoreDataWithAttributes:(NSDictionary *)attributes {
    
    Contact *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Contact"
                                                               inManagedObjectContext:[self managedObjectContext]];
    
    for (NSString *key in [attributes allKeys]) {
        
        [managedObject setValue:[attributes valueForKey:key] forKey:key];
    }
    
    [self saveContext];
}

/**
 * Update a Stored entity
 *
 * @param entityName. The Core Data entity name
 * @param identifierName. The Core Data identifier name
 * @param identifier. The identifier
 * @param attributes. The attributes for update.
 */
- (void)editEntity:(NSString *)entityName
      identifierName:(NSString *)identifierName
          identifier:(NSString *)identifier
          attributes:(NSDictionary *)attributes {
    
    if ([entityName length] > 0) {
        
        NSError *error;
        NSManagedObjectContext *managedObjContext = [self managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjContext];
        [fetchRequest setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.%@ == %@", identifierName, identifier];
        [fetchRequest setPredicate:predicate];
        
        NSArray *result = [managedObjContext executeFetchRequest:fetchRequest error:&error];
        
        if ([result count] == 1) {
            
            NSManagedObject *managedObject = result[0];
            
            for (NSString *key in [attributes allKeys]) {
                
                [managedObject setValue:[attributes valueForKey:key] forKey:key];
            }
            
            [self saveContext];
        }
    }
}


@end
