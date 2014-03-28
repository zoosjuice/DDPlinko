//
//  DDViewController.m
//  DDPlinko
//
//  Created by David de Jesus on 3/22/14.
//  Copyright (c) 2014 zoosjuice. All rights reserved.
//

#import "DDViewController.h"
#import "DDPegView.h"

@interface DDViewController ()
{
    NSMutableArray *viewArray;
}

@property (weak, nonatomic) IBOutlet UIView *pegView;
@property (weak, nonatomic) IBOutlet UIView *pointCube1;
@property (weak, nonatomic) IBOutlet UIView *pointCube2;
@property (weak, nonatomic) IBOutlet UIView *pointCube3;
@property (weak, nonatomic) IBOutlet UIView *pointCube4;

@property (weak, nonatomic) IBOutlet UILabel *pointLabel1;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel2;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel3;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel4;

@property (nonatomic, strong) UIDynamicAnimator *aNimator;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    viewArray = [NSMutableArray new];

//    for (int i = 0; i <= 20; i++) {
//        DDPegView *aview = [[DDPegView alloc] initWithFrame:CGRectMake([self randomPointInRect:self.view.frame].x, [self randomPointInRect:self.pegView.frame].y, 20, 20)];
//        aview.alpha = 5.0;
//        aview.backgroundColor = [UIColor clearColor];
//        [self.view addSubview:aview];
//        [viewArray addObject:aview];
//    }
    
    self.pointCube1.layer.cornerRadius = 20;
    self.pointCube2.layer.cornerRadius = 20;
    self.pointCube3.layer.cornerRadius = 20;
    self.pointCube4.layer.cornerRadius = 20;

    self.pointLabel1.text = [NSString stringWithFormat:@"%i", [self randomInt]];
    self.pointLabel2.text = [NSString stringWithFormat:@"%i", [self randomInt]];
    self.pointLabel3.text = [NSString stringWithFormat:@"%i", [self randomInt]];
    self.pointLabel4.text = [NSString stringWithFormat:@"%i", [self randomInt]];

	// Do any additional setup after loading the view, typically from a nib.
}

- (NSUInteger)randomInt
{
    NSUInteger i = arc4random()%100;
    return i;
}

- (CGPoint)randomPointInRect:(CGRect)r
{
    CGPoint p = r.origin;
    
    p.x += arc4random() % (int)r.size.width;
    p.y += arc4random() % (int)r.size.height;
    
    return p;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
    aView.backgroundColor = [UIColor grayColor];
    aView.layer.cornerRadius = 7;
    
    UITouch *aTouch = [touches anyObject];
    CGPoint touchPoint = [aTouch locationInView:self.view];
    aView.center = touchPoint;
    if (CGRectContainsPoint(self.mainLabel.frame, touchPoint)) {
        
        [self.view addSubview:aView];
        self.aNimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[aView]];
        CGVector vector = CGVectorMake(0.0, 1.0);
        [gravity setGravityDirection:vector];
        [self.aNimator addBehavior:gravity];
        int i = 0;
        for (DDPegView *view in self.pegView.subviews) {
            UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[aView]];
            UIBezierPath *bumperPath = [UIBezierPath bezierPathWithOvalInRect:view.frame];
            [collisionBehavior addBoundaryWithIdentifier:@"Bumper" forPath:bumperPath];
            [collisionBehavior setTranslatesReferenceBoundsIntoBoundary:YES];
            [collisionBehavior setCollisionMode:UICollisionBehaviorModeEverything];
            [self.aNimator addBehavior:collisionBehavior];
            i++;
            NSLog(@"%i", i);
        }
        
        
        UIDynamicItemBehavior *propertiesBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[aView]];
        propertiesBehavior.elasticity = .20f;
        
        [self.aNimator addBehavior:propertiesBehavior];
    }
    

    

}

@end
