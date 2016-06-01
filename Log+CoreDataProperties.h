//
//  Log+CoreDataProperties.h
//  Appsisteme
//
//  Created by Alumno on 31/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Log.h"

NS_ASSUME_NONNULL_BEGIN

@interface Log (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *state;

@end

NS_ASSUME_NONNULL_END
