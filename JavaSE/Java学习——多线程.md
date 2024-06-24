# Java学习——多线程

## 一些概念

- 线程是进程中的实际运作单位线程是操作系统能够进行运算调度的**最小单位**。它被包含在进程之中，是**进程的实际运作单位**
- 简单理解，是**软件中相互独立，可以同时运行的功能**，为了提高效率
- **并发：**同一时刻，多个指令在**单个**CPU**交替**执行
- **并行：**同一时刻，多个指令在**多个**CPU上**同时**执行

## 多线程的实现方式

![image-20240522175516043](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240522175516043.png)

### 继承Thread类的方式进行实现

```java
public class MyThread extends Thread{
    @Override
    public void run() {
        for (int i = 0; i < 10; i++) {
            System.out.println(getName()+" "+i);
        }
    }
}
```

```java
public static void main(String[] args) {
    /*
    *  多线程的第一种启动方式
    *  1、自己定义一个类继承Thread类
    *  2、重写里面的run()方法
    *  3、创建子类的对象，并且启动线程
    * */

    MyThread t1=new MyThread();
    MyThread t2=new MyThread();
    t1.setName("线程1");
    t2.setName("线程2");

    t1.start();
    t2.start();
}
```

### 实现Runnable接口的方式进行实现

```java
public class MyRun implements Runnable{
    @Override
    public void run() {
        for (int i = 0; i < 10; i++) {
            // 获取当前的线程
            Thread thread = Thread.currentThread();
            System.out.println(thread.getName()+" "+i);
        }
    }
}
```

```java
public static void main(String[] args) {
    /*
     *  多线程的第二种启动方式
     *  1、自己定义一个类实现Runnable接口
     *  2、重写里面的run()方法
     *  3、创建自己的类对象
     *  4、创建一个Thread类对象，并开启线程
     * */
    // 可以理解为多线程要执行的任务
    MyRun mr=new MyRun();
    // 创建一个线程
    Thread t1=new Thread(mr);
    Thread t2=new Thread(mr);
    t1.setName("线程1");
    t2.setName("线程2");

    t1.start();
    t2.start();
}
```

### 利用Callable接口和Future接口方式实现

```java
public class MyCallable implements Callable<Integer> {
    @Override
    public Integer call() throws Exception {
        int sum=0;
        for (int i = 0; i < 100; i++) {
            sum+=i;
        }
        return sum;
    }
}
```

```java
public static void main(String[] args) throws ExecutionException, InterruptedException {
    /*
    *  多线程的第三种实现方式
    *  特点：可以获取到多线程运行的结果
    *  1、创建MyCallable类实现Callable接口
    *  2、重写里面的call()方法 是有返回值的，表示多线程运行的结果
    *  3、创建MyCallable类的对象，表示多线程要执行的任务
    *  4、创建FutureTask的对象，用于管理多线程运行的结果
    *  5、创建Thread类的对象，表示线程
    * */

    // 表示多线程要执行的任务
    MyCallable mc=new MyCallable();
    // 创建FutureTask的对象 用于管理多线程的结果
    FutureTask<Integer>ft=new FutureTask<>(mc);
    Thread t1=new Thread(ft);
    t1.start();
    Integer i = ft.get();
    System.out.println(i);
}
```

## 常见的成员方法

![image-20240522180839437](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240522180839437.png)

```java
public static void main(String[] args) throws InterruptedException {
    /*
        String getName()                    返回此线程的名称
        void setName(String name)           设置线程的名字（构造方法也可以设置名字）
        细节：
            1、如果我们没有给线程设置名字，线程也是有默认的名字的
                    格式：Thread-X（X序号，从0开始的）
            2、如果我们要给线程设置名字，可以用set方法进行设置，也可以构造方法设置
               使用构造方法时，需要重写构造函数

        static Thread currentThread()       获取当前线程的对象
        细节：
            当JVM虚拟机启动之后，会自动的启动多条线程
            其中有一条线程就叫做main线程
            他的作用就是去调用main方法，并执行里面的代码
            在以前，我们写的所有的代码，其实都是运行在main线程当中

        static void sleep(long time)        让线程休眠指定的时间，单位为毫秒
        细节：
            1、哪条线程执行到这个方法，那么哪条线程就会在这里停留对应的时间
            2、方法的参数：就表示睡眠的时间，单位毫秒
                1 秒= 1000毫秒
            3、当时间到了之后，线程会自动的醒来，继续执行下面的其他代码
   */

//        MyThread t1=new MyThread();
//        MyThread t2=new MyThread();
//
//        t1.start();
//        t2.start();
    System.out.println("111");
    Thread.sleep(5000);
    System.out.println("222");

}
```

Java中，线程是**抢占式调度**，优先级越高，随机的概率就越大，优先级（1~10），**默认是5**

```java
public static void main(String[] args) {
    // 线程的优先级
    MyRunnable mr=new MyRunnable();
    Thread t1=new Thread(mr,"飞机");
    Thread t2=new Thread(mr,"坦克");

    t1.setPriority(1);
    t2.setPriority(10);

    t1.start();
    t2.start();
}
```

```java
public static void main(String[] args) {
    /*
        final void setDaemon(boolean on)    设置为守护线程
        细节：
            当其他的非守护线程执行完毕之后，守护线程会陆续结束
        通俗易懂：
            当女神线程结束了，那么备胎也没有存在的必要了
   */

    MyThread1 t1=new MyThread1("女神");
    MyThread2 t2=new MyThread2("备胎");

    t2.setDaemon(true);

    t1.start();
    t2.start();
}
```

```java
public class MyThread extends Thread{
    public MyThread(String name) {
        super(name);
    }

    @Override
    public void run() {
        for (int i=0;i<10;i++) {
            System.out.println(getName()+"-"+i);

            // 表示让出CPU的执行权
            Thread.yield();
        }
    }
}

public static void main(String[] args) {
    MyThread t1=new MyThread("飞机");
    MyThread t2=new MyThread("坦克");

    t1.start();
    t2.start();
}
```

### 线程的生命周期

![image-20240525153535211](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240525153535211.png)



## 线程安全问题

执行同步代码块的时候，需要把**操作共享数据的代码锁起来**

### 同步代码块

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240524152413235.png" alt="image-20240524152413235" style="zoom:50%;" />

特点1：锁**默认打开**，有一个线程进去了，锁**自动关闭**

特点2：里面的代码全部**执行完毕**，线程出来，锁**自动打开**

细节1：**锁对象**必须是是**唯一**的

细节2：synchronized**不能写在**while()循环的**外面**

```java
public class MyThread extends Thread{
    public MyThread() {
    }

    public MyThread(String name) {
        super(name);
    }

    //表示这个类所有的对象，都共享ticket数据
    static int ticket = 0;//0 ~ 99

    @Override
    public void run() {
        while (true) {
            // 锁对象一定是要唯一的 一般使用类名.class 表示字节码文件
            synchronized (MyThread.class) {
                //同步代码块
                if (ticket < 100) {
                    try {
                        Thread.sleep(10);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    ticket++;
                    System.out.println(getName() + " 正在卖第 " + ticket + " 张票！！！");
                } else {
                    break;
                }
            }
        }
    }
}
```

### 同步方法

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240524154243428.png" alt="image-20240524154243428" style="zoom: 50%;" />

特点1：同步方法是**锁住方法里面的所有的代码**

特点2：锁对象**不能自己指定**，如果当前方法是**非静态**的，那么锁对象是**this**，如果是**静态**的，锁对象是当前类的**字节码文件对象**

```java
public class MyRunnable implements Runnable{
    int ticket=0;
    @Override
    public void run() {
        // 1、循环
        // 2、写同步代码块（同步方法）
        // 3、判断共享数据是否到了末尾，如果到了末尾
        // 4、如果没到末尾
        // 5、ctrl+alt+M 快捷键抽取
        while (true)
        {
            if (method()) break;
        }
    }

    private synchronized boolean method() {
        if(ticket==50) {
            return true;
        }
        else {
            try {
                Thread.sleep(50);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            ticket++;
            System.out.println(Thread.currentThread().getName()+" 窗口卖了第 "+ticket+" 张票");
        }
        return false;
    }
}

public static void main(String[] args) {
    // 需求：某电影院目前正在上映国产大片，共有100张票，而它有3个窗口卖票，请设计一个程序模拟该电影院卖票
    // 利用同步方法
    // 技巧：先写同步代码块，再写同步方法

    MyRunnable mr=new MyRunnable();
    Thread t1=new Thread(mr);
    Thread t2=new Thread(mr);
    Thread t3=new Thread(mr);

    t1.setName("窗口1");
    t2.setName("窗口2");
    t3.setName("窗口3");

    t1.start();
    t2.start();
    t3.start();
}
```

StringBuffer是**多线程安全的**，StringBuilder**用于单线程**

### Lock锁

- Lock实现提供比使用synchronized方法和语句可以获得更广泛的锁定操作
- Lock中提供了获得锁和释放锁的方法
- void lock():获得锁，手动上锁、手动释放锁
- void unlock():释放锁

- Lock是接口不能直接实例化，这里采用它的实现类ReentrantLock来实例化
- ReentrantLock的构造方法
- 创建一个ReentrantLock的实例ReentrantLock()

```java
public class MyThread extends Thread{
    public MyThread() {
    }

    public MyThread(String name) {
        super(name);
    }

    static int ticket=0;
    static Lock lock=new ReentrantLock();

    @Override
    public void run() {
        while (true)
        {
            lock.lock();
            try {
                if (ticket == 100) {
                    break;
                } else {

                    Thread.sleep(10);

                    ticket++;
                    System.out.println(getName() + " 窗口卖了第 " + ticket + " 张票");
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            } finally {
                lock.unlock();
            }
        }
    }
}
```

## 死锁

### 等待唤醒机制

![image-20240525133910304](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240525133910304.png)

```java
public class Cook extends Thread{
    public Cook() {
    }

    public Cook(String name) {
        super(name);
    }

    @Override
    public void run() {
        /*
        *  1、循环
        *  2、同步代码块
        *  3、 判断共享数据是否到了末尾，如果到末尾
        *  4、 没有到末尾
        * */
        while (true)
        {
            synchronized (Desk.lock)
            {
                if(Desk.count==0)
                {
                    // 如果达到终止条件
                    break;
                }
                else
                {
                    if(Desk.foodFlag==1)
                    {
                        // 如果桌子上有面
                        // 等待
                        try {
                            Desk.lock.wait();
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                    else
                    {
                        // 如果桌子上没面
                        System.out.println("厨师做了一碗面");
                        Desk.foodFlag=1;
                        Desk.lock.notifyAll();
                    }
                }
            }
        }
    }
}

public class Foodie extends Thread{
    public Foodie() {
    }

    public Foodie(String name) {
        super(name);
    }

    @Override
    public void run() {
        /*
         *  1、循环
         *  2、同步代码块
         *  3、 判断共享数据是否到了末尾，如果到末尾
         *  4、 没有到末尾
         * */
        while (true)
        {
            synchronized (Desk.lock)
            {
                if(Desk.count==0)
                {
                    break;
                }
                else
                {
                    // 先判断桌子上有没有面条
                    // 无：等待
                    // 有：吃
                    // 吃完之后唤醒厨师
                    // 总数减少
                    // 修改桌子的状态
                    if(Desk.foodFlag==1)
                    {
                        Desk.count-=1;
                        System.out.println("吃面条，还能再吃 "+Desk.count+" 碗");
                        Desk.lock.notifyAll();
                        Desk.foodFlag=0;
                    }
                    else
                    {
                        // 没有就等待
                        try {
                            Desk.lock.wait();
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
    }
}

public class Desk {
    /*
    *  作用：控制生产者和消费者的执行
    * */

    // 判断桌子上是否有面条 1：有 0：无
    public static int foodFlag=0;

    // 总个数
    public static int count=10;

    // 锁
    public static Object lock=new Object();
}

public class WaitAndNotifyDemo01 {
    public static void main(String[] args) {
        /*
         *
         *    需求：完成生产者和消费者（等待唤醒机制）的代码
         *         实现线程轮流交替执行的效果
         *
         * */
        Cook cook=new Cook("厨师");
        Foodie foodie=new Foodie("吃货");

        cook.start();
        foodie.start();
    }
}
```

#### 阻塞队列实现

put数据时，**放不进去**，则等待，也叫做**阻塞**

take数据时，取出第一个数据，**取不到**，则等待，则叫做**阻塞**

##### 继承结构

![image-20240525151410348](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240525151410348.png)

```java
public class Cook extends Thread{
    ArrayBlockingQueue<String>queue;

    public Cook(ArrayBlockingQueue<String> queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        while (true)
        {
            // 不断的吧面条放到队列中
            // 队列中的put() 方法本来就有锁，不需要自己写
            try {
                queue.put("面条");
                System.out.println("厨师放了一碗面");
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public class Foodie extends Thread{
    ArrayBlockingQueue<String> queue;

    public Foodie(ArrayBlockingQueue<String> queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        while (true)
        {
            // 不断地从队列中取面条
            try {
                String take = queue.take();
                System.out.println(take);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public static void main(String[] args) {
    /*
     *    需求：利用阻塞队列完成生产者和消费者（等待唤醒机制）的代码
     *    细节：
     *           生产者和消费者必须使用同一个阻塞队列
     *
     * */
    // 创建阻塞队列的对象

    ArrayBlockingQueue<String>queue=new ArrayBlockingQueue<>(1);
    Cook cook=new Cook(queue);
    Foodie foodie=new Foodie(queue);

    cook.start();
    foodie.start();
}
```

## 练习

```java
public class Exercise05 {
    public static void main(String[] args) throws ExecutionException, InterruptedException {

        /*
            有一个抽奖池,该抽奖池中存放了奖励的金额,该抽奖池中的奖项为 {10,5,20,50,100,200,500,800,2,80,300,700};
            创建两个抽奖箱(线程)设置线程名称分别为    "抽奖箱1", "抽奖箱2"
            随机从抽奖池中获取奖项元素并打印在控制台上,格式如下:

            在此次抽奖过程中，抽奖箱1总共产生了6个奖项，分别为：10,20,100,500,2,300
        	    最高奖项为300元，总计额为932元

            在此次抽奖过程中，抽奖箱2总共产生了6个奖项，分别为：5,50,200,800,80,700
            	最高奖项为800元，总计额为1835元

            在此次抽奖过程中,抽奖箱2中产生了最大奖项,该奖项金额为800元
            核心逻辑：获取线程抽奖的最大值（看成是线程运行的结果）


            以上打印效果只是数据模拟,实际代码运行的效果会有差异
        */

        ArrayList<Integer>list=new ArrayList<>();
        TreeMap<String,ArrayList<Integer>>map=new TreeMap<>();
        Collections.addAll(list,10,5,20,50,100,200,500,800,2,80,300,700);

        MyCallable mc=new MyCallable(list);

        FutureTask<Integer> ft1=new FutureTask<>(mc);
        FutureTask<Integer> ft2=new FutureTask<>(mc);

        Thread t1=new Thread(ft1,"抽奖箱1");
        Thread t2=new Thread(ft2,"抽奖箱2");

        t1.start();
        t2.start();
        
        int i1= ft1.get();
        int i2= ft2.get();
    }
}

public class MyCallable implements Callable<Integer> {
    public MyCallable(ArrayList<Integer> list) {
        this.list = list;
    }

    ArrayList<Integer>list;

    @Override
    public Integer call() throws Exception {
        ArrayList<Integer>threadList=new ArrayList<>();
        while (true)
        {
            synchronized (MyCallable.class)
            {
                if(list.size()==0) {
                    System.out.println(Thread.currentThread().getName()+threadList);
                    getMaxAndSum(threadList);
                    break;
                }
                else {
                    Random r=new Random();
                    int randIndex=r.nextInt(list.size());
                    System.out.println(Thread.currentThread().getName()+" 抽中了 "+list.get(randIndex));
                    threadList.add(list.get(randIndex));
                    try {
                        Thread.sleep(300);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    list.remove(randIndex);
                }
            }
        }
        if(threadList.size()==0)
        {
            return null;
        }else {
            return Collections.max(threadList);
        }

    }

    public void getMaxAndSum(ArrayList<Integer>list)
    {
        Collections.sort(list);
        System.out.println(list.get(list.size()-1));
        System.out.println(list.stream().mapToInt(Integer::intValue).sum());
    }
}
```

## 线程池

### 之前的弊端

用到线程的时候创建

用完线程之后消失

浪费资源

### 核心原理

1. 创建一个池子，池子是空的
2. 提交任务时，池子会创建新的线程对象，任务执行完毕，线程归还给池子下回再次提交任务时，不需要创建新的线程，直接复用已有的线程即可
3. 但是如果提交任务时，池子中没有空闲线程，也无法创建新的线程，任务就会排队等待

### 代码实现

1. 创建线程池
2. 提交任务
3. 所有的任务执行完毕，关闭线程池

Executors:线程池的工具类通过调用方法返回不同类型的线程池对象。

![image-20240528110543900](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240528110543900.png)

```java
public static void main(String[] args) {
    /*
        public static ExecutorService newCachedThreadPool()             创建一个没有上限的线程池
        public static ExecutorService newFixedThreadPool (int nThreads) 创建有上限的线程池
    */

    // 获取线程池对象
    ExecutorService pool1 = Executors.newCachedThreadPool();

    // 给线程池提交任务
    pool1.submit(new MyRunnable());
    pool1.submit(new MyRunnable());
    pool1.submit(new MyRunnable());
    pool1.submit(new MyRunnable());

    // 销毁线程池
    pool1.shutdown();

    ExecutorService pool2 = Executors.newFixedThreadPool(3);
    pool2.submit(new MyRunnable());
    pool2.submit(new MyRunnable());
    pool2.submit(new MyRunnable());
    pool2.submit(new MyRunnable());
    pool2.shutdown();
}
```

### 自定义线程池

![image-20240528143430122](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240528143430122.png)

![image-20240528144332534](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240528144332534.png)

```java
public static void main(String[] args) {
    /*
        ThreadPoolExecutor threadPoolExecutor = new ThreadPoolExecutor
        (核心线程数量,最大线程数量,空闲线程最大存活时间,任务队列,创建线程工厂,任务的拒绝策略);

        参数一：核心线程数量              不能小于0
        参数二：最大线程数                不能小于0，最大数量 >= 核心线程数量
        参数三：空闲线程最大存活时间       不能小于0
        参数四：时间单位                  用TimeUnit指定
        参数五：任务队列                  不能为null
        参数六：创建线程工厂              不能为null
        参数七：任务的拒绝策略             不能为null
    */
    ThreadPoolExecutor pool=new ThreadPoolExecutor(
            3, // 核心线程数量
            6, // 最大线程数量
            60, // 临时线程的最大存活时间
            TimeUnit.SECONDS, // 单位
            new LinkedBlockingDeque<>(), // 阻塞队列
            Executors.defaultThreadFactory(), //线程工厂
            new ThreadPoolExecutor.AbortPolicy() // 任务的拒绝策略
    );
}
```

#### 线程池多大合适

CPU密集型（计算较多，读取较少）：最大并行数+1

I/O密集型运算（读取多，计算较少）：最大并行数 * 期望CPU利用率* （总时间（CPU计算时间+等待时间）/（CPU计算时间））

其中，CPU的计算时间和等待时间可以用**thread dump**来计算