//
//  OLGraphArcNode.m
//  List
//
//  Created by Vincent_D on 15/11/13.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "OLGraphArcNode.h"

@implementation OLGraphArcNode

- (instancetype)init
{
    if (self = [super init]) {
        self.sameHeadArc = nil;
        self.sameTailArc = nil;
        self.info = nil;
        self.headVNode = nil;
        self.tailVNode = nil;
    }
    return self;
}



@end
