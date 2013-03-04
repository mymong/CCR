//
//  CCAnimation+helper.m
//  Hammers
//
//  Created by Jason Yang on 13-1-14.
//
//

#import "CCAnimation+helper.h"
#import "cocos2d.h"

@implementation CCAnimation (helper)

+ (id)animationWithFile:(NSString *)name frameCount:(NSUInteger)frameCount delay:(float)delay
{
    NSParameterAssert(name);
    
    NSMutableArray* frames = [NSMutableArray array];
	for (int i = 0; i < frameCount; i ++) {
        NSString *filePath = [NSString stringWithFormat:@"%@%i.png", name, i];
		CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:filePath];
        NSParameterAssert(texture);
        if (!texture)
            return nil;
        
        CGRect rect = CGRectZero;
		rect.size = texture.contentSize;
		CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture rect:rect];
        
		[frames addObject:frame];
	}
    
    return  [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

+ (id)animationWithSpriteFrame:(NSString *)name frameCount:(NSUInteger)frameCount delay:(float)delay
{
    NSParameterAssert(name);
    
	NSMutableArray* frames = [NSMutableArray array];
	for (int i = 0; i < frameCount; i ++) {
        NSString *frameName = [NSString stringWithFormat:@"%@%i.png", name, i];
		CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        NSParameterAssert(frame);
        if (!frame)
            return nil;
        
		[frames addObject:frame];
	}
    
	return  [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

@end
