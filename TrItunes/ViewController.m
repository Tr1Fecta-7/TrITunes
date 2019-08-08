//
//  ViewController.m
//  TrItunes
//
//  Created by Tr1Fecta on 07/08/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)changedSegmentAction:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    self.chosenCategory = control.selectedSegmentIndex;
}
@end
