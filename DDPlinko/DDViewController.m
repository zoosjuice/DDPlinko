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
    
    UIDynamicAnimator *animator;
    UIGravityBehavior *gravity;
    UICollisionBehavior *collision;
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
    
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    gravity = [UIGravityBehavior new];
    [animator addBehavior:gravity];
    
    collision = [UICollisionBehavior new];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collision];
    
    //Add score boundaries
    [collision addBoundaryWithIdentifier:@"bottomBar" fromPoint:CGPointMake(0, self.bottomBar.frame.origin.y) toPoint:CGPointMake(320, self.bottomBar.frame.origin.y)];
    
    //Layout the pegs in a grid
    CGPoint offset = CGPointMake(40, 100);
    for (int x = 0; x<8; x++) {
        for (int y = 0; y<10; y++) {
            
            float xOffset = y%2 ? 0 : 15;
            
            DDPegView *peg = [[DDPegView alloc] initWithFrame:CGRectMake(offset.x + x * 30 + xOffset, offset.y + y * 30, 14, 14)];
            
            [self.view addSubview:peg];
            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:peg.frame];
            
            [collision addBoundaryWithIdentifier:@"id" forPath:path];
        }
    }
    
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
    CGPoint location = [[touches anyObject] locationInView:self.view];
    
    if (CGRectContainsPoint(self.mainLabel.frame, location)) {
        //Spawn a ball at the touch
        float size = 10;
        UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(location.x - size/2, location.y - size/2, size, size)];
        ball.backgroundColor = [UIColor blackColor];
        ball.layer.cornerRadius = 6;
        [self.view addSubview:ball];
        
        [gravity addItem:ball];
        [collision addItem:ball];
    }

}

@end
