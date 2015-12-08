//
//  listNode.h
//  List
//
//  Created by Vincent_D on 15/10/21.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "list.h"

@interface listNode : NSObject

@property (nonatomic) id Object;
@property (nonatomic) listNode * next;
@property (nonatomic, weak) listNode * pre;

+ (instancetype)creatNodeWithObject:(id)Object;

@end
