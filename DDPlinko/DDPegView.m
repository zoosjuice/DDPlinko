//
//  DDPegView.m
//  DDPlinko
//
//  Created by David de Jesus on 3/22/14.
//  Copyright (c) 2014 zoosjuice. All rights reserved.
//

#import "DDPegView.h"

#define LINE_WIDTH .5

@implementation DDPegView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, LINE_WIDTH/2, LINE_WIDTH/2)];
    [[UIColor blueColor] setStroke];
    [[UIColor purpleColor] setFill];
    ovalPath.lineWidth = LINE_WIDTH;
    [ovalPath stroke];
//    [ovalPath fill];
}

@end
