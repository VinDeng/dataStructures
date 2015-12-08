//
//  binaryTreeNode.h
//  List
//
//  Created by Vincent_D on 15/10/29.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//
@class binaryTreeNode;

//typedef binaryTreeNode binaryTree;

#import <Foundation/Foundation.h>
#define LINK 0;
#define THREAD 1;


@interface binaryTreeNode : NSObject

@property (nonatomic) id value;
@property (nonatomic) binaryTreeNode * leftChild;
@property (nonatomic) binaryTreeNode * rightChild;
@property (nonatomic, weak) binaryTreeNode * parent;
@property (nonatomic) BOOL leftTag;
@property (nonatomic) BOOL rightTag;


+ (instancetype)treeNodeWithValue:(id)value andParent:(binaryTreeNode *)parentNode;

- (binaryTreeNode *)leftSibling;
- (binaryTreeNode *)rightSibling;

@end
