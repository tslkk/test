//
//  main.m
//  Block_IMP
//
//  Created by Tang Shilei on 15/12/1.
//  Copyright © 2015年 5iWork. All rights reserved.
//

//（1）遍历数组或者字典（2）视图动画（3）排序（4）通知（5）错误处理（6）多线程（7）封装变化点



//struct __block_impl {
//    void *isa;
//    int Flags;
//    int Reserved;
//    void *FuncPtr;
//};
////static struct __main_block_desc_0{
////
////    size_t reserved;
////    size_t Block_size;
////
////} __main_block_desc_0_DATA={0,sizeof(struct __main_block_impl_0)};
////
// struct __main_block_impl_0{
//    struct __block_impl impl;
//    //    struct __main_block_desc_0*Desc;
//    //    __main_block_impl_0(void*fp,struct __main_block_desc_0*desc,int flags=0){
//    //        impl.isa=&_NSConcreteStackBlock;
//    //        impl.Flags=flags;
//    //        impl.FuncPtr=fp;
//    //        Desc=desc;
//    //
//    //
//    //    }//构造函数
//    
//    
// };

#import <Foundation/Foundation.h>
#include <malloc/malloc.h>



BOOL isChinese(NSString *str);

//KMP

void makeNext(const char P[],int next[]){
    
    int q,k;//k最大前后缀长度
    long m=strlen(P);
    next[0]=0;//版字符串的第一个字符的最大前后缀长度为0
    for(q=1,k=0;q<m;++q){//从第二个字符开始，依次计算每一个字符对应的next值
        while (k>0&&P[q]!=P[k]) {
            k=next[k-1];
        }
        if(P[q]==P[k]){//如果相等，最大相同前后缀长度+1
            k++;
        }
        next[q]=k;
    }
}

//KMP 模式匹配
void kmp(const char T[],const char P[],int next[]){
    
    long n,m;
    int i,q;
    n=strlen(T);
    m=strlen(P);
    makeNext(P, next);
    for(i=0,q=0;i<n;++i){
        
        while (q>0&&P[q]!=T[i]) {
            q=next[q-1];
        }
        if(P[q]==T[i]){
            q++;
        }
        if(q==m){
            printf("Pattern occurs with shift:%ld\n",(i-m+1));
        }
        
        
        
        
    }
}



//链表
typedef struct node{
    int data;
    struct node *pNext;
}Node;



void reverseLink(Node *link){
    if(link==NULL){
        return;
    }

}

//有头结点
Node *head=NULL;

//链表创建，头结点data=0,pNext=NULL;

bool createNodeList(){
    head =(Node*)malloc(sizeof(Node));
    if(NULL==head){
        return false;
        
    }else{
        head->data=0;
        head->pNext=NULL;
        return true;
    }
}

bool addNode(Node *node){
    if(NULL ==head){
        return false;
    }
    Node *p=head->pNext;
    Node *q=head;
    while (NULL!=p) {
        q=p;
        p=p->pNext;
    }
    q->pNext=node;
    node->pNext=NULL;
    return true;
}

bool deleteNode(int index){
    
    if(NULL==head){
        return false;
    }
    Node *p=head->pNext;
    int length=0;
    
    while (NULL!=p) {
        length++;
        p=p->pNext;
    }
    
    if(length<index){
        return false;
    }
    else{
        Node *q= head;
        p=head;
        
        for(int i=0;i<index;i++){
            q=p;
            p=p->pNext;
        }
        
        Node *t =p->pNext;
        q->pNext=t;
        free(p);
        return true;
    }
    
}

//链表逆序
void reverseNodeList(){
    
    if(NULL==head){
        return;
    }
    if(head->pNext==NULL){
        return;
    }
    Node *p=head->pNext;
    Node *q =p->pNext;
    Node *t =NULL;
    
    while (NULL!=q) {
        t=q->pNext;
        q->pNext=p;
        p=q;
        
        q=t;
    }
    head->pNext->pNext=NULL;
    head->pNext=p;
}

typedef struct tree{
    int data;
    struct tree *left,*right;
}ElemBT;

void btree(int list[],int bt[],int n){
    int i,order;
    bt[1]=list[0];
    for(i=1;i<n;i++){
        order=1;
        while (bt[order]!=0) {
            if(list[i]<bt[order]){
                order*=2;
            }else{
                order=order*2+1;
            }
        }
        
        bt[order]=list[i];
    }
}

//二叉搜索树
void create_btree(ElemBT*root,int list[],int n){
    
    int i;
    ElemBT *current,*parent = NULL,*p;
    
    for(i=1;i<n;i++){
        p=(ElemBT*)malloc(sizeof(ElemBT));
        p->left=p->right=NULL;
        p->data =list[i];
        current = root;
        while (current!=NULL) {
            parent =current;
            if(current->data>p->data){
                current =current->left;
            }else{
                current =current->right;
            }
        }
        if(parent->data >p->data){
            parent->left=p;
        }else{
            parent->right =p;
        }
    }
}

int traverseBiTreePreOrder(ElemBT *ptree,int (*visit)(int))
{
    if(ptree)
    {
        if(visit(ptree->data))
            if(traverseBiTreePreOrder(ptree->left,visit))
                if(traverseBiTreePreOrder(ptree->right,visit))
                    return 1;  //正常返回
        return 0;   //错误返回
    }else return 1;   //正常返回
}

void preOrderTraverse(ElemBT *root){
    if(root){
        printf("s %d\n",root->data);
        preOrderTraverse(root->left);
        preOrderTraverse(root->right);
    }
}
void inOrderTraverse(ElemBT *root){
    if(root){
        
        inOrderTraverse(root->left);
        printf("in %d\n",root->data);
        inOrderTraverse(root->right);
        
    }
}

void lastOrderTraverse(ElemBT*root){
    if(root){
        lastOrderTraverse(root->left);
        lastOrderTraverse(root->right);
        printf("last %d\n",root->data);
        
    }
    
}
//函数指针
int visit(int a){
    return 1;
}



void reverseLinkedList(Node*L){
    
    if(L== NULL)
        return;
    if(L->pNext==NULL)
        return;
    
    Node *head=  L->pNext;//1
    
    Node *next = head->pNext;//2
    
    head->pNext= NULL;//1脱离
    
    Node *prev = NULL;
    
    
    while (next!=NULL) {//
        prev = next->pNext;//(1)
        
        next->pNext = head; //(2)指向脱离得前一位
        
        head  =  next;//head (3)向后移动一位
        
        
        next = prev;//(4)
    }
    
    L->pNext=head;
}



typedef struct node *PNode;

typedef  struct{//队列
    
    PNode front;
    PNode rear;
    int size;
    
}Queue;

 Queue * initQueue(){
     Queue *pQueue =(Queue*)malloc(sizeof(Queue));
     if(pQueue!=NULL){
         
         pQueue->front=NULL;
         pQueue->rear =NULL;
         pQueue->size=0;
     }
     return pQueue;
 }

int isEmpty(Queue*queue){
    if(queue->front==NULL&&queue->rear ==NULL&&queue->size==0){
        return 1;
    }else{
        return 0;
    }
}

//清空一个队列
void clearQueue(Queue*queue){
    while (isEmpty(queue)!=1) {
        
    }
}
//销毁一个队列
void destoryQueue(Queue*queue){
   if(isEmpty(queue)!=1)
       clearQueue(queue);
    free(queue);
}

int getSize(Queue*queue){
    return queue->size;
}


PNode getFront(Queue *queue,int *item){
    
    if(isEmpty(queue)!=1&&item!=NULL){
        *item =queue->front->data;
    }
    
    return queue->front;
    
}


PNode getRear(Queue*queue,int *item){
    if(isEmpty(queue)!=1&&item!=NULL){
        *item =queue->rear->data;
    }
    return queue->rear;
    
    
}

//将新元素入队
PNode enQueue(Queue*queue,int item){
    PNode pnode =(PNode)malloc(sizeof(Node));
    if(pnode!=NULL){
        pnode->data=item;
        pnode->pNext=NULL;
        
        if(isEmpty(queue)){
            queue->front =pnode;
        }else{
            queue->rear->pNext=pnode;
            
        }
        queue->rear=pnode;
        queue->size++;
    }
    
    return pnode;
}



//对头元素出队
PNode deQueue(Queue *queue,int *item){
    PNode pnode=queue->front;
    if(isEmpty(queue)!=1&&pnode!=NULL){
        
        if(item!=NULL){
            *item =pnode->data;
        }
        
        queue->size--;
        queue->front =pnode->pNext;
        free(pnode);
        
        if(queue->size==0){
            queue->rear=NULL;
        }
        
        
    }
    return queue->front;
    
    
}

void queueTraverse(Queue *queue){
    PNode node =queue->front;
    int i=queue->size;
    while (i--) {
        printf("aa%d",node->data);
        node =node->pNext;
        
    }
}

//字符串逆序
void revers()
{
    char c;
    if((c = getchar()) != '\n')
        revers();
    if(c != '\n'){
        printf("数据%c\n",c);
        //putchar(c);
    }
}

int main(int argc, const char * argv[]) {
    
//    int list[7]={30,18,16,25,34,7,31};
//    
//    Node *node=(Node*)malloc(sizeof(Node));
//    node->data=0;
//    for(int i=0;i<7;i++){
//        Node *link =(Node*)malloc(sizeof(Node));
//        link->data=list[i];
//        if(node==NULL){
//            node = link;
//            NSLog(@"走起");
//        }else{
//            Node *current =node;
//            while (current->pNext!=NULL) {
//                current=current->pNext;
//            }
//            current->pNext =link;
//            
//        }
//    }
//    
//    Node *a=node;
//    while (a!=NULL) {
//        printf("开始%d\n",a->data);
//        a = a->pNext;
//    }
//    
//    reverseLinkedList(node);
//    while (node!=NULL) {
//        
//        printf("逆序后%d\n",node->data);
//        node =node->pNext;
//    }
//    

    
//    ElemBT *root;
//    root =(ElemBT*)malloc(sizeof(ElemBT));
//    root->data =list[0];
//    root->left = root->right=NULL;
    
//    create_btree(root, list, 7);
//    //preOrderTraverse(root);
//    inOrderTraverse(root);
    
    //revers();
    
//         int i;
//         int next[20]={0};
//         char T[] = "ababxbababcadfdsss";
//         char P[] = "ababxbb";
//         printf("%s\n",T);
//         printf("%s\n",P );
//         // makeNext(P,next);
//         kmp(T,P,next);
//         for (i = 0; i < strlen(P); ++i){
//                     printf("%d ",next[i]);
//         }
    
    //NSString *str1=@"hello world";
    
//    NSString *str2 = str1;
//    str2=@"str";
//    
//    NSLog(@"str1 ==str2 %d",str1==str2);
//    NSLog(@"str1 %@ %p str2 %@ %p",str1,&str1,str2,&str2);
//    
//    
//    NSMutableString *str3 =[NSMutableString stringWithString:str1];
//    NSMutableString *str4 = [str3 mutableCopy];
//    //[str4 setString:@"kobe"];
//    NSLog(@"str3 ==str4 %d",str3==str4);
//    NSLog(@"str3 %@ %p str4 %@ %p",str3,&str3,str4,&str4);
    
    
    NSString *str =@"一";
    
    NSLog(@"中文 %d",isChinese(str));
    return 0;
}


   BOOL isChinese(NSString *str){
    for(int i=0; i< [str length];i++){
        
//        NSRange range =NSMakeRange(i, 1);
//        NSString *subString =[str substringWithRange:range];
//        const char*cString =[subString UTF8String];
//        if(!(strlen(cString)==3)){
//            return NO;
//        }
        
        
        int a = [str characterAtIndex:i];
        if( !(a >= 0x4E00 && a <= 0x9FA5)){
            return NO;
        }
    }
    return YES;
   }


//struct Block_descriptor{
//    unsigned long int reserved;
//    unsigned long int size;
//    void (*copy)(void*dst,void *src);
//    void (*dispose)(void*);
//    
//};
//
//struct Block_layout{
//    void *isa;//isa 指针，所有对象都有该指针，用于实现对象相关的功能。
//    int flags;//用于按 bit 位表示一些 block 的附加信息，本文后面介绍 block copy 的实现代码可以看到对该变量的使用。
//    int reserved;//保留变量。
//    void (*invoke)(void *,...);//函数指针，指向具体的 block 实现的函数调用地址
//    struct Block_descriptor*descriptor;//表示该 block 的附加描述信息，主要是 size 大小，以及 copy 和 dispose 函数的指针。
//    //Imported variables //capture 过来的变量，block 能够访问它外部的局部变量，就是因为将这些变量（或变量的地址）复制到了结构体中。
//    //_NSConcreteGlobalBlock 全局的静态 block，不会访问任何外部变量。
//    //_NSConcreteStackBlock 保存在栈中的 block，当函数返回时会被销毁。
//    //_NSConcreteMallocBlock 保存在堆中的 block，当引用计数为 0 时会被销毁。
//    
//    
//};
//
//struct __block_impl {
//    void *isa;
//    int Flags;
//    int Reserved;
//    void *FuncPtr;
//};
////static struct __main_block_desc_0{
////    
////    size_t reserved;
////    size_t Block_size;
////    
////} __main_block_desc_0_DATA={0,sizeof(struct __main_block_impl_0)};
////
//struct __main_block_impl_0{
//    struct __block_impl impl;
////    struct __main_block_desc_0*Desc;
////    __main_block_impl_0(void*fp,struct __main_block_desc_0*desc,int flags=0){
////        impl.isa=&_NSConcreteStackBlock;
////        impl.Flags=flags;
////        impl.FuncPtr=fp;
////        Desc=desc;
////        
////        
////    }//构造函数
//    
//    
//};
//
//static void __main_block_func_0(struct __main_block_impl_0 *__cself){
//    
//}
//
//

//二叉查找树（二叉搜索树，二叉排序树）BST 特点：根节点大于所有左子树得值，小于所有右子树上的值
//BST定义：递归得定义，要么是一棵空树，如果不为空，（1）那么其左子树节点的值都小于根节点得值，右子树节点的值都大于根节点的值，其左右子树也是二叉搜索树,（4）中序遍历一颗二叉搜索树得到的结果是递增序列

//BST在数据结构中占有很重要的地位，些高级树结构都是其的变种,AVL树、红黑树,同时利用BST可以进行排序，称为二叉排序，也是很重要的一种思想


//AVL树 对于BST的（1）（4）都是满足的，AVL树本身有更强得限制条件，要求所有左子树和右子树高度差得绝对值不能超过1，在插入和删除得时候不仅要保证其有序性，还要保证其平衡性，所以他的插入删除有更复杂得操作



//哈希表（Hash table，也叫散列表），是根据关键码值(Key value)而直接进行访问的数据结构。也就是说，它通过把关键码值映射到表中一个位置来访问记录，以加快查找的速度。这个映射函数叫做散列函数，存放记录的数组叫做散列表。
//哈希表的做法其实很简单，就是把Key通过一个固定的算法函数既所谓的哈希函数转换成一个整型数字，然后就将该数字对数组长度进行取余，取余结果就当作数组的下标，将value存储在以该数字为下标的数组空间里。而当使用哈希表进行查询的时候，就是再次使用哈希函数将key转换为对应的数组下标，并定位到该空间获取value，如此一来，就可以充分利用到数组的定位性能进行数据定位









