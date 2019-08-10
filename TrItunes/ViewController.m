//
//  ViewController.m
//  TrItunes
//
//  Created by Tr1Fecta on 07/08/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {
    UITableView *table;
    
    NSMutableArray* searchResults;
    
    NSDictionary* responseDictionary;
}
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchBar.delegate = self;
    self.requestDone = NO;
    
    searchResults = [NSMutableArray new];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 137, 414, 759)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.requestDone)
        return searchResults.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cellid";
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}




- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0) {
        
        self.requestDone = NO;
        
        [self.searchBar endEditing:YES];
        
    }
    else {
        NSString* requestUrl;
        searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"+"]; // Changes spaces with + for requests
        
        switch (self.chosenCategory) {
            case movies:
                requestUrl = [[NSString alloc] initWithFormat:@""];
                break;
            case tvShows:
                requestUrl = [[NSString alloc] initWithFormat:@""];
                break;
            case ebook:
                requestUrl = [[NSString alloc] initWithFormat:@""];
                break;
            case music:
                requestUrl = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/search?term=%@&entity=musicTrack", searchText];
                break;
            case artists:
                requestUrl = [[NSString alloc] initWithFormat:@""];
                break;
        }
        
        [self getRequest:requestUrl];
    }
    
    
}

- (IBAction)changedSegmentAction:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    self.chosenCategory = control.selectedSegmentIndex;
    
    
    // Test if correct category has been chosen, will be removed later
    NSString* string = [[NSString alloc] initWithFormat:@"%ld", self.chosenCategory];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Category Chosen:" message:string preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}




-(void)getRequest:(NSString *)url {
    
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionTask* dataTask = [session  dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse* response, NSError* error) {
    
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            NSError* parseError = nil;
            self->responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        }
        else {
            NSLog(@"error");
        }
        
    }];
    [dataTask resume];
}








@end
