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

/**
 * Return the entities stored into Code Data
 *
 * @param entityName. The Core Data entity name
 */
- (NSArray *)getEntitiesInCoreDataWithName:(NSString *)entityName;

/**
 * Write a TwitterUser into Core Data storage
 *
 * @param attributes. The entity attributes
 */
- (void)writeTwitterUserWithAttributes:(NSDictionary *)attributes;

/**
 * Write a InstagramUser into Core Data storage
 *
 * @param attributes. The entity attributes
 */
- (void)writeInstagramUserWithAttributes:(NSDictionary *)attributes;

/**
 * Update a Stored entity
 *
 * @param entityName. The Core Data entity name
 * @param identifierName. The Core Data identifier name
 * @param identifier. The identifier
 * @param attributes. The attributes for update.
 */
- (void)updataEntity:(NSString *)entityName
      identifierName:(NSString *)identifierName
          identifier:(NSString *)identifier
          attributes:(NSDictionary *)attributes;

@end
