//
//  YHSocket.m
//  SocketDemo
//
//  Created by victorLiu on 2018/3/9.
//  Copyright © 2018年 刘勇虎. All rights reserved.
//

#import "YHSocket.h"

@interface YHSocket ()<GCDAsyncSocketDelegate>

@end

@implementation YHSocket
+ (YHSocket *)shareYHSocket{
    static   YHSocket *yhSoct ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    yhSoct = [[YHSocket alloc]init];
        
    });
    return yhSoct;
}

-(GCDAsyncSocket *)shareAsyncSocket{
    if (!_shareAsyncSocket) {
//        _shareAsyncSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

           _shareAsyncSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _shareAsyncSocket;
}

- (void)connectHost:(NSString *)host port:(unsigned int)port{
    NSError *error;
   [[YHSocket shareYHSocket].shareAsyncSocket  connectToHost:host onPort:port error:&error];
    
    NSLog(@"shareAsyncSocket %@",[YHSocket shareYHSocket].shareAsyncSocket );
    if (error) {
        NSLog(@"socket connect error = %@",error);
    }else{
             [[YHSocket shareYHSocket].shareAsyncSocket readDataWithTimeout:-1 tag:0];
       
    }
}

- (void)sendData:(NSData *)data{
    [[YHSocket shareYHSocket].shareAsyncSocket writeData:data withTimeout:-1 tag:100];
}

- (void)disConnect{
    [[YHSocket shareYHSocket].shareAsyncSocket disconnect];
}

-(BOOL)connectIsActivty{
    return [YHSocket shareYHSocket].shareAsyncSocket.isConnected;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"didConnectToHost");
}
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"didReadData");
    if ([_delegate respondsToSelector:@selector(YHSorcktReadData:)]) {
        [_delegate YHSorcktReadData:data];
    }
    [[YHSocket shareYHSocket].shareAsyncSocket readDataWithTimeout:10 tag:0];
}


- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    NSLog(@"didAcceptNewSocket");
}

- (void)socketDidCloseReadStream:(GCDAsyncSocket *)sock{
        NSLog(@"didAcceptNewSocket");
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err{
        NSLog(@"didAcceptNewSocket");
}
@end
