//
//  binaryTreeNode.m
//  List
//
//  Created by Vincent_D on 15/10/29.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "binaryTreeNode.h"


@implementation binaryTreeNode

+ (instancetype)treeNodeWithValue:(id)value andParent:(binaryTreeNode *)Node;
{
    binaryTreeNode * newNode = [[binaryTreeNode alloc] init];
    newNode.parent = Node;
    newNode.value = value;
    newNode.leftChild = nil;
    newNode.rightChild = nil;
    newNode.leftTag = LINK;
    newNode.rightTag = LINK;
    return newNode;
}

- (binaryTreeNode *)leftSibling
{
    if (!self.parent) {
        return nil;
    }
    
    if (self == self.parent.leftChild) {
        return nil;
    }
    
   return self.parent.leftChild;
}

- (binaryTreeNode *)rightSibling
{
    if (!self.parent) {
        return nil;
    }
    
    if (self == self.parent.rightChild) {
        return nil;
    }
    
    return self.parent.rightChild;
}



@end
