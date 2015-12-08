//
//  Queue.h
//  List
//
//  Created by Vincent_D on 15/10/27.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"


@interface Queue : NSObject

@property (nonatomic) NSInteger length;
@property (nonatomic) NSMutableArray *overflows;        //溢出量存放处

- (instancetype)initWithMaxLength:(NSInteger)length;

- (void)clearQueue;

- (id)Head;        //查看队头元素
- (void)enQueue:(id)object; //元素入队，超过最大量则入溢出区
- (id)DeQueue;            //元素出队

- (void)travelQueue:(void (^)(id object))visitBlock;


@end
