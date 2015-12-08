//
//  OLGraphVNode.m
//  List
//
//  Created by Vincent_D on 15/11/13.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "OLGraphVNode.h"

@implementation OLGraphVNode

- (instancetype)init
{
    if (self = [super init]) {
        self.value = nil;
        self.firstInArc = nil;
        self.firstOutArc = nil;
    }
    return self;
}

+ (instancetype)VNodeWithValue:(id)value
{
    OLGraphVNode *Node = [[OLGraphVNode alloc] init];
    Node.value = value;
    return Node;
}

@end
