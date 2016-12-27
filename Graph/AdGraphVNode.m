//
//  AdGraphVNode.m
//  List
//
//  Created by Vincent_D on 15/11/20.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "AdGraphVNode.h"

@implementation AdGraphVNode

- (instancetype)init
{
    if (self = [super init]) {
        self.value = nil;
        self.firstArcNode = nil;
    }
    return self;
}

+ (instancetype)VNodeWithValue:(id)value
{
    AdGraphVNode *Node = [[AdGraphVNode alloc] init];
    Node.value = value;
    return Node;
}

@end
