//
//  OLGraphArcNode.h
//  List
//
//  Created by Vincent_D on 15/11/13.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLGraphVNode.h"
@class OLGraphVNode;

@interface OLGraphArcNode : NSObject

@property (nonatomic) OLGraphArcNode *sameHeadArc;
@property (nonatomic) OLGraphArcNode *sameTailArc;

@property (weak, nonatomic) OLGraphVNode *headVNode;
@property (weak, nonatomic) OLGraphVNode *tailVNode;

@property (nonatomic) id info;

+ (instancetype)arcWithImformation:(NSDictionary*)dic;

@end
