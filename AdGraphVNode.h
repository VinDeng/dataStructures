//
//  AdGraphVNode.h
//  List
//
//  Created by Vincent_D on 15/11/20.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdGraphArcNode.h"
@class AdGraphArcNode;

@interface AdGraphVNode : NSObject

@property (nonatomic) id value;
@property (nonatomic) AdGraphArcNode *firstArcNode;

+ (instancetype)VNodeWithValue:(id)value;

@end
