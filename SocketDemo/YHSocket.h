//
//  YHSocket.h
//  SocketDemo
//
//  Created by victorLiu on 2018/3/9.
//  Copyright © 2018年 刘勇虎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@protocol YHSocketDelegate <NSObject>

- (void)YHSorcktReadData:(NSData *)data;

@end

@interface YHSocket : NSObject
@property(strong,nonatomic)GCDAsyncSocket *shareAsyncSocket;
@property(assign,nonatomic)BOOL connectIsActivty;
@property(assign,nonatomic)id<YHSocketDelegate> delegate;


+ (YHSocket *)shareYHSocket;
- (void)connectHost:(NSString *)host port:(unsigned int)port;
- (void)sendData:(NSData *)data;
- (void)disConnect;


@end
