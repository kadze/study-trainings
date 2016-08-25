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
UITextFieldDelegate>

@property (nonatomic, assign) UIEdgeInsets sectionInsets;
@property (nonatomic, strong) NSMutableArray<FlickrSearchResults *> *searches;
@property (nonatomic, strong) Flickr *flickr;

@end

@implementation SAPFlickrPhotosViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    self.sectionInsets = UIEdgeInsetsMake(50, 20, 50, 20);
    self.searches = [NSMutableArray new];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SAPFlickrPhotoCell *cell = [collectionView cellWithClass:[SAPFlickrPhotoCell class] forIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [textField addSubview:activityIndicator];
    activityIndicator.frame = textField.bounds;
    [activityIndicator startAnimating];
    [Flickr searchForTerm:textField.text onSuccess:^(FlickrSearchResults *searchResults, NSError *error) {
        [activityIndicator removeFromSuperview];
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        NSLog(@"Found %ld results for %@", (u_long)searchResults.searchResults.count, searchResults.searchTerm);
        [self.searches insertObject:searchResults atIndex:0];
        [self.collectionView reloadData];
    }];
    
    textField.text = nil;
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark -
#pragma mark Private

- (FlickrPhoto *)photoForIndexPath:(NSIndexPath *)indexPath {
    return self.searches[indexPath.section].searchResults[indexPath.row];
}

@end
