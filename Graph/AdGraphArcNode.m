//
//  AdGraphArcNode.m
//  List
//
//  Created by Vincent_D on 15/11/20.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import "AdGraphArcNode.h"

@implementation AdGraphArcNode

- (instancetype)init
{
    if (self = [super init]) {
        self.nextArcNode = nil;
        self.info = nil;
        self.adVNode = nil;
    }
    return self;
}

+ (instancetype)arcWithImformation:(NSDictionary *)dic
{
    
    return 0;
}


@end
