//
//  binaryTree.m
//  List
//
//  Created by Vincent_D on 15/10/29.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "binaryTree.h"

typedef enum : NSUInteger {
    NoneThreaded,
    preThreaded,
    inOrderThreaded,
    postOrderThreaded,
} threadType;

@interface binaryTree ()

@property (nonatomic) threadType threadType;
@property (nonatomic) binaryTreeNode* threadTree;

@end

@implementation binaryTree

- (instancetype)init
{
    if (self = [super init]) {
        self.root = [binaryTreeNode treeNodeWithValue:nil andParent:nil];
        self.threadType = NoneThreaded;
        self.threadTree = nil;
    }
    return self;
}

+ (instancetype)treeWithArray:(NSArray *)arr
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:arr];
    
    binaryTree *tree = [[binaryTree alloc] init];
    
    tree.root = [tree preOrderCreatTreeAtNode:tree.root withArray:array];
    
    return tree;
    
}

- (binaryTreeNode *)preOrderCreatTreeAtNode:(binaryTreeNode *)Node withArray:(NSMutableArray *)array
{
    if (!array.count )  {
        return nil;
    }
    
    if (array.firstObject == [NSNull null]) {
        [array removeObject:array.firstObject];
        return nil;
    }
    
    Node = [binaryTreeNode treeNodeWithValue:array.firstObject andParent:nil];

    [array removeObject:array.firstObject];

    Node.leftChild = [self preOrderCreatTreeAtNode:Node withArray:array];
    Node.rightChild = [self preOrderCreatTreeAtNode:Node withArray:array];
    
    if (Node.leftChild) {
        Node.leftChild.parent = Node;
    }
    
    if (Node.rightChild) {
        Node.rightChild.parent = Node;
    }
    
    return Node;

}

+ (instancetype)treeWithPreSequence:(NSArray *)preSequence andInSequence:(NSArray *)inSequence
{
    
    NSSet *preSet = [NSSet setWithArray:preSequence];
    NSSet *inSet = [NSSet setWithArray:inSequence];
    
    BOOL isCorrect = [preSet isEqualToSet:inSet];
    
    if (!isCorrect) {
        NSLog(@"Sequence contents different");
        return nil;
    }
    
    binaryTree *tree = [[binaryTree alloc] init];
    
    tree.root = [tree preOrderCreatTreeAtNode:tree.root WithPreSequence:preSequence andInSequence:inSequence];
    
    return tree;
}

- (binaryTreeNode *)preOrderCreatTreeAtNode:(binaryTreeNode *)Node WithPreSequence:(NSArray *)preSequence andInSequence:(NSArray *)inSequence
{
    if (!preSequence.count) {
        return nil;
    }
    
    NSInteger rootIndex = [inSequence indexOfObject:preSequence.firstObject];
    
    NSInteger index = 0;
    
    NSMutableArray *leftChildInSequence = [[NSMutableArray alloc] init];
    while (leftChildInSequence.count < rootIndex) {
        [leftChildInSequence addObject:[inSequence objectAtIndex:index]];
        index++;
    }
    index = 0;
    
    NSMutableArray *rightChildInsequence = [[NSMutableArray alloc] init];
    while (rightChildInsequence.count < (inSequence.count - rootIndex - 1)) {
        [rightChildInsequence addObject:[inSequence objectAtIndex:(rootIndex + index + 1)]];
        index++;
    }
    index = 0;
    
    NSMutableArray *leftChildPreSequence = [[NSMutableArray alloc] init];
    while (leftChildPreSequence.count < leftChildInSequence.count) {
        [leftChildPreSequence addObject:[preSequence objectAtIndex:(index + 1)]];
        index++;
    }
    index = 0;
    
    NSMutableArray *rightChildPreSequence = [[NSMutableArray alloc] init];
    while (rightChildPreSequence.count < rightChildInsequence.count) {
        [rightChildPreSequence addObject:[preSequence objectAtIndex:(leftChildPreSequence.count + index + 1)]];
        index ++;
    }
    
    Node = [binaryTreeNode treeNodeWithValue:preSequence.firstObject andParent:nil];
    
    Node.leftChild = [self preOrderCreatTreeAtNode:Node.leftChild WithPreSequence:leftChildPreSequence andInSequence:leftChildInSequence];
    Node.rightChild = [self preOrderCreatTreeAtNode:Node.rightChild WithPreSequence:rightChildPreSequence andInSequence:rightChildInsequence];
    
    if (Node.leftChild) {
        Node.leftChild.parent = Node;
    }
    if (Node.rightChild) {
        Node.rightChild.parent = Node;
    }
    
    return Node;
}

- (NSInteger)depth
{
    return [self depthOfNode:self.root];
}

- (NSInteger)depthOfNode:(binaryTreeNode *)node
{
    if (!node) {
        return 0;
    }
    NSInteger leftDepth = [self depthOfNode:node.leftChild];
    NSInteger rightDepth = [self depthOfNode:node.rightChild];
    
    return ( (leftDepth > rightDepth)?(leftDepth+1):(rightDepth+1) );
}

- (void)insertValueByFullBinaryTreeMode:(id)value
{
    binaryTreeNode* currentNode = self.root;
    while (!currentNode) {
        if (!currentNode.leftChild) {
            
        }
        
    }
}

#pragma mark-
#pragma mark先序遍历方法，分为类方法与对象方法

- (void)preOrderTraverseWithBlock:(void (^)(binaryTreeNode * currentNode))visitBlock
{
    binaryTreeNode *Node = self.root;
    [self preOrderTraverseBeginAtANode:Node WithBlock:visitBlock];
}

- (void)preOrderTraverseBeginAtANode:(nullable binaryTreeNode* )Node WithBlock:(void(^)(binaryTreeNode *currentNode))visitBlock;
{
    if (!Node) {
        return;
    }
    if (self.threadType == preThreaded) {
        [self preOrderTraverseThreadTreeWithBlock:visitBlock];
        return;
    }else{
        visitBlock(Node);
        if (!Node.leftTag) {    //在结点非线索结点的时候递归
        [self preOrderTraverseBeginAtANode:Node.leftChild WithBlock:visitBlock];
        }
        if (!Node.rightTag) {
        [self preOrderTraverseBeginAtANode:Node.rightChild WithBlock:visitBlock];
        }
    }
}

//线索二叉树
- (void) preOrderTraverseThreadTreeWithBlock:(void (^)(binaryTreeNode * currentNode))visitBlock
{
    if (!self.threadTree || (self.threadTree.leftChild == self.threadTree)) {
        return;
    }else{
        binaryTreeNode *currentNode = self.threadTree.leftChild;
        while (currentNode != self.threadTree) {
            while (!currentNode.leftTag) {  //LINK为0，找到最左侧的节点
                visitBlock(currentNode);
                currentNode = currentNode.leftChild;
            }
                visitBlock(currentNode);
            
            while (currentNode.rightTag && (currentNode.rightChild != self.threadTree)) {  //THREAD为1
                currentNode = currentNode.rightChild;
                visitBlock(currentNode);
            }
            while (!currentNode.leftTag) {
                currentNode = currentNode.leftChild;
                visitBlock(currentNode);
            }
            currentNode = currentNode.rightChild;
        }
    }
    
    
}

#pragma mark-
#pragma mark中序遍历方法

- (void)inOrderTraverseWithBlock:(void (^)(binaryTreeNode * currentNode))visitBlock //非递归遍历
{
    if (self.threadType == inOrderThreaded) {
        [self inOrderTraverseThreadTreeWithBlock:visitBlock];
        return;
    }else{
    
        stack * nodeStack = [[stack alloc] init];
        binaryTreeNode *currentNode = self.root;
        
        while (![nodeStack isEmpty] || currentNode) {
            if (currentNode) {
                [nodeStack push:currentNode];
                currentNode = currentNode.leftChild;
            }else{
                currentNode = [nodeStack pop];
                visitBlock(currentNode);
                currentNode = currentNode.rightChild;
            }
        }
    }
}

//线索二叉树
- (void) inOrderTraverseThreadTreeWithBlock:(void (^)(binaryTreeNode * currentNode))visitBlock
{
    if (!self.threadTree || (self.threadTree.leftChild == self.threadTree) ) {
        return;
    }
    binaryTreeNode *currentNode = self.threadTree.leftChild;
    while (currentNode != self.threadTree) {
        while (!currentNode.leftTag) {      //LINK为0，找到最左侧的节点
            currentNode = currentNode.leftChild;
        }
        visitBlock(currentNode);
        while (currentNode.rightTag && (currentNode.rightChild != self.threadTree)) {  //THREAD为1
            currentNode = currentNode.rightChild;
            visitBlock(currentNode);
        }
        currentNode = currentNode.rightChild;
    }
}


#pragma mark-
#pragma mark后序遍历方法

- (void)postOrderTraverseWithBlock:(void (^)(binaryTreeNode * currentNode))visitBlock
{
    if (self.threadType == postOrderThreaded) {
        [self postOrderTraverseThreadTreeWithBlock:visitBlock];
        return;
    }
    
    stack * nodeStack = [[stack alloc] init];
    binaryTreeNode *currentNode = self.root;
    
    while ( ![nodeStack isEmpty] || (currentNode) ) {
        if (currentNode) {
            [nodeStack push:currentNode];
            currentNode = currentNode.leftChild;
        }else{
            currentNode = [nodeStack pop];
            visitBlock(currentNode);
            currentNode = currentNode.rightSibling;            
        }
    }
}

//线索二叉树
- (void) postOrderTraverseThreadTreeWithBlock:(void (^)(binaryTreeNode * currentNode))visitBlock
{
    if (!self.threadTree || (self.threadTree.leftChild == self.threadTree) ) {
        return;
    }
    binaryTreeNode *currentNode = self.threadTree.leftChild;
    while (currentNode != self.threadTree ) {
        while (!currentNode.leftTag && (currentNode != self.root)) {//LINK为0，找到最左侧的节点
            currentNode = currentNode.leftChild;
        }
        visitBlock(currentNode);
        while (currentNode.rightTag && (currentNode.rightChild != self.threadTree)) {  //THREAD为1
            currentNode = currentNode.rightChild;
            visitBlock(currentNode);
        }
        if (currentNode.rightSibling) {
            currentNode = currentNode.rightSibling;
        }else{
            currentNode = currentNode.parent;
        }
        
    }
}

#pragma mark-
#pragma mark线索化方法

- (void)preOrderThreading
{
    binaryTreeNode *threadTree = [binaryTreeNode treeNodeWithValue:nil andParent:nil];
    threadTree.leftTag = LINK;
    threadTree.rightTag = THREAD;
    threadTree.leftChild = self.root;

    __block binaryTreeNode *preNode;
    if (!self.root) {
        threadTree.rightChild = threadTree;
    }else{
        preNode = threadTree;
        
        [self preOrderTraverseBeginAtANode:self.root WithBlock:^(binaryTreeNode *currentNode) {
            if (!currentNode.leftChild) {
                currentNode.leftTag = THREAD;
                currentNode.leftChild = preNode;
            }
            if (!preNode.rightChild) {
                preNode.rightTag = THREAD;
                preNode.rightChild = currentNode;
            }
            preNode = currentNode;
        }];
        preNode.rightTag = THREAD;
        preNode.rightChild = threadTree;
        threadTree.rightChild = preNode;
    }
    preNode = nil;
    self.threadType = preThreaded;
    self.threadTree = threadTree;
}

- (void)inOrderThreading
{
    binaryTreeNode *threadTree = [binaryTreeNode treeNodeWithValue:nil andParent:nil];
    threadTree.leftTag = LINK;
    threadTree.rightTag = THREAD;
//    threadTree.rightChild = threadTree;
   __block binaryTreeNode *preNode;
    if (!self.root) {
        threadTree.leftChild = threadTree;
    }else{
        binaryTreeNode *theFarLeftNode = self.root;
        while (theFarLeftNode.leftChild) {
            theFarLeftNode = theFarLeftNode.leftChild;
        }
        threadTree.leftChild = theFarLeftNode;
        preNode = threadTree;
        [self inOrderTraverseWithBlock:^(binaryTreeNode *currentNode) {
            if (!currentNode.leftChild) {
                currentNode.leftTag = THREAD;
                currentNode.leftChild = preNode;
            }
            if (!preNode.rightChild) {
                preNode.rightTag = THREAD;
                preNode.rightChild = currentNode;
            }
            preNode = currentNode;
        }];
        preNode.rightChild = threadTree;
        preNode.rightTag = THREAD;
        threadTree.rightChild = preNode;
    }
    preNode = nil;
    self.threadType = inOrderThreaded;
    self.threadTree = threadTree;
}

- (void)postOrderThreading
{
    binaryTreeNode *threadTree = [binaryTreeNode treeNodeWithValue:nil andParent:nil];
    threadTree.leftTag = LINK;
    threadTree.rightTag = THREAD;
    __block binaryTreeNode *preNode;
    if (!self.root) {
        threadTree.leftChild = threadTree;
    }else{
        binaryTreeNode *theFarLeftNode = self.root;
        while (theFarLeftNode.leftChild) {
            theFarLeftNode = theFarLeftNode.leftChild;
        }
        threadTree.leftChild = theFarLeftNode;
        preNode = threadTree;
        
        [self postOrderTraverseWithBlock:^(binaryTreeNode *currentNode) {
//            if (0) {
//            
//            }else{
            if (!currentNode.leftChild) {
                currentNode.leftTag = THREAD;
                currentNode.leftChild = preNode;
            }
            if (!preNode.rightChild) {
                preNode.rightTag = THREAD;
                preNode.rightChild = currentNode;
            }
//            }
            preNode = currentNode;
        }];
        
        threadTree.rightChild = preNode;
    }
    self.root.parent = threadTree;
    preNode = nil;
    self.threadType = postOrderThreaded;
    self.threadTree = threadTree;
}


- (void)unthreading  //去线索化方法
{
    __block binaryTreeNode *preNode = nil;
    
    switch (self.threadType) {
        case NoneThreaded:
            return;
            break;
        
        case preThreaded:
        {
            [self preOrderTraverseThreadTreeWithBlock:^(binaryTreeNode *currentNode) {
                if (currentNode.leftTag) {
                    currentNode.leftChild = nil;
                }
                if (preNode && preNode.rightTag) {
                    preNode.rightChild = nil;
                }
                preNode = currentNode;
            }];
            preNode.rightChild = nil;
            preNode = nil;
            
               //去线索首结点
            self.threadTree.rightChild = nil;
            self.threadTree = nil;
            self.threadType = NoneThreaded;
            
            break;
        }
        case inOrderThreaded:
        {
            [self inOrderTraverseThreadTreeWithBlock:^(binaryTreeNode *currentNode) {
                if (currentNode.leftTag) {
                    currentNode.leftChild = nil;
                }
                if (preNode && preNode.rightTag) {
                    preNode.rightChild = nil;
                }
                preNode = currentNode;
            }];
            
            preNode.rightChild = nil;
            preNode = nil;

            //去线索首结点
            self.threadTree.rightChild = nil;
            self.threadTree = nil;
            self.threadType = NoneThreaded;
            
            break;
        }
            
        case postOrderThreaded:
            
        {
            [self postOrderTraverseThreadTreeWithBlock:^(binaryTreeNode *currentNode) {
                if (currentNode.leftTag) {
                    currentNode.leftTag = LINK;
                    currentNode.leftChild = nil;
                }
                if (preNode && preNode.rightTag) {
                    preNode.rightTag = LINK;
                    preNode.rightChild = nil;
                }
                preNode = currentNode;
            }];
            preNode = nil;
            
            //去线索首结点
            self.threadTree.rightChild = nil;
            self.threadTree = nil;
            self.threadType = NoneThreaded;
            
            break;
        }
        default:
            break;
    }
}

- (void)dealloc
{
    [self unthreading];
}

@end
