//
//  treeNode.h
//  List
//
//  Created by Vincent_D on 15/11/7.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"

@interface TreeNode : NSObject

@property (nonatomic) TreeNode *parent;
@property (nonatomic) id value;

+ (instancetype)treeNodeWithValue:(id)value andParent:(TreeNode *)Node;

@end
