//
//  tree.m
//  List
//
//  Created by Vincent_D on 15/11/7.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "Tree.h"

@implementation Tree

- (instancetype)init
{
    if (self = [super init]) {
        self.firstChildren = [[NSMutableArray alloc] init];
    }
    return  self;
}

- (NSInteger)depth
{
   NSInteger maxDepth = 0;
    for (TreeNode *tree in self.firstChildren) {

        NSInteger depth = [self heightOfNode:tree];
        maxDepth = (depth > maxDepth) ? depth : maxDepth;

    }
    return maxDepth;
}

- (void)travelThroughFirstChild:(TreeNode *)firstChildNode WithBlock:(void (^)(TreeNode * currentNode))visitBlock
{
    TreeNode *currentNode = firstChildNode;
    while (currentNode) {
        visitBlock(currentNode);
        currentNode = currentNode.parent;
    }
}

- (NSInteger)heightOfNode:(TreeNode *)Node
{
   __block NSInteger height = 0;
    
    [self travelThroughFirstChild:Node WithBlock:^(TreeNode *currentNode) {
        height++;
    }];
    
    return height;
}

- (void)travelWithBlock:(void (^)(TreeNode * currentNode))visitBlock
{
    for (TreeNode *Node in self.firstChildren) {
        [self travelThroughFirstChild:Node WithBlock:visitBlock];
    }
}

@end
