//
//  listNode.h
//  List
//
//  Created by Vincent_D on 15/10/21.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "list.h"

@interface ListNode : NSObject

@property (nonatomic) id Object;
@property (nonatomic) ListNode * next;
@property (nonatomic, weak) ListNode * pre;

+ (instancetype)creatNodeWithObject:(id)Object;

@end
