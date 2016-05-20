//
//  CoreDataManager.h
//  Appsisteme
//
//  Created by Alumno on 18/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"

@interface CoreDataManager : CoreDataStack

- (NSArray *)getEntitiesFromCoreDataWithName:(NSString *)entityName;

- (void)addContactIntoCoreDataWithAttributes:(NSDictionary *)attributes;

/**
 * Update a Stored entity
 *
 * @param entityName. The Core Data entity name
 * @param identifierName. The Core Data identifier name
 * @param identifier. The identifier
 * @param attributes. The attributes for update.
 */
- (void)editAndUpdateEntity:(NSString *)entityName
      identifierName:(NSString *)identifierName
          identifier:(NSString *)identifier
          attributes:(NSDictionary *)attributes;

@end
