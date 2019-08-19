//
//  ViewController.m
//  TrItunes
//
//  Created by Tr1Fecta on 07/08/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {
}
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchBar.delegate = self;
    self.requestDone = NO;
    
    
    self.searchResults = [NSMutableArray new];
    self.subtitleArray = [NSMutableArray new];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 137, 414, 759)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cellid";
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.subtitleArray objectAtIndex:indexPath.row];
    
    
    return cell;
}




- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0) {
        
        self.requestDone = NO;
        
        [self.searchBar endEditing:YES];
        
    }
    else {
        searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"+"]; // Changes spaces with + for requests
        
        switch (self.chosenCategory) {
            case movies:
                self.requestUrl = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/search?term=%@&entity=movie", searchText];
                break;
            case ebook:
                self.requestUrl = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/search?term=%@&entity=ebook", searchText];
                break;
            case music:
                self.requestUrl = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/search?term=%@&entity=musicTrack", searchText];
                break;
            case artists:
                self.requestUrl = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/search?term=%@&entity=allArtist", searchText];
                break;
        }
        
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self getRequest];
    
    
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




-(void)getRequest {
    
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.requestUrl]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionTask* dataTask = [session  dataTaskWithRequest:urlRequest completionHandler:^(NSData*  data, NSURLResponse* response, NSError*  error) {
    
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            NSError* parseError = nil;
            self.responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            self.requestDone = YES;
            
            //NSLog(@"URL is: %@", self.requestUrl);
            //NSLog(@"%@", self.responseDictionary[@"results"]);
            [self parseJson];
            [self.table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        }
        else {
            NSLog(@"error");
        }
    }];
    [dataTask resume];
}



- (void)parseJson {
    for (id result in self.responseDictionary[@"results"]) {
        switch (self.chosenCategory) {
            case movies:
                break;
            case ebook:
                break;
            case music:
                [self.searchResults addObject:result[@"trackName"]];
                [self.subtitleArray addObject:result[@"artistName"]];
                break;
            case artists:
                break;
        }
    }
    
}





@end
