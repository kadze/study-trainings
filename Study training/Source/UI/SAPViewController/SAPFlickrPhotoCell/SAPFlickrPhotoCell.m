//
//  SAPFlickrPhotoCell.m
//  Study training
//
//  Created by Andrey on 8/15/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import <UIKit/UIImageView.h>
#import "SAPFlickrPhotoCell.h"


@implementation SAPFlickrPhotoCell
@synthesize model = _model;


#pragma mark -
#pragma mark Accessors

- (void)setModel:(UIImage *)model {
    if (_model != model) {
        _model = model;
        
        [self fillWithModel:model];
    }
}

#pragma mark -
#pragma mark SAPModelView

- (void)fillWithModel:(UIImage *)model {
    self.cellImageView.image = model;
}

@end
