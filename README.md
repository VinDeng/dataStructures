一、List 链表

基本属性：长度length，头结点head

结点结构：1.next属性指向下一结点  
        2.object属性指向一个对象 PS：头结点的Object属性保持指向nil,并不能被本API提供的大部分方法所修改，用户自行修改可能会导致不可预料的BUG。

方法说明：

        1.length属性动态由get方法动态获取，复杂度为O(n)

        2.构造方法：可以直接init，然后手动插入结点
            - (instancetype)initWithArray:(NSarray *)array 由数组链表构造链表

        3.插入方法：
            - (void)insertObject:(id)object inIndex:(NSInteger)index; //此方法可以修改头结点，不推荐在单纯的链表数据结构中使用(index = 0时）
            - (void)insertObjectAtLastIndex:(id)object;
            - (void)insertObjectAtFirstIndex:(id)object;

        4.删除方法：
        - (void)removeObjectInIndex:(NSInteger)index; //同上，可能导致头结点变化

        5.查找数据方法：
        - (NSInteger)locateObject:(id)object;                     //定位数据，找不到的时候输出-1
        - (NSArray*)locateObjectAll:(id)object;		//返回所有具有同样对象的位置打包成的数		组，一个没有找到的返回nil

        6.排序方法：
        - (void)mergeSort;  //归并排序，只针对NSNumber子类的排序

        - (void)sortWithComparisonBlock:(NSComparisonResult(^)(id _Nonnull obj1, id _Nonnull obj2))cmptr; //采用了NS比较器的排序方法，可以自定义排序条件

        7.遍历方法：
        - (void)travelList:(nullable void(^)(listNode* currentNode, NSInteger index))visitBlock;
        //在传入的visitBlock中对遍历元素进行操作

二、Stack 栈

基本属性：1.length属性，动态查询堆栈长度
        2.top属性，返回栈顶元素，不出栈

结点结构：所有暴露的方法的最细颗粒度参数均为对象，在使用者角度不存在某一结点的概念

方法说明：

        1.构造方法: 
        - (instancetype)init //构造空栈
        - (instancetype)initWithArray:(NSarray *)array //用数组元素构造栈

        2.堆操作：   
        - (void)clearStack //清栈
        - (void)push:(id)object //元素进栈
        - (id)pop //元素出栈，返回栈顶元素
        - (BOOL)isEmpty  //判别是否空栈

        3.遍历方法  
        - (void)travelStack:(nullable void(^)(id currentObject))visitBlock;  //遍历栈中元素，再visitBlock中进行修改

三、Queue 队列

基本属性：
        1.length属性 动态查询队列长度
        2.overflows属性，存放超过队列长度的溢出元素，是一个NSArray
        
结点结构：所有暴露的方法的最细颗粒度参数均为对象，在使用者角度不存在某一结点的概念
        
方法说明：

        1.构造方法：
        - (instancetype)init //构造空队列 最大长度为1000
        - (instancetype)initWithMaxLength:(NSInteger)length //自定最大长度构造队列

        2.队列操作: 
        - (void)clearQueue //清空队列 
        - (id)Head;        //返回队头元素
        - (void)enQueue:(id)object; //元素入队，超过最大量则入溢出区
        - (id)deQueue;            //元素出队，返回队头元素

        
        3.遍历方法  
        - (void)travelStack:(nullable void(^)(id currentObject))visitBlock;  //遍历栈中元素，再visitBlock中进行修改

四、BinaryTree 二叉树

基本属性：

        1.root属性，指向根节点
        2.depth 表示此二叉树的深度

结点结构:结点名称:binaryTreeNode

        id value //结点存放的对象值
        binaryTreeNode *leftChild //左孩子
        binaryTreeNode *right //右孩子
        binaryTreeNode *parent //双亲
        //以上属性可以根据用户需要自行赋值

        bool leftTag //左标签
        bool rightTag //右标签
        //以上标签用于线索二叉树，用户私自修改会引发不可预知的后果

        - (binaryTree *)leftSibling //返回左兄弟，若没有左兄弟，则返回nil
        - (binaryTree *)rightSibling //返回右兄弟，若没有右兄弟，则返回nil

方法说明：

        1.构造方法：
        + (instancetype)treeWithArray:(NSArray *)array //用一个数组内的对象以先序遍历的方法构建二叉树
        + (instancetype)treeWithPreSequence:(NSArray *)preSequence andInSequence:(NSArray *)inSequence //用先序序列与中序序列构建二叉树

        -（instancetype)init //创建空树



        2.遍历:
        - (void)preOrderTraverseWithBlock:(void (^)(binaryTreeNode * currentNode))visitBlock  //先序，下面分别为中序和后序
        - (void)inOrderTraverseWithBlock:(void(^)(binaryTreeNode *currentNode))visitBlock
        - (void)postOrderTraverseWithBlock:(void(^)(binaryTreeNode *currentNode))visitBlock

        3.线索化: 
        - (void)preOrderThreading//先序线索化
        - (void)inOrderThreading;//中序线索化
        - (void)postOrderThreading //后序线索化
        - (void)unthreading;//去线索化

        //线索化后，此二叉树的遍历方法不再使用栈，可以节约空间资源


五、AdGraph 邻接表图

基本属性 
        1.vexNum属性，表示顶点的数目
        2.arcNum属性，表示弧的数目
        3.VNodes属性，存放顶点的一个数组

结点结构：

一、顶点结点：
        1.id value: 此顶点存放的值
        2.AdGraphArcNode *firstArcNode:此顶点指向的第一根出弧
        +(instancetype)VNodeWithValue:(id)value  //返回一个带有value值的顶点

二、弧结点：
        1.AdGraphVNode *adVNode //此弧指向的顶点
        2.AdGraphArcNode *nextArcNode //此弧指向的下一根弧（同一出发点）
        3.id info //此弧带着的信息对象


方法说明：

        1.构造方法：
        + (instancetype)creatAdGraphWithNodeValue:(NSArray *)value andArc:(NSArray *)arc  //通过顶点结点内的元素以及顶点之间的指向关系构造图，其中value数组内部直接存放目标对象，arc数组内则存放对象以tail,head,info为key的字典对象，具体的使用例子可以参考测试代码。

        2.弧操作:- (void)addArcWithImformation:(NSDictionary *)dic;
        //构造一条弧
        - (void)removeArc:(AdGraphArcNode *)arc;
        //删除一条已知的弧
        - (void)removeAllArcBetweenVNodeA:(AdGraphVNode *)VNodeA andVNodeB:(AdGraphVNode *)VNodeB
        //删除两点之间所有弧
        - (void)removeAllArcFromVNodeA:(AdGraphVNode *)VNodeA toVNodeB:(AdGraphVNode *)VNodeB;
        //删除从点A指向点B的所有弧
        - (void)removeArcBetweenVNodeA:(AdGraphVNode *)VNodeA andVNodeB:(AdGraphVNode *)VNodeB WithInfo:(id)info;
        //删除点A与点B之间信息为Info的全部弧
        - (void)removeArcFromVNodeA:(AdGraphVNode *)VNodeA toVNodeB:(AdGraphVNode *)VNodeB WithInfo:(id)info;
        //删除从点A指向点B并信息为Info的全部弧
        - (void)removeVNode:(AdGraphVNode *)VNode;
        //删除顶点并移除所有与此节点有关的弧


        3.遍历:
        - (void)BFSWithBlock:(void (^)(AdGraphVNode *currentNode))visitBlock;
        //广度优先

        - (void)DFSWithBlock:(void (^)(AdGraphVNode *currentNode))visitBlock;
        //深度优先