//
//  GlistNode.h
//  List
//
//  Created by Vincent_D on 15/10/28.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlistNode : NSObject

@property (nonatomic) BOOL isAtomic;
@property (nonatomic) id atomValue;
@property (nonatomic) GlistNode * head;
@property (nonatomic) GlistNode * tail;


- (NSInteger)length;
- (NSInteger)depth;

- (void)insertObjectAtHead:(id)object;
- (void)removeObjectAtHead;

@end
