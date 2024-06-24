# Java学习——异常，File，综合案例

## 异常

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240429215948791.png" alt="image-20240429215948791" style="zoom: 67%;" />

![image-20240430101758161](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240430101758161.png)

编译阶段：Java不会运行代码，只会检查语法是否错误，或者做一些性能优化

运行阶段：检查代码出错而导致程序出现的问题

### 异常的作用

1. 异常是用来查询bug的关键参考信息
2. 异常可以作为方法内部的一种特殊返回值，以便通知调用者底层的执行情况

```java
public static void main(String[] args) {
    Student1 student1=new Student1();
    student1.setName("张三");
    student1.setAge(50);
}

public void setAge(int age) {
    if(age<18 || age>40)
    {
        throw new RuntimeException();
    }
    else
    {
        this.age = age;
    }
}
```

### 异常的处理方式

#### JVM默认的处理方式

把异常名称，异常原因以及异常出现的位置等信息输出在了控制台

程序停止运行，下面的代码不再执行了

#### 自己处理（捕获异常）

捕获：不让程序停止

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240430104931800.png" alt="image-20240430104931800" style="zoom:50%;" />

目的：当代码出现异常时，可以让程序继续往下执行

```java
public static void main(String[] args) {
     /*
        自己处理（捕获异常）
        格式：
            try {
               可能出现异常的代码;
            } catch(异常类名 变量名) {
               异常的处理代码;
            }
         好处:可以让程序继续往下执行，不会停止
     */


    int[] arr = {1, 2, 3, 4, 5, 6};
    try {
        // 可能出现异常的代码
        System.out.println(arr[10]);
        //此处出现了异常，程序就会在这里创建一个ArrayIndexOutOfBoundsException对象
        //new ArrayIndexOutOfBoundsException();
        //拿着这个对象到catch的小括号中对比，看括号中的变量是否可以接收这个对象
        //如果能被接收，就表示该异常就被捕获（抓住），执行catch里面对应的代码
        //当catch里面所有的代码执行完毕，继续执行try...catch体系下面的其他代码
    } catch (ArrayIndexOutOfBoundsException e) {
        // 如果出现了该异常，我该如何处理
        System.out.println("索引越界了");
    }
    System.out.println("看看我执行了么");
}
```

##### 几个问题

Q：如果try中没有遇到问题，怎么执行?

A：会把try中的代码全部执行完毕，不会执行catch里面的代码。

Q：如果try中遇到多个问题，怎么执行？

A：需要写多个catch与之对应，如果要捕获多个异常，这些异常**存在父子关系的话，那么父类一定要写在下面**
		jdk7之后，可以把多个异常写在一个catch里面，用|隔开

Q：如果try中的异常没有被捕获，怎么执行？

A：相当于try...catch代码白写了

Q：如果try中遇到了问题，那么try下面的其他代码还会执行吗?

A：下面的代码不会执行了，直接跳转到对应的catch中

##### 异常的几个常见方法

![image-20240502201210265](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240502201210265.png)

```java
public static void main(String[] args) {
    //  异常的常见方法
     /*
          public String getMessage()          返回此 throwable 的详细消息字符串
          public String toString()            返回此可抛出的简短描述

          public void printStackTrace()       在底层是利用System.err.println进行输出
                                              把异常的错误信息以红色字体输出在控制台
                                              细节：仅仅是打印信息，不会停止程序运行
    */
    int arr[]={1,2,3,4,5,6};

    try {
        System.out.println(arr[10]);
    } catch (ArrayIndexOutOfBoundsException e) {
        System.out.println(e.getMessage());
        System.out.println(e.toString());
        e.printStackTrace();
    }

    System.out.println("看看我执行了么");
}
```

#### 抛出异常

抛出：告诉调用者出错了

##### throws

- 写在方法定义处，表明声明一个异常
- **告诉调用者，使用本方法会有哪些异常**

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240502202747354.png" alt="image-20240502202747354" style="zoom:50%;" />

如果是编译时异常：必须要写

如果是运行时异常：可以不写

##### throw

- 写在方法内，结束方法
- 手动抛出异常对象，交给调用者
- 方法中下面的代码不会执行了

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240502203816783.png" alt="image-20240502203816783" style="zoom:50%;" />

```java
public static void main(String[] args) {
    /*
    throws：写在方法定义处，表示声明一个异常。告诉调用者，使用本方法可能会有哪些异常。
    throw ：写在方法内，结束方法。手动抛出异常对象，交给调用者。方法中下面的代码不再执行了。


    需求：
    定义一个方法求数组的最大值
    */
    int arr[]={1,2,3,4,5};
    int max = 0;
    try {
        max = getMax(arr);
    } catch (Exception e) {
        e.printStackTrace();
    }
    System.out.println(max);

}
public static int getMax(int[] arr)
{
    if (arr==null)
    {
        // 手动创建一个异常对象，并把这个异常交给方法的调用者处理
        // 此时方法就会结束，下面的代码不会执行了
        throw new NullPointerException();
    }

    if(arr.length==0)
    {
        throw new ArrayIndexOutOfBoundsException();
    }

    int max=arr[0];
    for (int i : arr) {
        max=Math.max(max,i);
    }
    return max;
}
```

#### 自定义异常

目的：就是为了让控制台的报错信息更加的见名之意

步骤

1. 定义异常类

2. 写继承关系

3. 空参构造

4. 带参构造


## File

File对象就表示一个路径，可以是**文件的路径**，也可以是**文件夹的路径**

![image-20240503193140573](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240503193140573.png)

```java
public static void main(String[] args) {
    /*
    public File(String pathname)                根据文件路径创建文件对象
    public File(String parent, String child)    根据父路径名字符串和子路径名字符串创建文件对象
    public File(File  parent, String child)     根据父路径对应文件对象和子路径名字符串创建文件对象
    */

    // 根据字符串表示路径，变成File对象
    String str="D:\\Study\\java_study\\java_test6\\src\\myFile\\a.txt";
    File f1=new File(str);

    // 根据父路径名字符串和子路径名字符串创建文件对象
    // 父级路径：D:\Study\java_study\java_test6\src\myFile
    // 子级路径：a.txt
    String parent="D:\\Study\\java_study\\java_test6\\src\\myFile";
    String child="a.txt";
    File f2=new File(parent,child);

    // 根据父路径对应文件对象和子路径名字符串创建文件对象
    File parent2=new File("D:\\Study\\java_study\\java_test6\\src\\myFile");
    String child2="a.txt";
    File f3=new File(parent2,child2);

}
```

### File的常见成员方法

#### 判断、获取

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240503194319559.png" alt="image-20240503194319559" style="zoom: 67%;" />

```java
public static void main(String[] args) {
 /*
    public boolean isDirectory()        判断此路径名表示的File是否为文件夹
    public boolean isFile()             判断此路径名表示的File是否为文件
    public boolean exists()             判断此路径名表示的File是否存在

 */

    //1.对一个文件的路径进行判断
    File f1 = new File("D:\\aaa\\a.txt");
    System.out.println(f1.isDirectory());//false
    System.out.println(f1.isFile());//true
    System.out.println(f1.exists());//true
    System.out.println("--------------------------------------");
    //2.对一个文件夹的路径进行判断
    File f2 = new File("D:\\aaa\\bbb");
    System.out.println(f2.isDirectory());//true
    System.out.println(f2.isFile());//false
    System.out.println(f2.exists());//true
    System.out.println("--------------------------------------");
    //3.对一个不存在的路径进行判断
    File f3 = new File("D:\\aaa\\c.txt");
    System.out.println(f3.isDirectory());//false
    System.out.println(f3.isFile());//false
    System.out.println(f3.exists());//false

}
```

```java
public static void main(String[] args) {
 /*
    public long length()                返回文件的大小（字节数量）
    public String getAbsolutePath()     返回文件的绝对路径
    public String getPath()             返回定义文件时使用的路径
    public String getName()             返回文件的名称，带后缀
    public long lastModified()          返回文件的最后修改时间（时间毫秒值）
 */



    //1.length  返回文件的大小（字节数量）
    //细节1：这个方法只能获取文件的大小，单位是字节
    //如果单位我们要是M，G，可以不断的除以1024
    //细节2：这个方法无法获取文件夹的大小
    //如果我们要获取一个文件夹的大小，需要把这个文件夹里面所有的文件大小都累加在一起。

    File f1 = new File("D:\\aaa\\a.txt");
    long len = f1.length();
    System.out.println(len);//12

    File f2 = new File("D:\\aaa\\bbb");
    long len2 = f2.length();
    System.out.println(len2);//0

    System.out.println("====================================");

    //2.getAbsolutePath 返回文件的绝对路径
    File f3 = new File("D:\\aaa\\a.txt");
    String path1 = f3.getAbsolutePath();
    System.out.println(path1);

    File f4 = new File("myFile\\a.txt");
    String path2 = f4.getAbsolutePath();
    System.out.println(path2);


    System.out.println("====================================");

    //3.getPath 返回定义文件时使用的路径
    File f5 = new File("D:\\aaa\\a.txt");
    String path3 = f5.getPath();
    System.out.println(path3);//D:\ aaa\a.txt

    File f6 = new File("myFile\\a.txt");
    String path4 = f6.getPath();
    System.out.println(path4);//myFile\a.txt

    System.out.println("====================================");


    //4.getName 获取名字
    //细节1：
    //a.txt:
    //      a 文件名
    //      txt 后缀名、扩展名
    //细节2：
    //文件夹：返回的就是文件夹的名字
    File f7 = new File("D:\\aaa\\a.txt");
    String name1 = f7.getName();
    System.out.println(name1);


    File f8 = new File("D:\\aaa\\bbb");
    String name2 = f8.getName();
    System.out.println(name2);//bbb

    System.out.println("====================================");

    //5.lastModified  返回文件的最后修改时间（时间毫秒值）
    File f9 = new File("D:\\aaa\\a.txt");
    long time = f9.lastModified();
    System.out.println(time);//1667380952425

    //如何把时间的毫秒值变成字符串表示的时间呢？
    //课堂练习：
    //yyyy年MM月dd日 HH：mm：ss
}
```

- long len = f1.length(); 方法只能获取**文件的大小**，而且**不能获取文件夹**的大小

#### 创建、删除

![image-20240503200216239](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240503200216239.png)

- delete方法默认只能删除文件和空文件夹，直接删除，不通过回收站

```java
public static void main(String[] args) throws IOException {
    /*
        public boolean createNewFile()      创建一个新的空的文件
        public boolean mkdir()              创建单级文件夹
        public boolean mkdirs()             创建多级文件夹
        public boolean delete()             删除文件、空文件夹
    */
    // createNewFile()
    // 细节1：如果当前路径表示的文件是不存在的，则创建成功，方法返回true
    //       如果存在，创建失败，返回false
    // 细节2：如果父级路径不存在，那么会有异常
    // 细节3：createNewFtle方法创建的一定是文件，如果路径中不包含后缀名，则创建一个没有后缀的文件
    File f1=new File("D:\\Study\\java_study\\java_test6\\src\\myFile\\aaa\\b.txt");
    System.out.println(f1.createNewFile());

    // boolean mkdir()
    // 细节1：windows当中路径是唯一的，如果当前路径已经存在，则创建失败，返回false
    // 细节2：mkdir()只能创建单极文件夹，不能创建多级文件夹
    File f2=new File("D:\\Study\\java_study\\java_test6\\src\\myFile\\aaa\\ddd");
    System.out.println(f2.mkdir());

    // boolean mkdirs()
    // 细节：既可以创建单极的，也可以创建多级的
    File f3=new File("D:\\Study\\java_study\\java_test6\\src\\myFile\\aaa\\aaa\\bbb\\ccc");
    System.out.println(f3.mkdirs());
}
```

#### 获取并遍历

![image-20240503203837172](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240503203837172.png)

- 当调用者File表示的路径不存在时，返回null
- 当调用者File表示的路径是文件时，返回null
- 当调用者File表示的路径是一个空文件夹时，返回一个长度为0的数组
- 当调用者File表示的路径是一个有内容的文件夹时，将里面所有文件和文件夹的路径放在File数组中返回
- 当调用者File表示的路径是一个有隐藏文件的文件夹时，将里面所有文件和文件夹的路径放在File数组中返回，**包含隐藏文件**
- 当调用者File表示的路径是需要权限才能访问的文件夹时，返回null

![image-20240503204504933](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240503204504933.png)

## IO流

存储和读取数据的解决方案

**字节流**：可以操作所有类型的文件

**字符流**：只能操作纯文本文件

![image-20240505170216442](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240505170216442.png)

### 字节流

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240505170647646.png" alt="image-20240505170647646" style="zoom:50%;" />

#### FileOutputStream

操作本地文件的字节输出流，把程序中的数据写到本地

**步骤**

1. 创建字节输出流对象
2. 写数据
3. 释放资源

```java
public static void main(String[] args) throws IOException {
    // 实现需求：写出一段文字到本地文件中
    // 创建对象
    // 细节1：参数是字符串表示的路径或者一个File对象
    // 细节2：如果文件不存在会创建一个新的文件，但是要保证父级路径是存在的
    // 细节3：如果文件已经存在，那么会清空文件
    FileOutputStream fos=new FileOutputStream("D:\\Study\\java_study\\java_test6\\src\\myIO\\a.txt");
    // 写出数据
    // 细节：write方法的参数是整数，但是实际上写到本地文件中的是整数在ASCII上对应的字符
    fos.write(97);
    // 释放资源
    // 细节：每次使用完流之后都要释放资源
    fos.close();
}
```

**FileOutputStream写数据的三种方式**

![](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240505203849390.png)

```java
public static void main(String[] args) throws IOException {
      /*
       void write(int b)                       一次写一个字节数据
       void write(byte[] b)                    一次写一个字节数组数据

       void write(byte[] b, int off, int len)  一次写一个字节数组的部分数据
       参数一：
            数组
       参数二：
            起始索引  0
       参数三：
            个数      3
    */
    // 创建对象
    FileOutputStream fos=new FileOutputStream("src\\myIO\\a.txt");
//        fos.write(98);
//        fos.close();

    byte bytes[]={97,98,99,100};
//        fos.write(bytes);
//        fos.close();

    fos.write(bytes,0,3);
    fos.close();
}
```

**换行写  续写**

```java
public static void main(String[] args) throws IOException {
    /*
        换行写：
            再次写出一个换行符就可以了
            windows： \r\n
            Linux:    \n
            Mac:      \r
        细节：
            在windows操作系统当中，java对回车换行进行了优化。
            虽然完整的是\r\n，但是我们写其中一个\r或者\n，
            java也可以实现换行，因为java在底层会补全。

        续写：
            如果想要续写，打开续写开关即可
            开关位置：创建对象的第二个参数
            默认false：表示关闭续写，此时创建对象会清空文件
            手动传递true：表示打开续写，此时创建对象不会清空文件

    */
    //1.创建对象
    FileOutputStream fos=new FileOutputStream("src\\myIO\\a.txt",true);

    //2.写出数据
    String str = "abcdefg";
    byte[] bytes1 = str.getBytes();
    fos.write(bytes1);

    //再次写出一个换行符就可以了
    String wrap = "\r\n";
    byte[] bytes2 = wrap.getBytes();
    fos.write(bytes2);

    String str2 = "666";
    byte[] bytes3 = str2.getBytes();
    fos.write(bytes3);

    //3.释放资源
    fos.close();
}
```

#### FileInputStream

操作本地文件的字节输入流，可以把本地文件中的数据读取到程序中来

**步骤**

1. 创建字节输入流对象
2. 读数据
3. 释放资源

```java
public static void main(String[] args) throws IOException {
    /*
     * 演示：字节输入流FileInputStream
     * 实现需求：读取文件中的数据。（暂时不写中文）
     *
     * 实现步骤：
     *       创建对象
     *       细节1：如果文件不存在，直接报错
     *
     *
     *       读取数据
     *       细节1：一次读一个字节，读取出来的是数据在ASCII码上对应的数字
     *       细节2：读到文件末尾了，返回-1
     * 
     *       释放资源
     * */

    FileInputStream fis=new FileInputStream("src\\myIO\\a.txt");
    int i1 = fis.read();
    System.out.println(i1);
    fis.close();
}
```

**循环读取**

```java
public static void main(String[] args) throws IOException {
    // 循环读取

    FileInputStream fis=new FileInputStream("src\\myIO\\a.txt");

    int b;
    while ((b=fis.read())!=-1)
    {
        System.out.println((char)b);
    }
    fis.close();
}
```

**文件拷贝**

```java
public static void main(String[] args) throws IOException {
    /*
     *   练习：
     *       文件拷贝
     *       把D:\照片\2024\2024-4\4-27\Z30_5276.JPG拷贝到当前模块下。
     *
     *   注意：
     *       选择一个比较小的文件，不要太大。大文件拷贝我们下一个视频会说。
     *
     *
     *
     *   课堂练习：
     *       要求统计一下拷贝时间，单位毫秒
     * */

    FileInputStream fis=new FileInputStream("D:\\照片\\2024\\2024-4\\4-27\\Z30_5276.JPG");
    FileOutputStream fos=new FileOutputStream("src\\myIO\\copy.JPG");

    int b;
    while ((b=fis.read())!=-1){
        fos.write(b);
    }

    // 释放规则：先开的最后关闭
    fos.close();
    fis.close();
}
```

![image-20240506164003059](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240506164003059.png)

**一次读取多个数据**

字节数组的**长度一般是1024的整数倍**

```java
public static void main(String[] args) throws IOException {
    /*
      public int read(byte[] buffer)      一次读一个字节数组数据
    */

    FileInputStream fis=new FileInputStream("src\\myIO\\a.txt");
    byte []bytes=new byte[2];
    int len = fis.read(bytes);

    String str=new String(bytes,0,len);

    System.out.println(str);
    fis.close();
}
```

在转为字符串的时候，使用指定长度的构造方法**new String(bytes,0,len)**，保证不会读取错误

**拷贝的改进**

```java
public static void main(String[] args) throws IOException {
    FileInputStream fis=new FileInputStream("D:\\照片\\2024\\2024-4\\4-27\\Z30_5276.JPG");
    FileOutputStream fos=new FileOutputStream("src\\myIO\\copy.JPG");

    byte[] bytes=new byte[1024*1024];

    int len;

    while ((len=fis.read(bytes))!=-1)
    {
        fos.write(bytes,0,len);
    }
    fos.close();
    fis.close();
}
```

### 字符集

字节是存储的最小单位

#### ASCII码

存储英文字母，一个字节；前面补0，凑够8位

#### GBK

汉字存储两个字节，高位的二进制一定是1开头，转成十进制之后是一个负数；

英文依然是一个字节

#### Unicode

UTF-8编码规则：用1~4个字节保存，英文：一个字节；中文：三个字节

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240509145933436.png" alt="image-20240509145933436" style="zoom:50%;" />

#### 为什么会有乱码？怎么避免乱码？

##### 原因

1. 读取数据时未读取完整个汉字
2. 编码和解码方式不统一

##### 方法

1. 不要用字节流读取文本文件
2. 编码解码时使用同一个码表

### 字符流

字符流的底层就是字节流

字符流=字节流+字符集

#### 特点

输入流：一次读一个字节，**遇到中文时，一次读多个字节**

输出流：底层会把数据按照指定的编码方式进行编码，变成字节再写到文件中

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240509151841317.png" alt="image-20240509151841317" style="zoom: 50%;" />

#### FileReader

**步骤**

1. 创建字符输入流对象

   **底层**：关联文件，并创建缓冲区(长度为8192的字节数组)

   ![image-20240509152114229](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240509152114229.png)

2. 读取数据

   **底层：**

   判断缓冲区内是否有数据可以读取；

   缓冲区没有数据：就从文件中获取数据，**装到缓冲区**中，每次尽可能装满缓冲区，如果文件中也没有数据了，返回-1

   缓冲区有数据：从缓冲区中读取

   ![image-20240509152143827](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240509152143827.png)

   **细节：**

   按照字节进行读取，遇到中文，一次读取多个字节

   读到文件末尾了，read方法返回-1

3. 释放资源

```java
public static void main(String[] args) throws IOException {
    /*
        第一步：创建对象
        public FileReader(File file)        创建字符输入流关联本地文件
        public FileReader(String pathname)  创建字符输入流关联本地文件

        第二步：读取数据
        public int read()                   读取数据，读到末尾返回-1
        public int read(char[] buffer)      读取多个数据，读到末尾返回-1

        第三步：释放资源
        public void close()                 释放资源/关流
    */

    //read()细节：
    //1.read():默认也是一个字节一个字节的读取的,如果遇到中文就会一次读取多个
    //2.在读取之后，方法的底层还会进行解码并转成十进制。
    //  最终把这个十进制作为返回值
    //  这个十进制的数据也表示在字符集上的数字
    //  英文：文件里面二进制数据 0110 0001
    //          read方法进行读取，解码并转成十进制97
    //  中文：文件里面的二进制数据 11100110 10110001 10001001
    //          read方法进行读取，解码并转成十进制27721

    // 我想看到中文汉字，就是把这些十进制数据，再进行强转就可以了


    // 创建对象
    FileReader fr=new FileReader("src\\myIO\\b.txt");
    // 读取数据
    int ch;
    while ((ch=fr.read())!=-1)
    {
        System.out.print((char)ch);
    }

    fr.close();
}
```

```java
public static void main(String[] args) throws IOException {

    // 创建对象
    FileReader fr=new FileReader("src\\myIO\\b.txt");

    char []chars=new char[2];
    int len;
    //read(chars)：读取数据，解码，强转三步合并了，把强转之后的字符放到数组当中
    //空参的read + 强转类型转换
    while ((len=fr.read(chars))!=-1)
    {
        System.out.print(new String(chars,0,len));
    }
    fr.close();
}
```

#### FileWriter

![image-20240509160336160](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240509160336160.png)

![image-20240509160754330](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240509160754330.png)

**步骤**

1. 创建字符输出流对象

2. 写数据

   **细节：**如果write方法的**参数是整数**，但是实际上写到本地文件中的是**整数在字符集上对应的字符**

   **原理：**

   先写进缓冲区，缓冲区再写进文件，缓冲区大小8192

   装满了

   使用flush flush之后还可以继续往里面写

   使用close

3. 释放资源

```java
public static void main(String[] args) throws IOException {
    FileWriter fw=new FileWriter("src\\myIO\\c.txt",true);

    // 根据字符集的编码方式进行编码，把编码之后的数据写到文件中去
    // fw.write(25105);

    // fw.write("你好");

    char []chars={'a','b','c','我'};
    fw.write(chars);

    fw.close();
}
```

```java
public static void main(String[] args) throws IOException {
     /*
        文本文件中有以下的数据：
            2-1-9-4-7-8
        将文件中的数据进行排序，变成以下的数据：
            1-2-4-7-8-9

      */

    FileReader fr=new FileReader("src\\main\\java\\myIO\\sort\\1.txt");
    StringBuilder sb=new StringBuilder();
    int c;
    while ((c=fr.read())!=-1)
    {
        sb.append((char)c);
    }
    fr.close();

    FileWriter fw=new FileWriter("src\\main\\java\\myIO\\sort\\1.txt");

    Integer[] arr = Arrays.stream(sb.toString()
                    .split("-"))
            .map(string -> Integer.parseInt(string))
            .sorted()
            .toArray(value -> new Integer[value]);

    String replace = Arrays.toString(arr).replace(",", "-");
    replace.substring(1,replace.length()-1);

    System.out.println(replace);
    fw.write(replace);
    fw.close();
}
```

### 缓冲流

![image-20240513200331496](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240513200331496.png)

#### 字节缓冲流

![image-20240513200459277](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240513200459277.png)

原理：底层自带长度为8192字节的缓冲区提高性能

```java
BufferedInputStream bis=new BufferedInputStream(new FileInputStream("src\\main\\java\\myIO\\a.txt"));
BufferedOutputStream bos=new BufferedOutputStream(new FileOutputStream("src\\main\\java\\myIO\\copy1.txt"));

byte []bytes=new byte[1024];
int len;
while ((len=bis.read(bytes))!=-1)
{
    bos.write(bytes,0,len);
}
bos.close();
bis.close();
```



#### 字符缓冲流

![image-20240518155504025](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240518155504025.png)

![image-20240518155619263](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240518155619263.png)

```java
public static void main(String[] args) throws IOException {
    /*
     *   字符缓冲输入流：
     *      构造方法：
     *           public BufferedReader(Reader r)
     *      特有方法：
     *           public String readLine()   读一整行
     *
     * */
    BufferedReader br=new BufferedReader(new FileReader("src\\main\\java\\myIO\\a.txt"));
    //细节：
    //readLine方法在读取的时候，一次读一整行，遇到回车换行结束
    //        但是他不会把回车换行读到内存当中
    String sLine = null;

    while ((sLine=br.readLine())!=null)
    {
        System.out.println(sLine);
    }

    br.close();
}
```

![image-20240518155629248](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240518155629248.png)

```java
public static void main(String[] args) throws IOException {
    /*
     *    字符缓冲输出流
     *      构造方法：
     *           public BufferedWriter(Writer r)
     *      特有方法：
     *           public void newLine()      跨平台的换行
     *
     * */
    BufferedWriter bw=new BufferedWriter(new FileWriter("src\\main\\java\\myIO\\b.txt",true));

    bw.write("abcdefg");
    bw.newLine();
    bw.write("hijklmn");

    bw.close();
}
```

### 转换流

![image-20240518164938206](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240518164938206.png)

#### InputStreamReader

把字节流转换为字符流

#### OutputStreamWriter

把字符流转换为字节流

**使用场景：**字节流想要使用字符流中的方法

```java
public static void main(String[] args) throws IOException {
    /*
        利用转换流按照指定字符编码写出
    */

    // 创建对象并指定字符编码
//        InputStreamReader isp=new InputStreamReader(new FileInputStream("src\\main\\java\\myIO\\gbkfile.txt"),"GBK");
//
//        // 读取数据
//        int ch;
//        while ((ch=isp.read())!=-1)
//        {
//            System.out.print((char) ch);
//        }
//        isp.close();


    // jdk11 以后，可以使用FileReader()

    FileReader fr=new FileReader("src\\main\\java\\myIO\\gbkfile.txt", Charset.forName("GBK"));
    int ch;
    while ((ch=fr.read())!=-1)
    {
        System.out.print((char) ch);
    }
    fr.close();
}
```

```java
public static void main(String[] args) throws IOException {
    /*
        利用转换流按照指定字符编码写出
    */
//        OutputStreamWriter osw=new OutputStreamWriter(new FileOutputStream("src\\main\\java\\myIO\\gbkfile_out.txt"),"GBK");
//
//        osw.write("你好");
//
//        osw.close();
    // jdk11 以后，可以使用FileWriter()

    FileWriter fw=new FileWriter("src\\\\main\\\\java\\\\myIO\\\\gbkfile_out.txt", Charset.forName("GBK"));
    fw.write("谢谢大家");
    fw.close();
}
```

### 序列化流和反序列化流

#### 序列化流（对象操作输出流）

把Java中的对象写道本地文件中

![image-20240518191711655](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240518191711655.png)

![image-20240518191738587](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240518191738587.png)

细节：直接使用对象输出流将对象保存到文件时会出现**NotserializableException**异常，解决方法：需要让Javabean类**实现Serializable接口**

```java
public static void main(String[] args) throws IOException {
    /*
       需求：
            利用序列化流/对象操作输出流，把一个对象写到本地文件中

       构造方法：
            public ObjectOutputStream(OutputStream out)         把基本流变成高级流

       成员方法：
            public final void writeObject(Object obj)           把对象序列化（写出）到文件中去
    */

    Student stu=new Student(23,"zahngsan");
    ObjectOutputStream oos=new ObjectOutputStream(new FileOutputStream("src\\main\\java\\myIO\\objectoutputStream.txt"));

    oos.writeObject(stu);
    oos.close();
}

/*
* Serializable接口里面是没有抽象方法，标记型接口
* 一旦实现了这个接口，就表示这个类可以被序列化
* */
public class Student implements Serializable {
    private int age;
    private String name;
    ...
}
```

#### 反序列化流（对象操作输入流）

![image-20240518193436403](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240518193436403.png)

![image-20240518193505293](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240518193505293.png)

```java
public static void main(String[] args) throws IOException, ClassNotFoundException {
    /*
       需求：
            利用反序列化流/对象操作输入流，把文件中中的对象读到程序当中
       构造方法：
            public ObjectInputStream(InputStream out)         把基本流变成高级流
       成员方法：
            public Object readObject()                        把序列化到本地文件中的对象，读取到程序中来
    */
    ObjectInputStream ois=new ObjectInputStream(new FileInputStream("src/main/java/myIO/objectoutputStream.txt"));
    Student stu = (Student)ois.readObject();
    System.out.println(stu);
}
```

序列化流写到文件中的数据是**不能修改的**，一旦修改就无法读回来了

序列化对象后，修改了Javabean类，再次反序列化，会出问题，抛出InvalidclassException异常，解决方案:**给Javabean类添加serialVersionUID**(列号、版本号)

如果一个对象中的某个成员变量的值不想被序列化，那么给该成员变量**加transient关键字**修饰，该关键字标记的成员变量不参与序列化过程

```java
public static void main(String[] args) throws IOException {
    /*需求：
        将多个自定义对象序列化到文件中，但是对象的个数不确定，该如何操作呢？
    */
    Student s1 = new Student(21, "zhangsan");
    Student s2 = new Student(22, "lisi");
    Student s3 = new Student(23, "wangwu");

    ArrayList<Student> list=new ArrayList<>();
    list.add(s1);
    list.add(s2);
    list.add(s3);

    ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("src/main/java/myIO/objectoutputStream1.txt"));
    oos.writeObject(list);
    oos.close();
}
```

```java
public static void main(String[] args) throws IOException, ClassNotFoundException {
    ObjectInputStream ois=new ObjectInputStream(new FileInputStream("src/main/java/myIO/objectoutputStream1.txt"));
    ArrayList<Student> list = (ArrayList<Student>) ois.readObject();
    System.out.println(list);

    ois.close();
}
```

### 打印流

打印流只能操作文件的目的地，不能操作数据源

打印流有特有的写出方法，数据可以**原样写出**，可以**实现自动刷新**，自动**换行**

#### PrintStream（字节打印流）

默认自动刷新

![image-20240519160648236](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240519160648236.png)

![image-20240519161005237](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240519161005237.png)

```java
public static void main(String[] args) throws FileNotFoundException {
    /*
    字节打印流：
        构造方法
            public PrintStream(OutputStream/File/String)            关联字节输出流/文件/文件路径
            public PrintStream(String fileName, Charset charset)    指定字符编码
            public PrintStream(OutputStreamout, boolean autoFlush)  自动刷新
            public PrintStream(OutputStream out, boolean autoFlush, String encoding)    指定字符编码且自动刷新
        成员方法：
            public void write(int b)            常规方法：规则跟之前一样，将指定的字节写出
            public void println(Xxx xx)         特有方法：打印任意数据，自动刷新，自动换行
            public void print(Xxx xx)           特有方法：打印任意数据，不换行
            public void printf(String format, Object... args)   特有方法：带有占位符的打印语句，不换行
*/

    PrintStream ps=new PrintStream(new FileOutputStream("src\\main\\java\\myIO\\printStream1.txt"),true, Charset.forName("UTF-8"));
    ps.println(97);
    ps.print(true);
    ps.printf("%s爱上了%s","a","b");
    ps.close();
}
```

```java
public static void main(String[] args) throws FileNotFoundException {
    PrintStream ps = new PrintStream("a.txt");

    //% n表示换行
    ps.printf("我叫%s %n", "阿玮");
    ps.printf("%s喜欢%s %n", "阿珍", "阿强");
    ps.printf("字母H的大写：%c %n", 'H');
    ps.printf("8>3的结果是：%b %n", 8 > 3);
    ps.printf("100的一半是：%d %n", 100 / 2);
    ps.printf("100的16进制数是：%x %n", 100);
    ps.printf("100的8进制数是：%o %n", 100);
    ps.printf("50元的书打8.5折扣是：%f元%n", 50 * 0.85);
    ps.printf("计算的结果转16进制：%a %n", 50 * 0.85);
    ps.printf("计算的结果转科学计数法表示：%e %n", 50 * 0.85);
    ps.printf("计算的结果转成指数和浮点数，结果的长度较短的是：%g %n", 50 * 0.85);
    ps.printf("带有百分号的符号表示法，以百分之85为例：%d%% %n", 85);
    ps.println("---------------------");

    double num1 = 1.0;
    ps.printf("num: %.4g %n", num1);
    ps.printf("num: %.5g %n", num1);
    ps.printf("num: %.6g %n", num1);

    float num2 = 1.0F;
    ps.printf("num: %.4f %n", num2);
    ps.printf("num: %.5f %n", num2);
    ps.printf("num: %.6f %n", num2);
    ps.println("---------------------");

    ps.printf("数字前面带有0的表示方式：%03d %n", 7);
    ps.printf("数字前面带有0的表示方式：%04d %n", 7);
    ps.printf("数字前面带有空格的表示方式：% 8d %n", 7);
    ps.printf("整数分组的效果是：%,d %n", 9989997);
    ps.println("---------------------");

    //最终结果是10位，小数点后面是5位，不够在前面补空格，补满10位
    //如果实际数字小数点后面过长，但是只规定两位，会四舍五入
    //如果整数部分过长，超出规定的总长度，会以实际为准
    ps.printf("一本书的价格是：%2.5f元%n", 49.8);
    ps.printf("%(f%n", -76.04);

    //%f，默认小数点后面7位，
    //<，表示采取跟前面一样的内容
    ps.printf("%f和%3.2f %n", 86.04, 1.789651);
    ps.printf("%f和%<3.2f %n", 86.04, 1.789651);
    ps.println("---------------------");

    Date date = new Date();
    // %t 表示时间，但是不能单独出现，要指定时间的格式
    // %tc 周二 12月 06 22:08:40 CST 2022
    // %tD 斜线隔开
    // %tF 冒号隔开（12小时制）
    // %tr 冒号隔开（24小时制）
    // %tT 冒号隔开（24小时制，带时分秒）
    ps.printf("全部日期和时间信息：%tc %n", date);
    ps.printf("月/日/年格式：%tD %n", date);
    ps.printf("年-月-日格式：%tF %n", date);
    ps.printf("HH:MM:SS PM格式(12时制)：%tr %n", date);
    ps.printf("HH:MM格式(24时制)：%tR %n", date);
    ps.printf("HH:MM:SS格式(24时制)：%tT %n", date);

    System.out.println("---------------------");
    ps.printf("星期的简称：%ta %n", date);
    ps.printf("星期的全称：%tA %n", date);
    ps.printf("英文月份简称：%tb %n", date);
    ps.printf("英文月份全称：%tB %n", date);
    ps.printf("年的前两位数字(不足两位前面补0)：%tC %n", date);
    ps.printf("年的后两位数字(不足两位前面补0)：%ty %n", date);
    ps.printf("一年中的第几天：%tj %n", date);
    ps.printf("两位数字的月份(不足两位前面补0)：%tm %n", date);
    ps.printf("两位数字的日(不足两位前面补0)：%td %n", date);
    ps.printf("月份的日(前面不补0)：%te  %n", date);

    System.out.println("---------------------");
    ps.printf("两位数字24时制的小时(不足2位前面补0):%tH %n", date);
    ps.printf("两位数字12时制的小时(不足2位前面补0):%tI %n", date);
    ps.printf("两位数字24时制的小时(前面不补0):%tk %n", date);
    ps.printf("两位数字12时制的小时(前面不补0):%tl %n", date);
    ps.printf("两位数字的分钟(不足2位前面补0):%tM %n", date);
    ps.printf("两位数字的秒(不足2位前面补0):%tS %n", date);
    ps.printf("三位数字的毫秒(不足3位前面补0):%tL %n", date);
    ps.printf("九位数字的毫秒数(不足9位前面补0):%tN %n", date);
    ps.printf("小写字母的上午或下午标记(英)：%tp %n", date);
    ps.printf("小写字母的上午或下午标记(中)：%tp %n", date);
    ps.printf("相对于GMT的偏移量:%tz %n", date);
    ps.printf("时区缩写字符串:%tZ%n", date);
    ps.printf("1970-1-1 00:00:00 到现在所经过的秒数：%ts %n", date);
    ps.printf("1970-1-1 00:00:00 到现在所经过的毫秒数：%tQ %n", date);

    ps.close();
}
```

#### PrintWriter（字符打印流）

字符打印流**有缓冲区**，想要**自动刷新需要开启**

![image-20240520152904048](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240520152904048.png)

```java
public static void main(String[] args) throws FileNotFoundException {
    /*
    字符打印流：
        构造方法
            public PrintWriter(Write/File/String)            关联字节输出流/文件/文件路径
            public PrintWriter(String fileName, Charset charset)    指定字符编码
            public PrintWriter(Write, boolean autoFlush)  自动刷新
            public PrintWriter(Write out, boolean autoFlush, String encoding)    指定字符编码且自动刷新
        成员方法：
            public void write(int b)            常规方法：规则跟之前一样，将指定的字节写出
            public void println(Xxx xx)         特有方法：打印任意数据，自动刷新，自动换行
            public void print(Xxx xx)           特有方法：打印任意数据，不换行
            public void printf(String format, Object... args)   特有方法：带有占位符的打印语句，不换行
*/
    PrintWriter pw=new PrintWriter(new FileOutputStream("src\\main\\java\\myIO\\printStream2.txt"),true);
    pw.println("123");
    pw.print("hello");
    pw.close();
}
```

### 解压缩流和压缩流

#### 解压缩流

解压的本质是把**每一个ZipEntry**按照层级拷贝到本地的另一个文件夹中

```java
public static void main(String[] args) throws IOException {
    File src=new File("src\\main\\java\\myIO\\ZipStreamDemo001.java");
    File dest=new File("src\\main\\java\\myIO");

    unzip(src,dest);
}

 public static void unzip(File src,File dest) throws IOException {
    //解压的本质：把压缩包里面的每一个文件或者文件夹读取出来，按照层级拷贝到目的地当中
    //创建一个解压缩流用来读取压缩包中的数据
    ZipInputStream zip = new ZipInputStream(new FileInputStream(src));
    //要先获取到压缩包里面的每一个zipentry对象
    //表示当前在压缩包中获取到的文件或者文件夹
    ZipEntry entry;
    while((entry = zip.getNextEntry()) != null){
        System.out.println(entry);
        if(entry.isDirectory()){
            //文件夹：需要在目的地dest处创建一个同样的文件夹
            File file = new File(dest,entry.toString());
            file.mkdirs();
        }else{
            //文件：需要读取到压缩包中的文件，并把他存放到目的地dest文件夹中（按照层级目录进行存放）
            FileOutputStream fos = new FileOutputStream(new File(dest,entry.toString()));
            int b;
            while((b = zip.read()) != -1){
                //写到目的地
                fos.write(b);
            }
            fos.close();
            //表示在压缩包中的一个文件处理完毕了。
            zip.closeEntry();
        }
    }
    zip.close();
}
```

#### 压缩流

```java
public static void main(String[] args) throws IOException {
    /*
    * 把单个文件压缩
    * */
    File src=new File("src\\main\\java\\myIO\\a.txt");
    File dest=new File("src\\main\\java\\myIO");
    tozip(src,dest);
}

public static void tozip(File src,File dest) throws IOException {
    ZipOutputStream zos=new ZipOutputStream(new FileOutputStream(new File(dest,"a.zip")));
    // 创建ZipEntry对象，表示压缩包里的每个文件和文件夹
    ZipEntry entry=new ZipEntry("a.txt");
    // 把entry放入压缩包中
    zos.putNextEntry(entry);

    FileInputStream fis=new FileInputStream(src);
    int b;
    while ((b=fis.read())!=-1)
    {
        zos.write(b);
    }
    zos.closeEntry();
    zos.close();
}
```

```java
public static void main(String[] args) throws IOException {
    /*
    * 压缩一个文件夹
    * */
    // 源
    File src=new File("myIO\\ZipStream02");
    // 目的
    File destParent=src.getParentFile();

    File dest=new File(destParent,src.getName()+".zip");

    ZipOutputStream zos=new ZipOutputStream(new FileOutputStream(dest));
    toZip(src,zos,src.getName());
    zos.close();
}

// 获取src里面的每一个文件，变成ZipEntry对象，放入到压缩包中
// 参数：数据源 压缩流 压缩包内部的路径
public static void toZip(File src,ZipOutputStream zos,String name) throws IOException {
    File[] files = src.listFiles();
    for (File file : files) {
        if(file.isFile()) {
            // 如果是文件
            ZipEntry entry=new ZipEntry(name+"\\"+file.getName());
            zos.putNextEntry(entry);
            FileInputStream fis=new FileInputStream(file);
            int b;
            while((b= fis.read())!=-1)
            {
                zos.write(b);
            }
            fis.close();
            zos.closeEntry();
        }
        else {
            toZip(file,zos,name+"\\"+file.getName());
        }
    }
}
```

### Commons-io工具包

有关IO操作的开源工具包

作用：**提高IO流的开发效率**

![image-20240521133001840](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240521133001840.png)

![image-20240521133049915](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240521133049915.png)

```java
public static void main(String[] args) throws IOException {
           /*
      FileUtils类
            static void copyFile(File srcFile, File destFile)                   复制文件
            static void copyDirectory(File srcDir, File destDir)                复制文件夹
            static void copyDirectoryToDirectory(File srcDir, File destDir)     复制文件夹
            static void deleteDirectory(File directory)                         删除文件夹
            static void cleanDirectory(File directory)                          清空文件夹
            static String readFileToString(File file, Charset encoding)         读取文件中的数据变成成字符串
            static void write(File file, CharSequence data, String encoding)    写出数据

        IOUtils类
            public static int copy(InputStream input, OutputStream output)      复制文件
            public static int copyLarge(Reader input, Writer output)            复制大文件
            public static String readLines(Reader input)                        读取数据
            public static void write(String data, OutputStream output)          写出数据
     */
    File src=new File("src\\main\\java\\myIO\\a.txt");
    File dest=new File("src\\main\\java\\myIO\\Commons_io01.txt");
    FileUtils.copyFile(src,dest);
}
```

### Hutool工具包

![image-20240521144703161](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240521144703161.png)

```java
public static void main(String[] args) {
    /*
    FileUtil类:
            file：根据参数创建一个file对象
            touch：根据参数创建文件

            writeLines：把集合中的数据写出到文件中，覆盖模式。
            appendLines：把集合中的数据写出到文件中，续写模式。
            readLines：指定字符编码，把文件中的数据，读到集合中。
            readUtf8Lines：按照UTF-8的形式，把文件中的数据，读到集合中

            copy：拷贝文件或者文件夹
*/
}
```

