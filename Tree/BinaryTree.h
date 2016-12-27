//
//  binaryTree.h
//  List
//
//  Created by Vincent_D on 15/10/29.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTreeNode.h"
#import "Stack.h"

@interface BinaryTree : NSObject

@property (nonatomic) BinaryTreeNode * root;

@property (nonatomic) NSInteger depth;

- (NSInteger)depth;

+ (instancetype)treeWithArray:(NSArray *)array;
+ (instancetype)treeWithPreSequence:(NSArray *)preSequence andInSequence:(NSArray *)inSequence;


- (void)preOrderTraverseWithBlock:(void (^)(BinaryTreeNode
                                            * currentNode))visitBlock;//先序，下面分别为中序和后序
- (void)inOrderTraverseWithBlock:(void(^)(BinaryTreeNode *currentNode))visitBlock;

- (void)postOrderTraverseWithBlock:(void(^)(BinaryTreeNode *currentNode))visitBlock;

#pragma mark-
#pragma mark线索化方法
- (void)preOrderThreading; //先序线索化
- (void)inOrderThreading; //中序线索化
- (void)postOrderThreading; //后序线索化
- (void)unthreading; //去线索化

@end
