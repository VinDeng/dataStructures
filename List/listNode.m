//
//  listNode.m
//  List
//
//  Created by Vincent_D on 15/10/21.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "listNode.h"

@implementation listNode
//- (listNode *)creatList
//{
//
//}


- (instancetype)init  //禁止用户直接操纵结点生产
{
    return nil;
}

+ (instancetype)creatNodeWithObject:(id)Object
{
    listNode *node = [[listNode alloc] initPrivate];
    
    node.Object = Object;
    
    return node;
}

- (instancetype)initPrivate  //私有实现方法
{
    if (self = [super init]) {
        // do something..
    }
    return self;
}

- (void)dealloc
{
//    NSLog(@"node where object = %@ release",self.Object);  //内存泄露测试代码
}

@end


