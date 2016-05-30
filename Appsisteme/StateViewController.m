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
@property (weak, nonatomic) IBOutlet UIButton *fineButton;
@property (weak, nonatomic) IBOutlet UIButton *badButton;
@property (weak, nonatomic) IBOutlet UIButton *callMeButton;
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
    
    [_oneSignal postNotification:@{
                                  @"contents" : @{@"en": @"_userId"},
                                   @"include_player_ids": @[@"9584842e-0dd2-48b9-bdab-fa1f37ba1339"]
                                  }];
    
    [_oneSignal getTags:^(NSDictionary* tags) {
        NSLog(@"%@", tags);
    }];
    
   // _idUser= @"9584842e-0dd2-48b9-bdab-fa1f37ba1339";
    
  //  _oneSignal = [[AppDelegate appDelegate] oneSignal];
  //  [_oneSignal postNotification:@{
   //                                @"contents" : @{@"en": @"Hola"},
    //                               @"include_player_ids": @[_idUser]
    //                               }];
};
- (IBAction)sendState:(id)sender {
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
