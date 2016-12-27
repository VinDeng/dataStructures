//
//  List.m
//  List
//
//  Created by Vincent_D on 15/10/22.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//



#import "List.h"

@class doubleLinkList;

@interface List ()



@end

@implementation List

#pragma mark -
#pragma mark 初始化方法

- (instancetype)init
{
    if (self = [super init]) {
        self.head = [ListNode creatNodeWithObject:nil];
        self.head.next = nil;
        self.head.pre = nil;
//        self.listDelegate = self;
    }
    
    return self;
}

- (instancetype)initWithArray:(NSArray *)array
{
    self = [self init];

    for (id object in array) {
        [self insertObjectAtLastIndex:object];
    }
    
    return self;
}

#pragma mark -
#pragma mark 动态长度get方法
- (NSInteger)length
{
    int count = 0; //默认包含头结点，长度至少为1
    ListNode *currentNode = self.head;
    while ((currentNode = currentNode.next)) {
        count ++;
    }
    return count + 1;
}

#pragma mark -
#pragma mark 遍历方法，用block去执行遍历回调

- (void)travelList:(nullable void(^)(ListNode
                                     * currentNote, NSInteger index))visitBlock
{
    int count = 0;
    ListNode *currentNode = self.head;

    while (currentNode) {
        
        if (visitBlock && count) {
            visitBlock(currentNode, count);
        }
        count++;
        currentNode = currentNode.next;
    }

}

#pragma mark -
#pragma mark 各种插入方法
- (void)insertObjectAtLastIndex:(id)object
{
    ListNode *currentNode = self.head;
    for (int i = 0; i < self.length - 1; i++) {
        currentNode = currentNode.next;
    }
    ListNode *newNode = [ListNode creatNodeWithObject:object];
    currentNode.next = newNode;
    
}

- (void)insertObjectAtFirstIndex:(id)object
{
    ListNode *newHead = [ListNode creatNodeWithObject:object];
    newHead.next = self.head.next;
    self.head.next = newHead;
}

- (void)insertObject:(id)object inIndex:(NSInteger)index
{
    if (index < 0) { //输入出错
         [[NSException exceptionWithName:@"link oversize" reason:@"input index is small than zero" userInfo:nil] raise];
    }else
    
    if (index > self.length - 1) { //越界
//        [NSException exceptionWithName:@"link oversize" reason:@"input index is bigger than link's length" userInfo:nil]; //抛出异常
        while (index > self.length) {
            [self insertObjectAtLastIndex:nil];  //持续插入结点直到可以满足插入长度
        }
        [self insertObjectAtLastIndex:object];   //插入目标结点，刚好填充到需要的长度。
    }else if(index == 0){  //插入头结点
        [self insertObjectAtFirstIndex:object];
    }else{  //一般插入
        ListNode *currentNode = self.head;
        ListNode *newNode = [ListNode creatNodeWithObject:object];
        for (int i = 0; i < index - 1; i++) {
            currentNode = currentNode.next;
        }
        newNode.next = currentNode.next;
        currentNode.next = newNode;
    }
    
}

#pragma mark -
#pragma mark 移除结点方法

- (void)removeObjectInIndex:(NSInteger)index
{
    if (index < 0) {
        NSLog(@"error index");
        return ;
    }else
    if (index > self.length - 1) {
        NSLog(@"oversize");
        return;
    }else
    if (index == 0) {
        self.head = self.head.next;
    }else{
        ListNode *currentNode = self.head;
        for (int i = 0; i < index - 1; i++) {
            currentNode = currentNode.next;
        }
        currentNode.next = currentNode.next.next;
    }
}


#pragma mark -
#pragma mark 定位方法

- (id)getObjectAtIndex:(NSInteger)index         //返回第一个找到的位置，一个没有找到的返回-1
{
    if (index < 0) {
        return nil;
    }else if (index > self.length - 1){
        return nil;
    }else{
        ListNode *currentNote = self.head;
        for (int i = 0; i < index; i++) {
            currentNote = currentNote.next;
        }
        return currentNote.Object;
    }
}

- (NSInteger)locateObject:(id)object
{
  __block NSMutableArray *locationArray = [[NSMutableArray alloc] init];
    
    [self travelList:^void(ListNode *currentNote, NSInteger index) {
        if (currentNote.Object == object) {
            [locationArray addObject:[NSNumber numberWithInteger:index]];
        }
    }];
    
    if (locationArray.firstObject) {
        return [locationArray.firstObject integerValue];
    }else{
        return -1;
    }
}

- (NSArray*)locateObjectAll:(id)object       //返回所有具有同样对象的位置打包成的数组，一个没有找到的返回nil
{
    __block NSMutableArray *locationArray = [[NSMutableArray alloc] init];
    
    [self travelList:^void(ListNode *currentNote, NSInteger index) {
        if (currentNote.Object == object) {
            [locationArray addObject:[NSNumber numberWithInteger:index]];
        }
    }];
    
    if (locationArray.firstObject) {
        return (NSArray*)locationArray;
    }else{
        return nil;
    }
    
}


#pragma mark-
#pragma 比较器block排序
- (void)sortWithComparisonBlock:(NSComparisonResult (^)(id _Nonnull, id _Nonnull))cmptr
{
    __block NSMutableArray *array = [[NSMutableArray alloc] init];
    [self travelList:^(ListNode *currentNode, NSInteger index) {
        [array addObject:currentNode.Object];
    }];
    [array sortedArrayUsingComparator:cmptr];
    self.head = [[List alloc] initWithArray:array].head;
    array = nil;
}


#pragma mark -
#pragma mark 销毁链表方法，主要避免循环链表与双向链表无法通过设置头结点为nil销毁

- (void)destroyList
{
    [self travelList:^(ListNode *currentNode, NSInteger index) {
        if (currentNode.next) {
            ListNode *preNode = currentNode;
            currentNode = currentNode.next;
            preNode.next = nil;
            preNode = nil;
        }
    }];
}

- (void)dealloc
{
    [self destroyList];
    NSLog(@"list dealloc");
}

#pragma mark-
#pragma 归并排序
- (void)mergeSort
{
    if (self.head.next) {
        ListNode *node = self.head.next;
        mergeSort(&node);
        self.head.next = node;
    }
    

}

void mergeSort(ListNode ** headRef)
{
    ListNode *firstNode = *headRef;
    if (!firstNode ||!firstNode.next) {
        return;
    }
    ListNode *frontNode;
    ListNode *backNode;
    
    frontBackSplit(firstNode, &frontNode, &backNode);
    
    mergeSort(&frontNode);
    mergeSort(&backNode);
    
    *headRef = mergeList(frontNode, backNode);
    
    NSLog(@"");
}

void frontBackSplit(ListNode* source,ListNode** frontRef,ListNode** backRef)
{
    if (!source.next) {
        *frontRef = source;
        *backRef = nil;
    }else{
        ListNode *fast = source.next;
        ListNode *slow = source;
    
        while (fast) {
            fast = fast.next;
            if (fast) {
                fast = fast.next;
                slow = slow.next;
            }
        }
        *frontRef = source;
        *backRef = slow.next;
        slow.next = nil;
    }
}

ListNode* mergeList(ListNode* listA, ListNode* listB)
{
    ListNode *resulet;
    if (!listA) {
        return listB;
    }else if(!listB){
        return listA;
    }
    
    if (listA.Object <= listB.Object) {
        resulet = listA;
        resulet.next = mergeList(listA.next, listB);
    }else{
        resulet = listB;
        resulet.next = mergeList(listA, listB.next);
    }
    
    return resulet;
}

- (NSString *)description
{
    NSString * voidStr = @"";
    [self travelList:^(ListNode *currentNode, NSInteger index) {
       char *str = [[NSString stringWithFormat:@"%@",currentNode.Object] UTF8String];
        printf("%s\n",str);
        
    }];
    return voidStr;
}

@end
