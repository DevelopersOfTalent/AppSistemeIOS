//
//  ContactsTableViewCell.m
//  Appsisteme
//
//  Created by Alumno on 25/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "ContactsTableViewCell.h"

@implementation ContactsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
