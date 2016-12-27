//
//  doubleLinkList.m
//  List
//
//  Created by Vincent_D on 15/10/26.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "DoubleLinkList.h"

@implementation DoubleLinkList

#pragma mark-
#pragma 插入方法
- (void)insertObjectAtLastIndex:(id)object
{
    ListNode *currentNode = self.head;
    for (int i = 0; i < self.length - 1; i++) {
        currentNode = currentNode.next;
    }
    ListNode *newNode = [ListNode creatNodeWithObject:object];
    currentNode.next = newNode;
    newNode.pre = currentNode;
    
}

- (void)insertObjectAtFirstIndex:(id)object
{
    ListNode *newHead = [ListNode creatNodeWithObject:object];
    newHead.next = self.head;
    self.head.pre = newHead;
    self.head = newHead;
}

- (void)insertObject:(id)object inIndex:(NSInteger)index
{
    if (index < 0) { //输入出错
        [[NSException exceptionWithName:@"link oversize" reason:@"input index is small than zero" userInfo:nil] raise];
    }else
        
        if (index > self.length - 1) { //越界
            [[NSException exceptionWithName:@"link oversize" reason:@"input index is bigger than link's length" userInfo:nil] raise]; //抛出异常
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
            newNode.pre = currentNode;
            currentNode.next = newNode;
            newNode.next.pre = newNode;
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
                currentNode.next.pre = currentNode;
            }
    
}

#pragma mark -
#pragma mark 重写销毁链表方法，使用后还需将头结点设置成nil

- (void)destroyList
{
    [self travelList:^(ListNode *currentNote, NSInteger index) {
        currentNote.pre = nil;
    }];
}

- (void)dealloc
{
    [self destroyList];
}

@end
