//
//  ExperimentView.m
//  Experiment
//
//  Created by Terry Lin on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ExperimentView.h"
#import "UIImage+SplitImageIntoTwoParts.h"
@implementation ExperimentView
@synthesize image = _image;
@synthesize isSpliting = _isSpliting;
@synthesize left = _left;
@synthesize right = _right;




-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"split"] && finished) {
        self.image.hidden = NO;
        [self.left removeFromSuperview];
        [self.right removeFromSuperview];
    }  
}
-(void)pinch:(UIPinchGestureRecognizer*)recognizer{
    self.image.userInteractionEnabled = YES;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (recognizer.scale>1) {
            
            self.isSpliting = YES;
            NSArray *array = [UIImage splitImageIntoTwoParts:self.image.image point:CGPointMake(self.frame.size.width/2, 0)];
            if (!self.left) {
                self.left = [[UIImageView alloc] initWithImage:[array objectAtIndex:0]];
                self.right = [[UIImageView alloc] initWithImage:[array objectAtIndex:1]];
                self.left.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
                self.right.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
                [self addSubview:self.left];
                [self addSubview:self.right];
                self.left.hidden = YES;
                self.right.hidden = YES;
            }
            
            
        }else{
            self.left.hidden = NO;
            self.right.hidden = NO;
        }
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        
        if (recognizer.scale>1) {
            [self.image setHidden:YES];
            self.left.hidden = NO;
            self.right.hidden = NO;
            [UIView animateWithDuration:0.5 animations:^{
                
                self.left.frame = CGRectMake( -self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
                self.right.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width/2, self.frame.size.height);
            }completion:^(BOOL finished) {
                _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
                [self addGestureRecognizer:_tap];
            }];
            self.myScale();
        }else{
            [self.image setHidden:YES];
            self.left.hidden = NO;
            self.right.hidden = NO;
            [UIView animateWithDuration:0.5 animations:^{
                
                self.left.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
                self.right.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
            }completion:^(BOOL finished) {
               
            }];
        }
        
    }
}
-(void)pinch222:(UIPinchGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (recognizer.scale>1) {
            self.isSpliting = YES;
            NSArray *array = [UIImage splitImageIntoTwoParts:self.image.image point:CGPointMake(0, 0)];
            self.left = [[UIImageView alloc] initWithImage:[array objectAtIndex:0]];
            self.right = [[UIImageView alloc] initWithImage:[array objectAtIndex:1]];
            [self addSubview:self.left];
            [self addSubview:self.right];
            [self.image setHidden:YES];
            
        }else{
            self.isSpliting = NO;
        }        
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (self.isSpliting) {
            self.left.transform = CGAffineTransformMakeTranslation(-160*(recognizer.scale-1), 0);
            self.right.transform = CGAffineTransformMakeTranslation(160*(recognizer.scale-1), 0);            
        }
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        [UIView beginAnimations:@"split" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        self.left.transform = CGAffineTransformIdentity;
        self.right.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];

    }

}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test6.jpg"]];
        self.image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        self.image.center = self.center;//CGPointMake(160, 240);
        [self addSubview:self.image];
        
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [self addGestureRecognizer:pinchRecognizer];
        
        
        
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.left.frame = CGRectMake( 0, 0, self.frame.size.width/2, self.frame.size.height);
        self.right.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
    }completion:^(BOOL finished) {
        
       // [self performSelector:@selector(hidde) withObject:self afterDelay:1];
        [self.image setHidden:NO];
        self.left.hidden = YES;
        self.right.hidden = YES;
        [self.image removeGestureRecognizer:_tap];
        _tap = nil;
    }];
}
- (void)hidde{
     self.image.userInteractionEnabled = YES;
    [self.image setHidden:NO];
    self.left.hidden = YES;
    self.right.hidden = YES;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
