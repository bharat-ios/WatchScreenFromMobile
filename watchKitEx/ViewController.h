//
//  ViewController.h
//  watchKitEx
//
//  Created by Mac02 on 15/12/15.
//  Copyright © 2015 DeviBharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WatchConnectivity/WatchConnectivity.h>
@interface ViewController : UIViewController<WCSessionDelegate>
@property (strong, nonatomic) IBOutlet UIView *myDraggedView;


@end

