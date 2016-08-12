//
//  FlickrSearcher.h
//  Study training
//
//  Created by Andrey on 8/12/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FlickrSearchResults;
@class FlickrPhoto;


@interface Flickr : NSObject
+(void)searchForTerm:(NSString*)searchTerm onSuccess:(void (^)(FlickrSearchResults* searchResults, NSError* error))handler;
@end


@interface FlickrSearchResults : NSObject
@property (readonly, nonatomic, strong) NSString* searchTerm;
@property (readonly, nonatomic, strong) NSArray<FlickrPhoto*>* searchResults;

-(instancetype)initWithSearchTerm:(NSString*)searchTerm searchResults:(NSArray<FlickrPhoto*>*)searchResults;
@end


@interface FlickrPhoto : NSObject
@property (readonly, nonatomic, strong) NSString* id;
@property (readonly, nonatomic) int farm;
@property (readonly, nonatomic, strong) NSString* server;
@property (readonly, nonatomic, strong) NSString* secret;
@property (readonly, nonatomic, strong) UIImage* thumbnail;
@property (readonly, nonatomic, strong) UIImage* largeImage;

-(instancetype)initWithPhotoID:(NSString*)id farm:(int)farm server:(NSString*)server secret:(NSString*)secret;
-(void)loadLargeImageWithCompletionHandler:(void(^)(FlickrPhoto* flickrPhoto, NSError* error))handler;
-(CGSize)sizeToFillWidthOfSize:(CGSize)size;
@end