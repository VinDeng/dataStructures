//
//  tree.m
//  List
//
//  Created by Vincent_D on 15/11/7.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "tree.h"

@implementation tree

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
    for (treeNode *tree in self.firstChildren) {

        NSInteger depth = [self heightOfNode:tree];
        maxDepth = (depth > maxDepth) ? depth : maxDepth;

    }
    return maxDepth;
}

- (void)travelThroughFirstChild:(treeNode *)firstChildNode WithBlock:(void (^)(treeNode * currentNode))visitBlock
{
    treeNode *currentNode = firstChildNode;
    while (currentNode) {
        visitBlock(currentNode);
        currentNode = currentNode.parent;
    }
}

- (NSInteger)heightOfNode:(treeNode *)Node
{
   __block NSInteger height = 0;
    
    [self travelThroughFirstChild:Node WithBlock:^(treeNode *currentNode) {
        height++;
    }];
    
    return height;
}

- (void)travelWithBlock:(void (^)(treeNode * currentNode))visitBlock
{
    for (treeNode *Node in self.firstChildren) {
        [self travelThroughFirstChild:Node WithBlock:visitBlock];
    }
}

@end
