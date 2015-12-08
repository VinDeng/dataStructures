//
//  Queue.m
//  List
//
//  Created by Vincent_D on 15/10/27.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#define MAXLENGTH 1000; //预设最大长度

#import "Queue.h"

@interface Queue ()

@property (nonatomic) List * list;
@property (nonatomic, weak)listNode *front;
@property (nonatomic, weak)listNode *rear;

@property (nonatomic) NSInteger maximumLength;

@end

@implementation Queue

- (instancetype)init
{
    if (self = [super init]) {
        self.list = [[List alloc] init];
        self.overflows = [[NSMutableArray alloc] init];
        self.maximumLength = MAXLENGTH;
        self.front = self.list.head;
        self.rear = self.list.head;
    }
    return self;
}

- (instancetype)initWithMaxLength:(NSInteger)length
{
    self = [[Queue alloc] init];
    self.maximumLength = length;
    return self;
}

- (NSInteger)length
{
    return self.list.length - 1;
}

- (id)Head
{
    if (self.list.head.next) {
        return self.list.head.next.Object;
    }else{
        return nil;
    }
    
}

- (void)enQueue:(id)object
{
        if (self.length < self.maximumLength) {
            [self.list insertObjectAtLastIndex:object];
            self.rear = self.rear.next;
            if (self.list.head == self.front) {
                self.front = self.list.head.next;
            }
        }else{
            [self.overflows addObject:object];
        }
}

- (id)DeQueue
{

    if (self.front == self.list.head) { //空队列
        return nil;
    }else{                              //非空队列

        id returnObject = self.front.Object;
        if (self.front.next) {         //出队后非空
            self.front = self.front.next;
        }else{                         //出队后为空队列
            self.front = self.list.head;
        }
        [self.list removeObjectInIndex:1];
        
        return returnObject;
    }

}

- (void)clearQueue
{
    self.list = nil;
    self.list = [[List alloc] init];
    self.rear = self.list.head;
    self.front = self.list.head;
}

- (void)travelQueue:(void (^)(id))visitBlock
{
    if (visitBlock) {
        [self.list travelList:^(listNode *currentNode, NSInteger index) {
            visitBlock(currentNode.Object);
        }];
    }
}

@end
