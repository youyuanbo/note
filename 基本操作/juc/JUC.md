# JUC

## Volatile关键字

特性：

 1.   可见性

     当多个线程进行共享数据操作时，可以保证内存中的数据可见。

     执行顺序：各个线程把主存中的数据拷贝到各自的工作区中，某个线程A对数据进行修改后，把数据写会到主存中，同时会通知其他线程，数据已经被改变，其他各个线程会重新拷贝主存中的数据。

     使用volatile关键字

     ```java
     package com.xiaoyou.juc;
     
     class ThreadDemo implements Runnable{
     
         private volatile boolean flag = false;
     
         public boolean isFlag() {
             return flag;
         }
     
         public void setFlag(boolean flag) {
             this.flag = flag;
         }
     
         @Override
         public void run() {
     
             try {
                 Thread.sleep(200);
             } catch (InterruptedException e) {
                 e.printStackTrace();
             }
     
             flag = true;
             System.out.println("flag=" + isFlag());
         }
     
     }
     
     
     public class TestVolatile {
         public static void main(String[] args) {
             ThreadDemo demo = new ThreadDemo();
             new Thread(demo).start();
     
             while (true){
                 if (demo.isFlag()){
                     System.out.println("---------------");
                     break;
                 }
             }
     
         }
     }
     
     ```

     volatile与synchronized的区别

     

     |        | volatile             | synchronized |
     | ------ | -------------------- | ------------ |
     | 互斥性 | 不具备               | 具备         |
     | 原子性 | 不能保证变量的原子性 |              |
     |        |                      |              |

     

2. 不可重排序

3. 不具有原子性

   不具备原子性的代码，存在线程安全问题

   ```java
   package com.xiaoyou.juc;
   
   public class TestAtomicDemo {
       public static void main(String[] args) {
           AtomicDemo atomicDemo = new AtomicDemo();
           for (int i = 0; i < 10; i++) {
               new Thread(atomicDemo).start();
           }
       }
   
   
   }
   
   class AtomicDemo implements Runnable{
   
       private volatile int serialNumber = 0;
   
       public int getSerialNumber() {
           return serialNumber++;
       }
   
       @Override
       public void run() {
           try {
               Thread.sleep(200);
           } catch (InterruptedException e) {
               e.printStackTrace();
           }
   
           System.out.println(Thread.currentThread().getName() + "\t" + getSerialNumber());
       }
   }
   ```

   解决方法：使用原子变量，在jdk1.5之后，java.util.concurrent.atomic包下提供了常用的原子变量

    1.  在该包下的类中，使用volatile关键字，保证了内存可见性

    2.  使用了CAS（Compare-And-Swap）算法，保证数据的原子性。

        CAS算法是硬件对于并发操作共享数据的支持

        CAS包含了三个操作数：

        1. 内存值 V
        2. 预估值 A
        3. 更新值 B

        当且仅当V==A时，V=B，否则将不做任何操作

   