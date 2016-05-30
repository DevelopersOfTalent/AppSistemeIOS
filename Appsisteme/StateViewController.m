//
//  StateViewController.m
//  Appsisteme
//
//  Created by Alumno on 30/05/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "StateViewController.h"
#import "AppDelegate.h"

@interface StateViewController ()
@property (weak, nonatomic) IBOutlet UIButton *requestButton;
@property (strong,nonatomic) OneSignal *oneSignal;
@property (strong,nonatomic) NSString *idUser;

@end

@implementation StateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)requestState:(id)sender {
    
   _idUser= @"65322cff-b81e-4d76-8a70-860e8dcd0f29";
    
   _oneSignal = [[AppDelegate appDelegate] oneSignal];
   [_oneSignal postNotification:@{
                                 @"contents" : @{@"en": @"Hola"},
                                 @"include_player_ids": @[_idUser]
                                 }];
};
- (IBAction)sendState:(id)sender {
    
    _idUser= @"65322cff-b81e-4d76-8a70-860e8dcd0f29";
    _oneSignal = [[AppDelegate appDelegate] oneSignal];
    NSString *buttonName = [sender titleForState:UIControlStateNormal];
    if ([buttonName   isEqual: @"Good"]) {
        _oneSignal = [[AppDelegate appDelegate] oneSignal];
        [_oneSignal postNotification:@{
                                       @"contents" : @{@"en": @"Bien"},
                                       @"include_player_ids": @[_idUser]
                                       }];            }
    else if ([buttonName  isEqual: @"Bad"]){
        _oneSignal = [[AppDelegate appDelegate] oneSignal];
        [_oneSignal postNotification:@{
                                       @"contents" : @{@"en": @"Mal"},
                                       @"include_player_ids": @[_idUser]
                                       }];     }
    else if ([buttonName  isEqual: @"CallMe"]){
        _oneSignal = [[AppDelegate appDelegate] oneSignal];
        [_oneSignal postNotification:@{
                                       @"contents" : @{@"en": @"Llamame"},
                                       @"include_player_ids": @[_idUser]
                                       }];     }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
