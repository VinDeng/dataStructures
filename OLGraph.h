//
//  AdGraph.h
//  List
//
//  Created by Vincent_D on 15/11/12.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLGraphArcNode.h"
#import "OLGraphVNode.h"

@interface OLGraph : NSObject

@property (nonatomic) NSInteger vexNum;
@property (nonatomic) NSInteger arcNum;
@property (nonatomic) NSMutableArray *VNodes;

+ (instancetype)creatOLGraphWithNodeValue:(NSArray *)value andArc:(NSArray *)arc;

- (void)addArcWithImformation:(NSDictionary *)dic;

- (void)removeArc:(OLGraphArcNode *)arc;

- (void)removeAllArcBetweenVNodeA:(OLGraphVNode *)VNodeA andVNodeB:(OLGraphVNode *)VNodeB;

- (void)removeAllArcFromVNodeA:(OLGraphVNode *)VNodeA toVNodeB:(OLGraphVNode *)VNodeB;

- (void)removeArcBetweenVNodeA:(OLGraphVNode *)VNodeA andVNodeB:(OLGraphVNode *)VNodeB WithInfo:(id)info;

- (void)removeArcFromVNodeA:(OLGraphVNode *)VNodeA toVNodeB:(OLGraphVNode *)VNodeB WithInfo:(id)info;

- (void)removeVNode:(OLGraphVNode *)VNode;

- (void)BFSWithBlock:(void (^)(OLGraphVNode *currentNode))visitBlock;

- (void)DFSWithBlock:(void (^)(OLGraphVNode *currentNode))visitBlock;

@end
