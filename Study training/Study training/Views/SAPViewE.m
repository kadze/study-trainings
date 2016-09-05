//
//  SAPViewE.m
//  Study training
//
//  Created by ASH on 8/31/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "SAPViewE.h"

@implementation SAPViewE

#pragma mark -
#pragma mark Public

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%@ hitTest", NSStringFromClass([self class]));
//    NSLog(@"%@ superView is %@", NSStringFromClass([self class]), NSStringFromClass([self.superview class]));
//    NSLog(@"subviews:");
//    for (UIView *subview in self.subviews) {
//        NSLog(@"    %@", NSStringFromClass([subview class]));
//    }
//    
//    return [super hitTest:point withEvent:event];
//}
//
//
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    BOOL result = [super pointInside:point withEvent:event];
//    NSString *resultString = result ? @"Yes" : @"No";
//    NSLog(@"%@ point inside %@", NSStringFromClass([self class]), resultString);
//    
//    return result;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    NSLog(@"began");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGRect frame = self.frame;
    frame.origin.x = (frame.origin.x) + (location.x - previousLocation.x);
    frame.origin.y = (frame.origin.y) + (location.y - previousLocation.y);
    self.frame = frame;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesEnded:touches withEvent:event];
////    NSLog(@"touchesEnded in %@  with event %@", NSStringFromClass([self class]), event);
//    NSLog(@"ended");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesCancelled:touches withEvent:event];
//    NSLog(@"cancelled");
}

@end
