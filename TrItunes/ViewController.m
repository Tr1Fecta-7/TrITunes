//
//  ViewController.m
//  TrItunes
//
//  Created by Tr1Fecta on 07/08/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *table;
}
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 137, 414, 759)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cellid";
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}



- (IBAction)changedSegmentAction:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    self.chosenCategory = control.selectedSegmentIndex;
    
    NSString* string = [[NSString alloc] initWithFormat:@"%ld", self.chosenCategory];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Category Chosen:" message:string preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}





@end
