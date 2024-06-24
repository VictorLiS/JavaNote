# Java学习——网络编程

## 什么是网络编程

在网络通信协议下，不同计算机上运行的程序，进行数据的传输

### 常见的软件架构

#### C/S：客户端/服务器

优点：用户体验好

缺点：开发安装更新麻烦

#### B/S：浏览器/服务器

优点：方便，不需要开发客户端，只需要页面+服务端

缺点：如果应用过大，用户体验受到影响

## 网络编程三要素

### IP地址

设备在网络中的地址，是唯一的标识

192.168.开头的都是私有地址 

127.0.0.1是本地回环地址，永远指向本机

```java
public static void main(String[] args) throws UnknownHostException {
    /*
        static InetAddress getByName(String host)  确定主机名称的IP地址。主机名称可以是机器名称，也可以是IP地址
        String getHostName()                        获取此IP地址的主机名
        String getHostAddress()                     返回文本显示中的IP地址字符串
    */

    // 获取InetAddress的对象
    // 表示的是电脑的对象

    InetAddress address = InetAddress.getByName("192.168.3.36");
    System.out.println(address);

    String name = address.getHostName();
    System.out.println(name);

    String ip = address.getHostAddress();
    System.out.println(ip);
}
```

### 端口号

应用程序在设备的唯一的标识·

一个端口只能一个应用程序使用

### 协议

数据在网络中传输的规则

#### UDP协议

UDP是面向无连接的协议

速度快，一次大小限制64K，数据不安全，容易丢失

##### 发送数据步骤

1. 创建发送端的DatagramSocket对象
2. 数据打包（DatagramPacket）
3. 发送数据
4. 释放资源

##### 接收数据步骤

1. 创建接收端的DatagramSocket对象
2. 接受打包好的数据
3. 解析数据包
4. 释放资源

##### 三种通信方式

单播：一对一

```java
public static void main(String[] args) throws IOException {
    // 发送数据


    // 创建DatagramSocket对象（快递公司）
    // 创建的过程，会绑定端口
    // 空参：所有可用的端口随机一个进行使用
    DatagramSocket ds=new DatagramSocket();

    // 打包数据
    String str="你好！！！";
    byte[] bytes = str.getBytes();
    InetAddress byAddress = InetAddress.getByName("127.0.0.1");
    int port=10086;
    DatagramPacket dp=new DatagramPacket(bytes,bytes.length,byAddress,port);

    // 发送数据
    ds.send(dp);
    ds.close();
}

public static void main(String[] args) throws IOException {
    // 接收数据

    // 创建DatagramSocket对象（快递公司）
    // 接收时，一定要绑定端口
    DatagramSocket ds=new DatagramSocket(10086);

    // 接收数据包
    byte []bytes=new byte[1024];
    DatagramPacket dp=new DatagramPacket(bytes, bytes.length);


    // receive这个方法是阻塞的，程序执行到这一步时，会一直等待发送端发送消息
    ds.receive(dp);

    // 解析数据包
    byte[] data = dp.getData();
    int length = dp.getLength();
    InetAddress address = dp.getAddress();
    int port = dp.getPort();

    System.out.println("接收到数据" + new String(data,0,length));
    System.out.println("该数据是从" + address + "这台电脑中的" + port + "这个端口发出的");

    ds.close();
}
```

组播：给一组目标发送，**组播地址：224.0.0.0~239.255.255.255**，其中**224.0.0.0~224.0.0.255为预留的组播地址**

```java
public static void main(String[] args) throws IOException {
    /*
        组播发送代码
    */

    // 创建MulticastSocket对象
    MulticastSocket ms=new MulticastSocket();

    String str="你好，你好";
    byte[] bytes = str.getBytes();
    int port=10000;
    InetAddress address = InetAddress.getByName("224.0.0.1");

    DatagramPacket dp=new DatagramPacket(bytes, bytes.length,address,port);
    ms.send(dp);
    ms.close();
}

public static void main(String[] args) throws IOException {
    MulticastSocket ms=new MulticastSocket(10000);
    InetAddress address = InetAddress.getByName("224.0.0.1");
    ms.joinGroup(address);

    byte []bytes=new byte[1024];

    DatagramPacket dp=new DatagramPacket(bytes, bytes.length);
    ms.receive(dp);

    byte[] data = dp.getData();
    int length = dp.getLength();
    int port = dp.getPort();
    String name = dp.getAddress().getHostName();

    System.out.println("接收到数据" + new String(data,0,length));
    System.out.println("该数据是从" + name + "这台电脑中的" + port + "这个端口发出的");
}
```

广播：给全部目标发送，**广播地址：255.255.255.255**

#### TCP协议

TCP是面向连接的协议，通信之前**一定要保证链接已经建立**

它在通信的**两端各建立一个socket对象**，通过**socket产生的IO流来进行网络通信**

速度慢，没有大小限制，数据安全

##### 客户端步骤

1. 创建客户端的Socket对象（Socket）与指定的服务端相连 **Socket(String host,int port)**
2. 获取输出流，写数据 **Outputstream getoutputstream()**
3. 释放资源

##### **服务器端步骤**

1. 创建客户端的Socket对象（SeverSocket）**SeverSocket(int port)**
2. 监听客户端连接，返回一个Socket对象 **Socket accept()**
3. 获取输入流，读数据，并把数据显示在控制台 InputStream getInputstream()
4. 释放资源

```java
public static void main(String[] args) throws IOException {
    // TCP 发送对象

    // 创建Socket对象
    // 细节：在创建对象的同时连接服务端
    //      如果连接不上，代码会报错
    Socket socket=new Socket("127.0.0.1",10085);

    // 从socket中获取输出流
    OutputStream os = socket.getOutputStream();
    // 写出数据
    os.write("你好你好".getBytes());

    // 释放资源
    os.close();
    socket.close();
}

public static void main(String[] args) throws IOException {
    ServerSocket ss=new ServerSocket(10085);
    // 监听客户端的连接
    Socket socket = ss.accept();

    // 创建字节流
    InputStream is = socket.getInputStream();
    // 创建字符流，把字节流转换为字符流
    InputStreamReader isr=new InputStreamReader(is);

    int b;
    while ((b=isr.read())!=-1)
    {
        System.out.println((char) b);
    }
    socket.close();
    is.close();
} 
```

