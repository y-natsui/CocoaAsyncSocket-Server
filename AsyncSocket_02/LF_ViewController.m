//
//  LF_ViewController.m
//  AsyncSocket_02
//
//  Created by Yoshihiro Natsui on 8/15/14.
//  Copyright (c) 2014 Yoshihiro Natsui. All rights reserved.
//

#import "LF_ViewController.h"
#import <AudioToolbox/AudioToolbox.h>


@interface LF_ViewController ()

@end

@implementation LF_ViewController{
    //メッセージ表示用ラベル
    IBOutlet UILabel *lblMsg;
    GCDAsyncSocket *asyncSocket;
    NSMutableArray *connectedSockets;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //ソケットを作成
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    connectedSockets = [[NSMutableArray alloc] init];
    //ソケット作成失敗
    if (!asyncSocket) {
        NSLog(@"ソケットの作成に失敗");
    } else {
        NSLog(@"ソケットの作成に成功");
        NSError *error = nil;
        uint16_t port = 20000;     
        if(![asyncSocket acceptOnPort:port error:&error]){
            NSLog(@"Accept失敗");
        }else{
            NSLog(@"接続待ちです");
        }
    }
    
    

}


#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    NSLog(@"Accepted new Socket from %@:%hu",[newSocket connectedHost],[newSocket connectedPort]);
    NSLog(@"接続が完了しました");
    
    [connectedSockets addObject:newSocket];
    [newSocket readDataWithTimeout:5 tag:0];
    [newSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:5 tag:0];
    
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    AudioServicesPlaySystemSound(1000);
    NSLog(@"読み込み完了！");
    lblMsg.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"New message from client:%@",lblMsg.text);
}

//-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
//    asyncSocket = nil;
//    asyncSocket.delegate = nil;
//}


-(void)dealloc{
    [asyncSocket setDelegate:nil];
    [asyncSocket disconnect];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
