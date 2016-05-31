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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.contactImage.layer.cornerRadius = self.contactImage.frame.size.width / 2;
    self.contactImage.clipsToBounds = YES;
    
    [super layoutSubviews];
}

@end
