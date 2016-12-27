//
//  AdGraphArcNode.h
//  List
//
//  Created by Vincent_D on 15/11/20.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdGraphVNode.h"
@class AdGraphVNode;

@interface AdGraphArcNode : NSObject

@property (nonatomic, weak) AdGraphVNode *adVNode;
@property (nonatomic) AdGraphArcNode *nextArcNode;
@property (nonatomic) id info;

@end
