//
//  binaryTreeNode.m
//  List
//
//  Created by Vincent_D on 15/10/29.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "BinaryTreeNode.h"


@implementation BinaryTreeNode

+ (instancetype)treeNodeWithValue:(id)value andParent:(BinaryTreeNode *)Node;
{
    BinaryTreeNode * newNode = [[BinaryTreeNode alloc] init];
    newNode.parent = Node;
    newNode.value = value;
    newNode.leftChild = nil;
    newNode.rightChild = nil;
    newNode.leftTag = LINK;
    newNode.rightTag = LINK;
    return newNode;
}

- (BinaryTreeNode *)leftSibling
{
    if (!self.parent) {
        return nil;
    }
    
    if (self == self.parent.leftChild) {
        return nil;
    }
    
   return self.parent.leftChild;
}

- (BinaryTreeNode *)rightSibling
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
