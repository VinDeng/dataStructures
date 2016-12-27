//
//  AdGraph.h
//  List
//
//  Created by Vincent_D on 15/11/20.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdGraphArcNode.h"
#import "AdGraphVNode.h"

@interface AdGraph : NSObject

@property (nonatomic) NSInteger vexNum;
@property (nonatomic) NSInteger arcNum;

@property (nonatomic) NSMutableArray *VNodes;

+ (instancetype)creatAdGraphWithNodeValue:(NSArray *)value andArc:(NSArray *)arc;

- (void)addArcWithImformation:(NSDictionary *)dic;

- (void)removeArc:(AdGraphArcNode *)arc;

- (void)removeAllArcBetweenVNodeA:(AdGraphVNode *)VNodeA andVNodeB:(AdGraphVNode *)VNodeB;

- (void)removeAllArcFromVNodeA:(AdGraphVNode *)VNodeA toVNodeB:(AdGraphVNode *)VNodeB;

- (void)removeArcBetweenVNodeA:(AdGraphVNode *)VNodeA andVNodeB:(AdGraphVNode *)VNodeB WithInfo:(id)info;

- (void)removeArcFromVNodeA:(AdGraphVNode *)VNodeA toVNodeB:(AdGraphVNode *)VNodeB WithInfo:(id)info;

- (void)removeVNode:(AdGraphVNode *)VNode;

- (void)BFSWithBlock:(void (^)(AdGraphVNode *currentNode))visitBlock;

- (void)DFSWithBlock:(void (^)(AdGraphVNode *currentNode))visitBlock;

@end
