//
//  LF_ViewController.h
//  AsyncSocket_02
//
//  Created by Yoshihiro Natsui on 8/15/14.
//  Copyright (c) 2014 Yoshihiro Natsui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
@interface LF_ViewController : UIViewController<GCDAsyncSocketDelegate>

//+ (BOOL)getHost:(NSString **)hostPtr port:(uint16_t *)portPtr fromAddress:(NSData *)address;

@end
