//
//  main.m
//  List
//
//  Created by Vincent_D on 15/10/21.
//  Copyright © 2015年 Vincent_D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViDataStructures.h"

void insertSort(int * arr, int length);
void selectSort(int * arr, int length);
void quickSort(int * arr, int length);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //测试代码
        
        //链表 List
        printf("一、链表 List\n");
        
        List *list = [[List alloc] init];//构建空链表
        
        [list insertObjectAtFirstIndex:@"firstObject"];//插入头结点

        [list insertObjectAtLastIndex:@"lastObject"];//插入尾结点
        
        [list insertObject:@"middleObject" inIndex:2];//按目录插入结点
        printf("\n第一次构造测试及插入测试\n");
        NSLog(@"%@",list);
        
        [list removeObjectInIndex:2];
        printf("\n移除结点测试\n");
        NSLog(@"%@",list);
        
        NSArray *arr = @[@3,@9,@0,@7,@627,@67];
        
        list = nil;
        
        list = [[List alloc] initWithArray:arr];//用数组构建链表
        
//        arr = nil;
        
        NSLog(@"length is %ld",list.length); //查询长度，由于头结点存在，长度为自添加长度+1
        
        printf("\n第二次构造测试\n");
        NSLog(@"%@",list);
        
        [list mergeSort];
        printf("\n数字归并排序测试\n");
        NSLog(@"%@",list);
        
        list = [[List alloc] initWithArray:arr];
        
        [list sortWithComparisonBlock:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return NSOrderedAscending;
                }else{
                    return NSOrderedDescending;
                }
        }];// 排序器排序
        
        printf("\n排序器排序测试\n");
        NSLog(@"%@",list);
        
        printf("\n遍历测试(数字均为原值+1)\n");
        [list travelList:^(ListNode *currentNode, NSInteger index) {
           printf("%ld\n",[(NSNumber*)currentNode.Object integerValue] + 1);
        }];
        
        //栈 stack
        printf("\n\n栈 stack\n");
        
        Stack *stack = [[Stack alloc] init]; //构造空栈
        
        [stack push:@"one"];
        [stack push:@"two"];
        [stack push:@"three"]; //元素进栈
        
        printf("\nlength is %ld\n",stack.length);
        
        NSLog(@"%@",[stack top]);  //栈顶元素
        

        
        if ([stack isEmpty]) {          //测试空栈验证方法
            NSLog(@"此时为空栈");
        }else{
            NSLog(@"此时非空栈");
        }
        
        NSString *str;
        while ((str = [stack pop])) {  //元素出栈
            NSLog(@"%@",str);
        }
        
        str = nil;
        
        [stack clearStack];  //清栈
        
        if ([stack isEmpty]) {          //测试空栈验证方法
            NSLog(@"此时为空栈");
        }else{
            NSLog(@"此时非空栈");
        }
        
        stack = [[Stack alloc] initWithArray:arr];
        
        while (([stack top])) {  //元素出栈
            NSLog(@"%@",[stack pop]);
        }
        
        
        
        //队列 queue
        printf("\n\n三、队列 queue\n");

        Queue *queue = [[Queue alloc] initWithMaxLength:5];//构造一个最大长度为5的队列
        
        [queue enQueue:@"0"]; //入队列
        [queue enQueue:@"1"];
        [queue enQueue:@"2"];
        [queue enQueue:@"3"];
        [queue enQueue:@"4"];
        [queue enQueue:@"5"];
        [queue enQueue:@"6"];
        [queue enQueue:@"7"];
        
        [queue travelQueue:^(id object) {  //遍历队列元素
            NSLog(@"%@",object);
        }];
        
        printf("\n溢出区\n");
        for (NSString *str in queue.overflows){ //溢出区元素
            NSLog(str);
        }
        
        printf("\n出队列\n");
        
        while (queue.Head) {    //出队列
            NSLog(@"%@",[queue deQueue]);
        }
        
        //二叉树 binaryTree
        printf("\n\n三、二叉树 binaryTree\n");
        
        NSArray *arr1 = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G"];
        NSArray *arr2 = @[@"C",@"B",@"E",@"D",@"A",@"F",@"G"];
        
        BinaryTree *tree = [BinaryTree treeWithPreSequence:arr1 andInSequence:arr2]; //用先序序列与中序序列构造二叉树
        
        printf("\n先序遍历二叉树\n");
        [tree preOrderTraverseWithBlock:^(BinaryTreeNode *currentNode) {
            NSLog(@"%@",currentNode.value);
        }];
        
        printf("\n中序遍历二叉树\n");
        [tree inOrderTraverseWithBlock:^(BinaryTreeNode *currentNode) {
            NSLog(@"%@",currentNode.value);
        }];
        
        printf("\n后序遍历二叉树\n");
        [tree postOrderTraverseWithBlock:^(BinaryTreeNode *currentNode) {
            NSLog(@"%@",currentNode.value);
        }];
        
        tree = nil;
        
        
        //邻接表图 AdGraph
        printf("\n\n邻接表图 AdGraph\n");
        
        
                NSArray *VNodeArray = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,nil];
                ////将结点对象数据打包成数组
        
                NSArray *parameter = [NSArray arrayWithObjects:@"head",@"tail",@"info", nil];
        
                NSArray *date1 = [NSArray arrayWithObjects:@0,@1,[NSNull null], nil];
                NSArray *date2 = [NSArray arrayWithObjects:@0,@2,[NSNull null], nil];
                NSArray *date3 = [NSArray arrayWithObjects:@1,@3,[NSNull null], nil];
                NSArray *date4 = [NSArray arrayWithObjects:@1,@4,[NSNull null], nil];
                NSArray *date5 = [NSArray arrayWithObjects:@3,@7,[NSNull null], nil];
                NSArray *date6 = [NSArray arrayWithObjects:@4,@7,[NSNull null], nil];
                NSArray *date7 = [NSArray arrayWithObjects:@2,@5,[NSNull null], nil];
                NSArray *date8 = [NSArray arrayWithObjects:@2,@6,[NSNull null], nil];
                NSArray *date9 = [NSArray arrayWithObjects:@5,@6,[NSNull null], nil];
        
                NSDictionary *dic1= [NSDictionary dictionaryWithObjects:date1 forKeys:parameter];
                NSDictionary *dic2= [NSDictionary dictionaryWithObjects:date2 forKeys:parameter];
                NSDictionary *dic3= [NSDictionary dictionaryWithObjects:date3 forKeys:parameter];
                NSDictionary *dic4= [NSDictionary dictionaryWithObjects:date4 forKeys:parameter];
                NSDictionary *dic5= [NSDictionary dictionaryWithObjects:date5 forKeys:parameter];
                NSDictionary *dic6= [NSDictionary dictionaryWithObjects:date6 forKeys:parameter];
                NSDictionary *dic7= [NSDictionary dictionaryWithObjects:date7 forKeys:parameter];
                NSDictionary *dic8= [NSDictionary dictionaryWithObjects:date8 forKeys:parameter];
                NSDictionary *dic9= [NSDictionary dictionaryWithObjects:date9 forKeys:parameter];
        ////准备弧数据
                NSArray *arcArray = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,nil];
        ///打包成数组
        
        AdGraph *graph = [AdGraph creatAdGraphWithNodeValue:VNodeArray andArc:arcArray];
        ///构造图
        
        ///
        printf("\n\n广度优先遍历\n");
        [graph BFSWithBlock:^(AdGraphVNode *currentNode) {
            NSLog(@"%@",currentNode.value);
        }];
        
        printf("\n\n深度优先遍历\n");
        [graph DFSWithBlock:^(AdGraphVNode *currentNode) {
            NSLog(@"%@",currentNode.value);
        }];
        
        //由于十字链表图方法名跟效果与邻接表图十分相近，固不再作测试演示
        
    }
    return 0;
    
}

void insertSort(int *arr,int length)
{
    for (int i = 1; i<length; i++) {
        for (int j = i - 1; j >= 0 ; j--) {
            if (arr[i] <= arr[j] &&( (j == 0) || (arr[i] > arr[j-1])) ) {
                int temp = arr[i];
                for (int k = i - 1; k >= j; k--) {
                    
                    arr[k+1]= arr[k];
                }
                arr[j] = temp;
            }
        }
        printf("\n第%d次\n",i);
        for (int index = 0;index < 10 ; index++) {
            //            arr[i] = rand()%20;
            NSLog(@"%d",arr[index]);
        }
        printf("\n");
    }
}

void selectSort(int *arr, int length)
{
    for (int i = 0; i < length; i++) {
        int min = arr[i];
        int minIndex = i;
        for (int j = i; j < length; j++) {
            if (arr[j] < min) {
                min = arr[j];
                minIndex = j;
            }

        }
        if (minIndex != i) {
            int temp = arr[i];
            arr[i] = min;
            arr[minIndex] = temp;
        }

    }

}

void shellSort(int* arr, int length)
{
    for (int gap = length/2; gap; gap /= 2) {
        
        for (int i = 1; i<length; i += gap) {
            for (int j = i - gap; j >= 0 ; j -= gap) {
                if (arr[i] <= arr[j] &&((j == 0) || (arr[i] > arr[j-gap]) )) {
                    int temp = arr[i];
                    for (int k = i - gap; k >= j; k -= gap) {
                        arr[k+gap]= arr[k];
                    }
                    arr[j] = temp;
                }
            }
        }
        
    }
}

void quickSorting(int* arr,int head,int tail)
{
    if (head > tail) {
        return;
    }
    int base = arr[head];
    int i = head;
    int j = tail;
    while (!(i == j)) {
        while ((arr[j] >= base) && (i < j)) {
            j--;
        }
        while ((arr[i] <= base) && (i < j)) {
            i++;
        }
        if (i < j) {
            arr[i] += arr[j];
            arr[j] = arr[i] - arr[j];
            arr[i] = arr[i] - arr[j];
        }
    }
    arr[head] = arr[i];
    arr[i] = base;
    quickSorting(arr, head,i - 1);
    quickSorting(arr, i + 1, tail);
}

void quickSort(int* arr,int length)
{
    quickSorting(arr, 0, length - 1);
}


