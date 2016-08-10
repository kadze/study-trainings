//
//  SAPFlickrPhotosViewController.m
//  Study training
//
//  Created by Andrey on 7/9/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "SAPFlickrPhotosViewController.h"

static NSString * const kSAPReuseIdentifier = @"FlickrCell";

@interface SAPFlickrPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

@end

@implementation SAPFlickrPhotosViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    self.sectionInsets = UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark -
#pragma mark UICollectionViewDelegate


@end
