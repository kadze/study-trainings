//
//  main.m
//  test
//
//  Created by Andrey on 7/25/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *separator = @"_";
        NSArray *test = @[@"orbit_2223", @"orbit_22", @"orbit_555", @"orbit_234", @"orbit_1", @"orbit_one", @"orbitOrbit", @"Orbit1", @"orbit_11", @"orbit_orbit_111"];
        NSString *name = @"orbit";
        NSString *regexExpression = [NSString stringWithFormat:@"%@%@%@", name, separator, @"\\d*"];
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexExpression];
        NSArray *result = [test filteredArrayUsingPredicate:filter];
        
        result = [result sortedArrayUsingSelector:@selector(localizedCompare:)];
        
        NSString *lastObject = result.lastObject;
        
        NSRange underscoreRange = [lastObject rangeOfString:separator options:NSBackwardsSearch];
        NSUInteger location = underscoreRange.location;
        NSString *numberString = [lastObject substringFromIndex:++location];
        
        NSInteger lastNameCounter = [numberString integerValue];
        NSInteger nextNameCounter = ++lastNameCounter;
        
        NSString *nextTitle = [NSString stringWithFormat:@"%@%@%ld", name, separator, nextNameCounter];
        
        NSLog(@"%@", result);
        NSLog(@"%@", numberString);
        NSLog(@"%@", nextTitle);
    }
    return 0;
}
