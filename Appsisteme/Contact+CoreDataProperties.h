//
//  Contact+CoreDataProperties.h
//  Appsisteme
//
//  Created by Alumno on 18/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Contact.h"


@interface Contact (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *phoneNumber;

@end

