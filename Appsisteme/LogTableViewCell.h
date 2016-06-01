//
//  LogTableViewCell.h
//  Appsisteme
//
//  Created by Alumno on 30/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelLogState;
@property (weak, nonatomic) IBOutlet UILabel *labelLogDate;
@property (weak, nonatomic) IBOutlet UIView *viewLogCell;

@end
