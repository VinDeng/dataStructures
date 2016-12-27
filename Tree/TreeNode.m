//
//  treeNode.m
//  List
//
//  Created by Vincent_D on 15/11/7.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

+ (instancetype)treeNodeWithValue:(id)value andParent:(TreeNode *)Node;
{
    TreeNode * newNode = [[TreeNode alloc] init];
    newNode.parent = Node;
    newNode.value = value;
    return newNode;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.parent = nil;
        self.value = nil;
    }
    return self;
}


@end
