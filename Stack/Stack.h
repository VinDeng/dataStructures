//
//  stack.h
//  List
//
//  Created by Vincent_D on 15/10/26.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"

@interface Stack : NSObject


@property (nonatomic) NSInteger length;
@property (nonatomic) id top;

- (instancetype)initWithArray:(NSArray *)array; //以数组构造

- (id)top;//栈顶元素
- (NSInteger)length; //栈长

- (void)clearStack;  //清栈
- (void)push:(id)object; //进栈
- (id)pop;//出栈

- (BOOL)isEmpty;

//遍历方法
- (void)travelStack:(void(^)(id currentObject))visitBlock;



@end
