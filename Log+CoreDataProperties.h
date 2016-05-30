//
//  Log+CoreDataProperties.h
//  Appsisteme
//
//  Created by Alumno on 30/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Log.h"

NS_ASSUME_NONNULL_BEGIN

@interface Log (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *state;
@property (nullable, nonatomic, retain) NSString *date;

@end

NS_ASSUME_NONNULL_END
