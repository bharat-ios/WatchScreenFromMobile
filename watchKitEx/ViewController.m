//
//  ViewController.m
//  watchKitEx
//
//  Created by Mac02 on 15/12/15.
//  Copyright © 2015 DeviBharat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSData *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _data=[NSData new];
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
        NSLog(@"WCSession is supported on phone");
    }
    
    if ([[WCSession defaultSession] isReachable]) {
        //Here is where you will send you data
        NSLog(@"SESSION REACHABLE on phone");
    }
 
    UIPanGestureRecognizer * panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handlePanGesture:)];
    [_myDraggedView addGestureRecognizer:panRecognizer];
  

}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGRect frame = _myDraggedView.frame;
    frame.origin = [gestureRecognizer locationInView:_myDraggedView.superview];
    _myDraggedView.frame = frame;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) session:(nonnull WCSession *)session didReceiveApplicationContext:(nonnull NSDictionary<NSString *,id> *)applicationContext {
    
     NSLog(@"%@", applicationContext);
    
    NSString *item = [applicationContext objectForKey:@"mthOnWatchClick"];
    
    if ([item isEqual:@"Y"]) {
        
//        UIImage *img = [UIImage imageNamed:@"pirate.jpg"];
//        NSData *imageData = UIImagePNGRepresentation(img);
        
        [self mthTakeSnapShot];
        NSString *imageString = [_data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        NSDictionary *applicationDict = [NSDictionary dictionaryWithObject: imageString forKey: @"Test"];
        [[WCSession defaultSession] updateApplicationContext:applicationDict error:nil];

    }
    
}






-(void)mthTakeSnapShot
{

    UIScreen *screen = [UIScreen mainScreen] ;
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *view = [screen snapshotViewAfterScreenUpdates:YES];
    UIGraphicsBeginImageContextWithOptions(screen.bounds.size, NO, 0);
    [keyWindow drawViewHierarchyInRect:keyWindow.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   _data= UIImagePNGRepresentation(image);
//    [_data writeToFile:[NSString stringWithFormat:@"%@/ScreenShot.png",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]] atomically:YES];

}

@end
