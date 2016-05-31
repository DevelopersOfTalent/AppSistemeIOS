//
//  ContactsTableViewCell.h
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <UIKit/UIKit.h> 


@interface ContactsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contactsCell;
@property (weak, nonatomic) IBOutlet UIButton *preferencesButton;
@property (weak, nonatomic) IBOutlet UILabel *labelContactsName;
@property (weak, nonatomic) IBOutlet UIImageView *contactImage;

@end
