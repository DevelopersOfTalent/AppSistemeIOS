//
//  ExitViewController.m
//  Appsisteme
//
//  Created by Andrea Cerrato on 29/5/16.
//  Copyright © 2016 Alumno. All rights reserved.
//

#import "ExitViewController.h"

@interface ExitViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ExitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0         // El timer se ejcuta cada segundo
                                             target:self        // Se ejecuta este timer en este view
                                           selector:@selector(finishApp)      // Se ejecuta el método contar
                                           userInfo:nil
                                            repeats:NO];
}

-(void) finishApp{
    
    exit(1);
}

@end
