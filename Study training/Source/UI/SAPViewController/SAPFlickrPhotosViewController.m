//
//  SAPFlickrPhotosViewController.m
//  Study training
//
//  Created by Andrey on 7/9/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "SAPFlickrPhotosViewController.h"

#import "Flickr.h"
#import "SAPFlickrPhotoCell.h"

#import "UICollectionView+SAPExtensions.h"

static NSString * const kSAPReuseIdentifier = @"FlickrCell";

@interface SAPFlickrPhotosViewController () <
UICollectionViewDataSource,
UICollectionViewDelegate,
UITextFieldDelegate,
UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign) UIEdgeInsets sectionInsets;
@property (nonatomic, strong) NSMutableArray<FlickrSearchResults *> *searches;
@property (nonatomic, strong) Flickr *flickr;

@end

@implementation SAPFlickrPhotosViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [self initializeSearchBar];
    self.sectionInsets = UIEdgeInsetsMake(50, 20, 50, 20);
    self.searches = [NSMutableArray new];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searches[section].searchResults.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.searches.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SAPFlickrPhotoCell *cell = [collectionView cellWithClass:[SAPFlickrPhotoCell class] forIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [searchBar addSubview:activityIndicator];
    activityIndicator.frame = searchBar.bounds;
    [activityIndicator startAnimating];
    [Flickr searchForTerm:searchBar.text onSuccess:^(FlickrSearchResults *searchResults, NSError *error) {
        [activityIndicator removeFromSuperview];
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        NSLog(@"Found %ld results for %@", (u_long)searchResults.searchResults.count, searchResults.searchTerm);
        [self.searches insertObject:searchResults atIndex:0];
        [self.collectionView reloadData];
    }];
    
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark Private

- (FlickrPhoto *)photoForIndexPath:(NSIndexPath *)indexPath {
    return self.searches[indexPath.section].searchResults[indexPath.row];
}

- (void)initializeSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.searchBar = searchBar;
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 44.0)];
    searchBarView.autoresizingMask = 0;
    searchBar.delegate = self;
    [searchBarView addSubview:searchBar];
    self.navigationItem.titleView = searchBarView;
}

@end
