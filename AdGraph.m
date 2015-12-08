//
//  AdGraph.m
//  List
//
//  Created by Vincent_D on 15/11/20.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "AdGraph.h"
#import "Queue.h"

@interface AdGraph ()

@end

@implementation AdGraph

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
+ (instancetype)creatAdGraphWithNodeValue:(NSArray *)value andArc:(NSArray *)arc
{
    AdGraph *graph = [[AdGraph alloc] init];
    
    for (id object in value) {  //先构造顶点集合
        [graph.VNodes addObject:[AdGraphVNode VNodeWithValue:object]];
        graph.vexNum++;
    }
    
    for (NSDictionary *dic in arc) {  //再添加弧
        [graph addArcWithImformation:dic];
    }
    
    return graph;
}

#pragma mark-
#pragma mark 顶点操作

- (void)removeVNode:(AdGraphVNode *)VNode
{

    for (AdGraphVNode *currentVNode in self.VNodes) {
        while (currentVNode.firstArcNode && (currentVNode.firstArcNode.adVNode == VNode)) {
            currentVNode.firstArcNode = currentVNode.firstArcNode.nextArcNode;
        }
        for (AdGraphArcNode *currentArc = currentVNode.firstArcNode; currentArc; currentArc = currentArc.nextArcNode) {
            if (currentArc.nextArcNode && (currentArc.nextArcNode.adVNode == VNode)) {
                currentArc.nextArcNode = currentArc.nextArcNode.nextArcNode;
            }
        }
    }
    [self.VNodes removeObject:VNode];
}

#pragma mark-
#pragma mark 弧操作
- (void)addArcWithImformation:(NSDictionary *)dic
{
    AdGraphArcNode *arc = [[AdGraphArcNode alloc] init];
    NSInteger index = 0;
    
    if ([dic[@"tail"] isKindOfClass:[NSNumber class]] ) {
        if ((index = [dic[@"tail"] integerValue]) >= self.VNodes.count) {
            NSLog(@"tail index oversize");
            return;
        }else{
            arc.adVNode = self.VNodes[index];
        }
    }else{
        NSLog(@"paramater error");
        return;
    }
    
    if ([dic[@"head"] isKindOfClass:[NSNumber class]]) {
        if ((index = [dic[@"head"] integerValue]) >= self.VNodes.count) {
            NSLog(@"head index oversize");
            return;
        }else{
//            do nothing
        }
    }else{
        NSLog(@"paramater error");
        return;
    }
    
    arc.info = dic[@"info"];
    
    AdGraphVNode *VNode = self.VNodes[index];
    arc.nextArcNode = VNode.firstArcNode;
    VNode.firstArcNode = arc;
    
    self.arcNum++;
    
    return;
}

- (void)removeArc:(AdGraphArcNode *)arc
{
    AdGraphArcNode *currentArc;
    for (int i = 0; i < self.vexNum; i++) {
        if (((AdGraphVNode *)(self.VNodes[i])).firstArcNode == arc) {
            ((AdGraphVNode *)(self.VNodes[i])).firstArcNode = arc.nextArcNode;
            
            break;
        }else{
            for (currentArc = ((AdGraphVNode *)(self.VNodes[i])).firstArcNode; currentArc.nextArcNode;currentArc =  currentArc.nextArcNode) {
                if (currentArc.nextArcNode == arc) {
                    currentArc.nextArcNode = currentArc.nextArcNode.nextArcNode;

                    break;
                }
            }
        }

    }
}

- (void)removeArcFromVNodeA:(AdGraphVNode *)VNodeA toVNodeB:(AdGraphVNode *)VNodeB WithInfo:(id)info
{
    if (VNodeA.firstArcNode.adVNode == VNodeB) {
        VNodeA.firstArcNode = VNodeA.firstArcNode.nextArcNode;
    }else{
        for (AdGraphArcNode *arc = VNodeA.firstArcNode; arc.nextArcNode; arc = arc.nextArcNode) {
            if ((arc.nextArcNode.adVNode == VNodeB) && (arc.nextArcNode.info == info)) {
                arc.nextArcNode = arc.nextArcNode.nextArcNode;
            }
        }
    }
}

- (void)removeAllArcFromVNodeA:(AdGraphVNode *)VNodeA toVNodeB:(AdGraphVNode *)VNodeB
{
    if (VNodeA.firstArcNode.adVNode == VNodeB) {
        VNodeA.firstArcNode = VNodeA.firstArcNode.nextArcNode;
    }else{
        for (AdGraphArcNode *arc = VNodeA.firstArcNode; arc.nextArcNode; arc = arc.nextArcNode) {
            if (arc.nextArcNode.adVNode == VNodeB) {
                arc.nextArcNode = arc.nextArcNode.nextArcNode;            }
        }
    }
}


- (void)removeArcBetweenVNodeA:(AdGraphVNode *)VNodeA andVNodeB:(AdGraphVNode *)VNodeB WithInfo:(id)info
{
    [self removeArcFromVNodeA:VNodeA toVNodeB:VNodeB WithInfo:info];
    [self removeArcFromVNodeA:VNodeB toVNodeB:VNodeA WithInfo:info];
}

- (void)removeAllArcBetweenVNodeA:(AdGraphVNode *)VNodeA andVNodeB:(AdGraphVNode *)VNodeB
{
    [self removeAllArcFromVNodeA:VNodeA toVNodeB:VNodeB];
    [self removeAllArcFromVNodeA:VNodeB toVNodeB:VNodeA];
}

#pragma mark-
#pragma 遍历方法
- (void)DFSWithBlock:(void (^)(AdGraphVNode * currentNode))visitBlock
{
    int visited[self.vexNum];
    memset(visited, 0, sizeof(int)*self.vexNum);
    
    for (NSInteger i = 0; i < self.vexNum ; i++) {
        if (!visited[i]) {
            [self DFS:visited andCurrentIndex:i WithBlock:visitBlock];
        }
        
    }
}

- (void)DFS:(int*)visited andCurrentIndex:(NSInteger)currentIndex WithBlock:(void (^)(AdGraphVNode *currentNode))visitBlock
{
    visited[currentIndex] = 1;
    AdGraphVNode *currentVNode = self.VNodes[currentIndex];
    visitBlock(currentVNode);
    for (AdGraphArcNode *arc = currentVNode.firstArcNode; arc; arc = arc.nextArcNode) {
        NSInteger nextIndex = [self.VNodes indexOfObject:arc.adVNode];
        if (!visited[nextIndex]) {
            [self DFS:visited andCurrentIndex:nextIndex WithBlock:visitBlock];
        }
    }
}

- (void)BFSWithBlock:(void (^)(AdGraphVNode *))visitBlock
{
    Queue *queue = [[Queue alloc] init];
    int visited[self.vexNum];
    memset(visited, 0, sizeof(int)*self.vexNum);
    AdGraphVNode *currentVNode;
    for (NSInteger i = 0; i < self.vexNum; i++) {
        if (!visited[i]) {
            visited[i] = 1;
            visitBlock(self.VNodes[i]);
            [queue enQueue:self.VNodes[i]];
        }
        while ((currentVNode = [queue DeQueue])) {
            for (AdGraphArcNode *arc = currentVNode.firstArcNode; arc; arc = arc.nextArcNode) {
                NSInteger index = [self.VNodes indexOfObject:arc.adVNode];
                if (!visited[index]) {
                    visited[index] = 1;
                    visitBlock(arc.adVNode);
                    [queue enQueue:arc.adVNode];
                }
            }
        }
    }
}

@end
