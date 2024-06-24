# Java学习——动态代理

程序为什么需要代理：对象如果嫌身上干的事情太多的话，可以通过代理来转移部分职责，代理可以**无侵入式的给对象增加其他功能**

代理长什么样：对象有什么方法想被代理，代理就一定要有对应的方法

**通过接口来实现**

![image-20240612215406061](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240612215406061.png)

```java
public class ProxyUtil {
    // 方法的作用：给BigStar类创建一个代理
    // 形参：被代理的明星对象
    // 返回值：给明星创建的代理
    public static Star createProxy(BigStar bigStar)
    {
        /*
            java.lang.reflect.Proxy类：提供了为对象产生代理对象的方法：
            public static Object newProxyInstance(ClassLoader loader, Class<?>[] interfaces, InvocationHandler h)
            参数一：用于指定用哪个类加载器，去加载生成的代理类
            参数二：指定接口，这些接口用于指定生成的代理长什么，也就是有哪些方法
            参数三：用来指定生成的代理对象要干什么事情
        */

        Star star = (Star) Proxy.newProxyInstance(
                ProxyUtil.class.getClassLoader(),
                new Class[]{Star.class},
                new InvocationHandler() {
                    @Override
                    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                        // 参数一：代理的对象
                        // 参数二：要运行的方法
                        // 参数三：调用方法时，传递的实参
                        if("sing".equals(method.getName()))
                        {
                            System.out.println("准备话筒，唱歌");
                        }
                        else if("dance".equals(method.getName()))
                        {
                            System.out.println("准备舞台，跳舞");
                        }

                        return method.invoke(bigStar,args);
                    }
                });

        return star;
    }
}

public static void main(String[] args) {
    BigStar bigStar=new BigStar("鸡哥");
    Star proxy = ProxyUtil.createProxy(bigStar);

    // 调用唱歌的方法
    String result = proxy.sing("歌曲1");
    System.out.println(result);
}
```

