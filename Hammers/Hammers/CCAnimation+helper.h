//
//  CCAnimation+helper.h
//  Hammers
//
//  Created by Jason Yang on 13-1-14.
//
//

#import "CCAnimation.h"

@interface CCAnimation (helper)

+ (id)animationWithFile:(NSString *)name frameCount:(NSUInteger)frameCount delay:(float)delay;
+ (id)animationWithSpriteFrame:(NSString *)name frameCount:(NSUInteger)frameCount delay:(float)delay;

@end
