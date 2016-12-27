//
//  AdGraph.m
//  List
//
//  Created by Vincent_D on 15/11/12.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "Queue.h"
#import "OLGraph.h"
#import "OLGraphArcNode.h"
#import "OLGraphVNode.h"

@interface OLGraph ()

@end

@implementation OLGraph

- (instancetype)init
{
    if (self = [super init]) {
        self.VNodes = [[NSMutableArray alloc] init];
        self.vexNum = 0;
        self.arcNum = 0;
    }
    return self;
}

#pragma mark-
#pragma mark 图构造方法
+ (instancetype)creatOLGraphWithNodeValue:(NSArray *)value andArc:(NSArray *)arc
{
    OLGraph *graph = [[OLGraph alloc] init]; //先构造顶点集合
    for (id object in value) {
        [graph.VNodes addObject:[OLGraphVNode VNodeWithValue:object] ];
        graph.vexNum++;
    }
    
    for (NSDictionary *dic in arc) {        //添加弧
        [graph addArcWithImformation:dic];
    }
    
    return graph;
}

#pragma mark-
#pragma mark 顶点操作

- (void)removeVNode:(OLGraphVNode *)VNode
{
    OLGraphArcNode *currentArc = VNode.firstInArc;
    NSMutableArray *arcArr = [[NSMutableArray alloc] init];
    while (currentArc) {
        [arcArr addObject:currentArc];
        currentArc = currentArc.sameTailArc;
    }
    currentArc = VNode.firstOutArc;
    while (currentArc) {
        [arcArr addObject:currentArc];
        currentArc = currentArc.sameHeadArc;
    }
    
    for (OLGraphArcNode *arc in arcArr) {
        [self removeArc:arc];
    }
    
    arcArr = nil;
    
    [self.VNodes removeObject:VNode];
}

#pragma mark-
#pragma mark 弧操作
- (void)addArcWithImformation:(NSDictionary *)dic
{
    OLGraphArcNode *arc = [[OLGraphArcNode alloc] init];
    NSInteger index = 0;
    
    if ([(dic[@"head"])  isKindOfClass:[NSNumber class]]) { //设置头结点与同一出发点的弧表
        if ( (index =[[dic valueForKey:@"head"] integerValue]) >= self.VNodes.count) {
            NSLog(@"%@ head index oversize",dic);
            return;
        }else{
            arc.headVNode = self.VNodes[index];
            arc.sameHeadArc = arc.headVNode.firstOutArc;
        }
    }else{
        NSLog(@"parameter error");
        return;
    }

//    if ([[[dic valueForKey:@"tail"] className] isEqualToString:@"__NSCFNumber"]) {//设置尾结点与同一进入点的弧表
    if ([[dic valueForKey:@"tail"] isKindOfClass:[NSNumber class]]) {
        if ( (index =[[dic valueForKey:@"tail"] integerValue]) >= self.VNodes.count) {
            NSLog(@"%@ tail index oversize",dic);
            return;
        }else{
            arc.tailVNode = self.VNodes[index];
            arc.sameTailArc = arc.tailVNode.firstInArc;
        }
    }else{
        NSLog(@"paramater error");
        return;
    }

    arc.headVNode.firstOutArc = arc;                                //更新头结点的首出
    arc.tailVNode.firstInArc = arc;                                 //更新尾结点的首入
    
    arc.info = [dic objectForKey:@"info"];                          //更新info
    
    self.arcNum++;
    
    return;
}

- (void)addArc:(NSDictionary *)dic WithImformation:(id)info
{
    OLGraphArcNode *arc = [[OLGraphArcNode alloc] init];
    NSInteger index = 0;
    
    if ([(dic[@"head"])  isKindOfClass:[NSNumber class]]) { //设置头结点与同一出发点的弧表
        if ( (index =[[dic valueForKey:@"head"] integerValue]) >= self.VNodes.count) {
            NSLog(@"%@ head index oversize",dic);
            return;
        }else{
            arc.headVNode = self.VNodes[index];
            arc.sameHeadArc = arc.headVNode.firstOutArc;
        }
    }else{
        NSLog(@"parameter error");
        return;
    }
    
    //    if ([[[dic valueForKey:@"tail"] className] isEqualToString:@"__NSCFNumber"]) {//设置尾结点与同一进入点的弧表
    if ([[dic valueForKey:@"tail"] isKindOfClass:[NSNumber class]]) {
        if ( (index =[[dic valueForKey:@"tail"] integerValue]) >= self.VNodes.count) {
            NSLog(@"%@ tail index oversize",dic);
            return;
        }else{
            arc.tailVNode = self.VNodes[index];
            arc.sameTailArc = arc.tailVNode.firstInArc;
        }
    }else{
        NSLog(@"paramater error");
        return;
    }
    
    arc.headVNode.firstOutArc = arc;                                //更新头结点的首出
    arc.tailVNode.firstInArc = arc;                                 //更新尾结点的首入
    
    arc.info = [dic objectForKey:@"info"];                          //更新info
    
    self.arcNum++;
    
    return;
}

- (void)removeArc:(OLGraphArcNode *)arc
{
    OLGraphVNode *headNode = arc.headVNode;
    OLGraphVNode *tailNode = arc.tailVNode;
    if (headNode.firstOutArc == arc) {
        headNode.firstOutArc = arc.sameHeadArc;
    }else{
        OLGraphArcNode *currentArcNode = headNode.firstOutArc;
        while (!(currentArcNode.sameHeadArc == arc)) {
            currentArcNode = currentArcNode.sameHeadArc;
        }
        currentArcNode.sameHeadArc = arc.sameHeadArc;       //从头结点邻接表中去除arc
        currentArcNode = nil;
    }
    
    if (tailNode.firstInArc == arc) {
        headNode.firstInArc = arc.sameTailArc;
    }else{
        OLGraphArcNode *currentArcNode = tailNode.firstInArc;   //从尾结点邻接表中去除arc
        while (!(currentArcNode.sameTailArc == arc)) {
            currentArcNode = currentArcNode.sameTailArc;
        }
        currentArcNode.sameTailArc = arc.sameTailArc;
        currentArcNode = nil;
    }
}

- (void)removeAllArcFromVNodeA:(OLGraphVNode *)VNodeA toVNodeB:(OLGraphVNode *)VNodeB
{
    NSMutableArray *needRemovedArcs = [[NSMutableArray alloc] init];
    for (OLGraphArcNode *currentArcNode = VNodeA.firstOutArc; currentArcNode.sameTailArc; currentArcNode = currentArcNode.sameTailArc) {
        if (currentArcNode.tailVNode == VNodeB) {
            [needRemovedArcs addObject:currentArcNode];
        }
    }
    
    for (OLGraphArcNode *arc in needRemovedArcs) {
        [self removeArc:arc];
    }
}

- (void)removeArcFromVNodeA:(OLGraphVNode *)VNodeA toVNodeB:(OLGraphVNode *)VNodeB WithInfo:(id)info
{
    NSMutableArray *needRemovedArcs = [[NSMutableArray alloc] init];
    for (OLGraphArcNode *currentArcNode = VNodeA.firstOutArc; currentArcNode.sameTailArc; currentArcNode = currentArcNode.sameTailArc) {
        if (currentArcNode.tailVNode == VNodeB) {
            if (currentArcNode.info == info) {
                [needRemovedArcs addObject:currentArcNode];
            }
        }
    }
    
    for (OLGraphArcNode *arc in needRemovedArcs) {
        [self removeArc:arc];
    }
}

- (void)removeAllArcBetweenVNodeA:(OLGraphVNode *)VNodeA andVNodeB:(OLGraphVNode *)VNodeB
{
    [self removeAllArcFromVNodeA:VNodeA toVNodeB:VNodeB];
    [self removeAllArcFromVNodeA:VNodeB toVNodeB:VNodeA];
}

- (void)removeArcBetweenVNodeA:(OLGraphVNode *)VNodeA andVNodeB:(OLGraphVNode *)VNodeB WithInfo:(id)info
{
    [self removeArcBetweenVNodeA:VNodeA andVNodeB:VNodeB WithInfo:info];
    [self removeArcBetweenVNodeA:VNodeB andVNodeB:VNodeA WithInfo:info];
}

#pragma mark-
#pragma mark遍历方法
- (void)DFSWithBlock:(void (^)(OLGraphVNode *currentNode))visitBlock
{
    int visited[self.vexNum];
    memset(visited, 0, sizeof(int)*self.vexNum);
    NSInteger count = self.vexNum;
    for (int i = 0; i < count; i++) {
        if (!visited[i]) {
            [self DFS:visited andCurrentIndex:i WithBlock:visitBlock];
        }
    }
}

- (void)DFS:(int*)visited andCurrentIndex:(NSInteger)currentIndex WithBlock:(void (^)(OLGraphVNode *currentNode))visitBlock
{
    visited[currentIndex] = 1;
    visitBlock((OLGraphVNode *)self.VNodes[currentIndex]);
    for (OLGraphArcNode *arc = ((OLGraphVNode *)(self.VNodes[currentIndex])).firstOutArc; arc; arc = arc.sameHeadArc) {
        
        NSInteger nextIndex = [self.VNodes indexOfObject:arc.tailVNode];
        if (!visited[nextIndex]) {
            [self DFS:visited andCurrentIndex:nextIndex WithBlock:visitBlock];
        }
    }
}

- (void)BFSWithBlock:(void (^)(OLGraphVNode *currentNode))visitBlock
{
    Queue *queue = [[Queue alloc] init];
    OLGraphVNode *currentVNode;
     NSInteger count = self.vexNum;
    int visited[count];
    memset(visited, 0, sizeof(visited)*count);
    for (NSInteger i = 0; i < count; i++) {
        if (!visited[i]) {
            visited[i] = 1;
            visitBlock(self.VNodes[i]);
            [queue enQueue:self.VNodes[i]];
        }
        while ((currentVNode = [queue deQueue])) {
            for (OLGraphArcNode *nextArcNode = currentVNode.firstOutArc; nextArcNode; nextArcNode = nextArcNode.sameTailArc) {
                NSInteger index = [self.VNodes indexOfObject:nextArcNode.tailVNode];
                if (!visited[index]) {
                visitBlock(nextArcNode.tailVNode);
                visited[index] = 1;
                [queue enQueue:nextArcNode.tailVNode];
                }
            }
        }
    }
}

@end

