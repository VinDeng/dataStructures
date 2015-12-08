//
//  treeNode.h
//  List
//
//  Created by Vincent_D on 15/11/7.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"

@interface treeNode : NSObject

@property (nonatomic) treeNode *parent;
@property (nonatomic) id value;

+ (instancetype)treeNodeWithValue:(id)value andParent:(treeNode *)Node;

@end
