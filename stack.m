//
//  stack.m
//  List
//
//  Created by Vincent_D on 15/10/26.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "stack.h"

@interface stack ()

@property (nonatomic) List* list;

@end

@implementation stack

- (instancetype)init
{
    if (self = [super init]) {
        self.list = [[List alloc] init];
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array
{
    if (self = [super init]) {
        self.list = [[List alloc] initWithArray:array];
    }
    return self;
}

- (void)clearStack
{
    self.list = [[List alloc] init];
}

- (NSInteger)length
{
    if (!self.list) {
        return 0;
    }
    return self.list.length - 1;
}

- (id)top
{
    if (!self.list || (self.list.length < 2)) {     //头结点不算栈长度
        return nil;
    }else{
        return [self.list getObjectAtIndex:(self.list.length - 1)];
    }
}

- (void)push:(id)object
{
    if (self.list) {
        [self.list insertObjectAtLastIndex:object];
    }
}

- (id)pop
{
    if (self.length) {
        id object = [self.list getObjectAtIndex:(self.list.length - 1)];
        [self.list removeObjectInIndex:self.length];
        return object;
    }else{
        return nil;
    }
}

- (BOOL)isEmpty
{
    if (self.length) {
        return NO;
    }else{
        return YES;
    }
}

- (void)travelStack:(void (^)(id))visitBlock
{
 [self.list travelList:^(listNode *currentNote, NSInteger index) {
     visitBlock(currentNote.Object);
 }];
}
//
//- (void)dealloc
//{
//    NSLog(@"stack dealloc");
//}

@end
