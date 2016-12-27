//
//  binaryTreeNode.h
//  List
//
//  Created by Vincent_D on 15/10/29.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//
@class BinaryTreeNode;

//typedef binaryTreeNode binaryTree;

#import <Foundation/Foundation.h>
#define LINK 0;
#define THREAD 1;


@interface BinaryTreeNode : NSObject

@property (nonatomic) id value;
@property (nonatomic) BinaryTreeNode * leftChild;
@property (nonatomic) BinaryTreeNode * rightChild;
@property (nonatomic, weak) BinaryTreeNode * parent;
@property (nonatomic) BOOL leftTag;
@property (nonatomic) BOOL rightTag;


+ (instancetype)treeNodeWithValue:(id)value andParent:(BinaryTreeNode *)parentNode;

- (BinaryTreeNode *)leftSibling;
- (BinaryTreeNode *)rightSibling;

@end
