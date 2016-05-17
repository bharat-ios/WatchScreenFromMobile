//
//  InterfaceController.m
//  watchKitEx WatchKit Extension
//
//  Created by Mac02 on 15/12/15.
//  Copyright © 2015 DeviBharat. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (strong, nonatomic) IBOutlet WKInterfaceImage *image;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
        NSLog(@"WCSession is supported on Watch");
    }
    
    if ([[WCSession defaultSession] isReachable]) {
        //Here is where you will send you data
         NSLog(@"SESSION REACHABLE on watch");
    }
    
    
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                                      selector: @selector(callAfterSixtySecond:) userInfo: nil repeats: YES];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (void) session:(nonnull WCSession *)session didReceiveApplicationContext:(nonnull NSDictionary<NSString *,id> *)applicationContext {
    
  //  NSLog(@"%@", applicationContext);

    NSString *item = [applicationContext objectForKey:@"Test"];

    NSData *data = [[NSData alloc]initWithBase64EncodedString:item options:NSDataBase64DecodingIgnoreUnknownCharacters];
    self.image.image = [UIImage imageWithData:data];

}

-(void) callAfterSixtySecond:(NSTimer*) t
{
    WCSession *session = [WCSession defaultSession];
    NSError *error;
    [session updateApplicationContext:@{@"mthOnWatchClick": @"Y"} error:&error];

}




@end



