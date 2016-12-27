//
//  List.h
//  List
//
//  Created by Vincent_D on 15/10/22.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ListNode.h"

@class ListNode;

@interface List : NSObject  

@property (nonatomic) ListNode *head;
@property (nonatomic) NSInteger length;

- (NSInteger)length;                                     //长度get方法

- (instancetype)initWithArray:(NSArray *)array;

- (void)insertObject:(id)object inIndex:(NSInteger)index; //插入
- (void)insertObjectAtLastIndex:(id)object;
- (void)insertObjectAtFirstIndex:(id)object;

- (void)removeObjectInIndex:(NSInteger)index; //删除

- (id)getObjectAtIndex:(NSInteger)index;                  //取出数据

- (NSInteger)locateObject:(id)object;                     //定位数据，找不到的时候输出-1
- (NSArray*)locateObjectAll:(id)object;

- (void)mergeSort;
- (void)sortWithComparisonBlock:(NSComparisonResult(^)(id _Nonnull obj1, id _Nonnull obj2))cmptr;

- (void)travelList:(nullable void(^)(ListNode* currentNode, NSInteger index))visitBlock;


@end


