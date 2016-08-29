//
//  FlickrSearcher.m
//  Study training
//
//  Created by Andrey on 8/12/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "Flickr.h"
#import "AFHttpSessionManager.h"
#import "AFURLResponseSerialization.h"
#import "AFImageDownloader.h"

static bool classVarsInitialzed = NO;
static NSString* apiKey = @"8c3a786f3e4b9f23ba9f4b2c06fce51e";
static AFHTTPSessionManager* afHttpSessionManager;
static AFImageDownloader* afImageDownloader;

static void initializeClassVars() {
    if(classVarsInitialzed) {
        return;
    }
    
    afHttpSessionManager = [AFHTTPSessionManager manager];
    afHttpSessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:0];
    afImageDownloader = [AFImageDownloader defaultInstance];
}

@interface FlickrPhoto()
@property (readwrite, nonatomic, strong) NSString* id;
@property (readwrite, nonatomic) int farm;
@property (readwrite, nonatomic, strong) NSString* server;
@property (readwrite, nonatomic, strong) NSString* secret;
@property (readwrite, nonatomic, strong) UIImage* thumbnail;
@property (readwrite, nonatomic, strong) UIImage* largeImage;

-(NSURL*)flickrImageUrlForSize:(NSString*)size;
@end

@implementation FlickrPhoto

+(void)initialize {
    initializeClassVars();
}

-(instancetype)initWithPhotoID:(NSString *)id farm:(int)farm server:(NSString *)server secret:(NSString *)secret {
    self = [super init];
    if(self) {
        self.id = id;
        self.farm = farm;
        self.server = server;
        self.secret = secret;
        self.thumbnail = nil;
        self.largeImage = nil;
    }
    return self;
}

-(NSURL*)flickrImageUrlForSize:(NSString*)size {
    if(size == nil) {
        size = @"m";
    }
    
    NSString* urlString = [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%@/%@_%@_%@.jpg", self.farm, self.server, self.id, self.secret, size];
    return [NSURL URLWithString:urlString];
}

-(void)loadLargeImageWithCompletionHandler:(void (^)(FlickrPhoto *, NSError *))handler {
    NSURL* url = [self flickrImageUrlForSize:@"b"];
    
    [afImageDownloader
     downloadImageForURLRequest:[NSURLRequest requestWithURL:url]
     success:^(NSURLRequest* request, NSHTTPURLResponse* response, UIImage* responseImage){
         self.largeImage = responseImage;
         handler(self, nil);
     }
     failure:^(NSURLRequest* request, NSHTTPURLResponse* response, NSError* error) {
         handler(self, error);
     }];
}

-(CGSize)sizeToFillWidthOfSize:(CGSize)size {
    if(self.thumbnail == nil) {
        return size;
    }
    
    CGSize imageSize = self.thumbnail.size;
    CGFloat aspectRatio = imageSize.width / imageSize.height;
    CGSize returnSize = size;
    returnSize.height = returnSize.width / aspectRatio;
    
    if(returnSize.height > size.height) {
        returnSize.height = size.height;
        returnSize.width = size.height * aspectRatio;
    }
    
    return returnSize;
}

@end

// -------------------------------------------------------------------------------------------------

@interface FlickrSearchResults()
@property (readwrite, nonatomic, strong) NSString* searchTerm;
@property (readwrite, nonatomic, strong) NSArray<FlickrPhoto*>* searchResults;
@end

@implementation FlickrSearchResults

-(instancetype)initWithSearchTerm:(NSString *)searchTerm searchResults:(NSArray<FlickrPhoto *> *)searchResults {
    self = [super init];
    if(self) {
        self.searchTerm = searchTerm;
        self.searchResults = searchResults;
    }
    return self;
}

@end

// -------------------------------------------------------------------------------------------------

@implementation Flickr

+(void)initialize {
    initializeClassVars();
}

+(void)searchForTerm:(NSString*)searchTerm onSuccess:(void (^)(FlickrSearchResults* searchResults, NSError* error))handler {
    NSString* escapedSearchTerm = [searchTerm stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString* urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&format=json&nojsoncallback=1&per_page=20", apiKey, escapedSearchTerm];
    
    
    NSURLSessionDataTask* dataTask = [afHttpSessionManager
                                      GET:urlString parameters:nil
                                      success:^(NSURLSessionDataTask* dataTask, id responseObject) {
                                          NSDictionary* responseDict = (NSDictionary*)responseObject;
                                          
                                          NSString* stat = responseDict[@"stat"];
                                          NSString* errorString = nil;
                                          
                                          if([stat caseInsensitiveCompare:@"ok"] == NSOrderedSame) {
                                              // success
                                          }else if ([stat caseInsensitiveCompare:@"fail"] == NSOrderedSame) {
                                              errorString = responseDict[@"message"];
                                          }else {
                                              errorString = @"Unknown API response.";
                                          }
                                          
                                          if(errorString != nil) {
                                              NSDictionary* userInfo = @{
                                                                         NSLocalizedDescriptionKey: NSLocalizedString(@"Operation failed.", nil),
                                                                         NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorString, nil),
                                                                         NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"https://www.flickr.com/services/api/explore/flickr.photos.search", nil)
                                                                         };
                                              NSError* apiError = [NSError errorWithDomain:@"Flickr" code:0 userInfo:userInfo];
                                              handler(nil, apiError);
                                              return;
                                          }
                                          
                                          NSArray* photosReceived = responseDict[@"photos"][@"photo"];
                                          NSMutableArray* flickrPhotos = [[NSMutableArray alloc] init];
                                          for(NSDictionary* photoDictionary in photosReceived) {
                                              NSString* photoID = photoDictionary[@"id"];
                                              int farm = [photoDictionary[@"farm"] intValue];
                                              NSString* server = photoDictionary[@"server"];
                                              NSString* secret = photoDictionary[@"secret"];
                                              FlickrPhoto* flickrPhoto = [[FlickrPhoto alloc] initWithPhotoID:photoID farm:farm server:server secret:secret];
                                              
                                              NSURL* flickrThumbnailURL = [flickrPhoto flickrImageUrlForSize:@"m"];
                                              NSData* imageData = [NSData dataWithContentsOfURL:flickrThumbnailURL];
                                              [flickrPhoto setThumbnail:[UIImage imageWithData:imageData]];
                                              
                                              [flickrPhotos addObject:flickrPhoto];
                                          }
                                          
                                          handler([[FlickrSearchResults alloc] initWithSearchTerm:searchTerm searchResults:flickrPhotos], nil);
                                      } failure:^(NSURLSessionDataTask* dataTask, NSError* failure) {
                                          handler(nil, failure);
                                      }];
    [dataTask resume];
}

@end