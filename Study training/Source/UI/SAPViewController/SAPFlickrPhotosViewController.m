//
//  SAPFlickrPhotosViewController.m
//  Study training
//
//  Created by Andrey on 7/9/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "SAPFlickrPhotosViewController.h"

#import "SAPFlickrPhotoCell.h"
#import "SAPSupplementaryView.h"

#import "UICollectionView+SAPExtensions.h"
#import "UINib+SAPExtensions.h"

@interface SAPFlickrPhotosViewController () <
UICollectionViewDataSource,
UICollectionViewDelegate>

@property (nonatomic, assign) UIEdgeInsets sectionInsets;

@end

@implementation SAPFlickrPhotosViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
//    self.sectionInsets = UIEdgeInsetsMake(50, 20, 50, 20);
    Class cellClass = [SAPFlickrPhotoCell class];
    UINib *nib = [UINib nibWithClass:cellClass];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
    
    Class supplementaryViewClass = [SAPSupplementaryView class];
    UINib *supplementaryViewNib = [UINib nibWithClass:supplementaryViewClass];
    NSString *supplementaryViewClassName = NSStringFromClass(supplementaryViewClass);
    [self.collectionView registerNib:supplementaryViewNib
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:supplementaryViewClassName];
    
    UICollectionViewFlowLayout *flowLayout = self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(40, 40);
    flowLayout.headerReferenceSize = CGSizeMake(self.collectionView.bounds.size.width, 60);
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SAPFlickrPhotoCell *cell = [collectionView cellWithClass:[SAPFlickrPhotoCell class] forIndexPath:indexPath];
    cell.model = [self photoForIndexPath:indexPath];
    
    return cell;
}

//the flowLayout headerReferenceSize shouldn't be 0 to make this method be called
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    SAPSupplementaryView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                    withReuseIdentifier:[self supplementaryViewClassName]
                                                                           forIndexPath:indexPath];
    
    return view;
}


#pragma mark -
#pragma mark Private

- (UIImage *)photoForIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:@"image4Cell"];
}

- (Class)supplementaryViewClass {
    return [SAPSupplementaryView class];
}

- (NSString *)supplementaryViewClassName {
    return NSStringFromClass([self supplementaryViewClass]);
}

@end
