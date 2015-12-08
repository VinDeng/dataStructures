//
//  OLGraphVNode.h
//  List
//
//  Created by Vincent_D on 15/11/13.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLGraphArcNode.h"
@class OLGraphArcNode;

@interface OLGraphVNode : NSObject

@property (nonatomic) OLGraphArcNode *firstInArc;
@property (nonatomic) OLGraphArcNode *firstOutArc;

@property (nonatomic) id value;

+ (instancetype)VNodeWithValue:(id)value;

@end
