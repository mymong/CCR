//
//  HelloWorldLayer.m
//  Hammers
//
//  Created by Jason Yang on 13-1-5.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "CCAnimation+helper.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer
{
    CCSprite *seeker1;
    CCSprite *cocosGuy;
    CCSprite *girl;
    CCRepeatForever* girlWalking;
    CCRepeatForever *girlHitDown;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        seeker1 = [CCSprite spriteWithFile:@"seeker.png"];
        seeker1.position = ccp(50, 100);
        [self addChild:seeker1];
        
        cocosGuy = [CCSprite spriteWithFile:@"Icon.png"];
        cocosGuy.position = ccp(200, 300);
        [self addChild:cocosGuy];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World!" fontName:@"Marker Felt" fontSize:24];
        label.position = ccp(200, 20);
        label.color = ccc3(255,0,0);
        label.opacity = 128;
        [self addChild:label];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"girl.plist"];
        {
            CCAnimation *animation = [CCAnimation animationWithSpriteFrame:@"walk" frameCount:4 delay:0.2];
            CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
            girlWalking = [CCRepeatForever actionWithAction:animate];
        }
        {
            CCAnimation *animation = [CCAnimation animationWithSpriteFrame:@"hitDown" frameCount:5 delay:0.2];
            CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
            girlHitDown = [CCRepeatForever actionWithAction:animate];
        }
        
        girl = [CCSprite spriteWithSpriteFrameName:@"walk0.png"];
        girl.position = ccp(200,80);
        [self addChild:girl];
        [girl runAction:girlWalking];
        
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
        
        [self setupMenus];
        
        self.isTouchEnabled = YES;
	}
	return self;
}

- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void)nextFrame:(ccTime)dt
{
    seeker1.position = ccp(seeker1.position.x + 100 * dt, seeker1.position.y);
    if (seeker1.position.x > 480 + 32) {
        seeker1.position = ccp(-32, seeker1.position.y);
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [girl stopAllActions];
    CCAnimation *animation = [CCAnimation animationWithSpriteFrame:@"hitDown" frameCount:5 delay:0.2];
    CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
    girlHitDown = [CCRepeatForever actionWithAction:animate];
    [girl runAction:girlHitDown];
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [girl stopAllActions];
    CCAnimation *animation = [CCAnimation animationWithSpriteFrame:@"walk" frameCount:4 delay:0.2];
    CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
    girlWalking = [CCRepeatForever actionWithAction:animate];
    [girl runAction:girlWalking];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    [cocosGuy stopAllActions];
    id action = [CCMoveTo actionWithDuration:1.0f position:location];
    id action2 = [CCEaseBackOut actionWithAction:action];
    [cocosGuy runAction:action2];
}

- (void)setupMenus
{
    // Create some menu items
	CCMenuItemImage * menuItem1 = [CCMenuItemImage itemWithNormalImage:@"myfirstbutton.png"
                                                         selectedImage: @"myfirstbutton_selected.png"
                                                                target:self
                                                              selector:@selector(doSomethingOne:)];
    
	CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"mysecondbutton.png"
                                                         selectedImage: @"mysecondbutton_selected.png"
                                                                target:self
                                                              selector:@selector(doSomethingTwo:)];
    
    
	CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"mythirdbutton.png"
                                                         selectedImage: @"fps_images.png"
                                                                target:self
                                                              selector:@selector(doSomethingThree:)];
    
    
	// Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    
	// Arrange the menu items vertically
	[myMenu alignItemsVertically];
    
	// add the menu to your scene
	[self addChild:myMenu];
}

- (void) doSomethingOne: (CCMenuItem  *) menuItem
{
	NSLog(@"The first menu was called");
}

- (void) doSomethingTwo: (CCMenuItem  *) menuItem
{
	NSLog(@"The second menu was called");
}

- (void) doSomethingThree: (CCMenuItem  *) menuItem
{
	NSLog(@"The third menu was called");
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
