//
//  List.h
//  List
//
//  Created by Vincent_D on 15/10/22.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "listNode.h"

@class listNode;

//@protocol listDelegate <NSObject>

//@property (nonatomic, weak) id listDelegate;


//- (void)visit:(listNode *)currentNote atIndex:(NSInteger)index;
//
//@end

//typedef void(^visitBlock)(listNode *currentNode);

@interface List : NSObject  

@property (nonatomic) listNode *head;
@property (nonatomic) NSInteger length;
//@property (nonatomic,weak) id listDelegate;

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


//- (void)travelList;
- (void)travelList:(nullable void(^)(listNode* currentNode, NSInteger index))visitBlock;


@end


