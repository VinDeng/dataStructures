//
//  tree.h
//  List
//
//  Created by Vincent_D on 15/11/7.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "treeNode.h"

@interface tree : NSObject

@property (nonatomic) NSMutableArray *firstChildren;
@property (nonatomic) NSInteger depth;

- (void)travelWithBlock:(void (^)(treeNode * currentNode))visitBlock;
- (void)travelThroughFirstChild:(treeNode *)firstChildNode WithBlock:(void (^)(treeNode * currentNode))visitBlock;
@end
