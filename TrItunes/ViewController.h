//
//  ViewController.h
//  TrItunes
//
//  Created by Tr1Fecta on 07/08/2019.
//  Copyright © 2019 Tr1Fecta. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController

// METHODS
- (IBAction)changedSegmentAction:(id)sender;

- (void)getRequest:(NSString *)url;


// PROPERTIES

typedef NS_ENUM(NSInteger, CategoryChosen) {movies = 0, tvShows, ebook, music, artists};

@property (nonatomic, assign) CategoryChosen chosenCategory;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property BOOL requestDone;

@end
