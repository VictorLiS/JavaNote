# Java学习——反射

反射允许对成员变量，成员方法和构造方法的信息进行编程访问

## 获取class对象的三种方式

1. Class.forName(“全类名");
2. 类名.class
3. 对象.getclass();

这三个阶段分别对应三种方式

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240610221624486.png" alt="image-20240610221624486" style="zoom: 50%;" />

```java
public static void main(String[] args) throws ClassNotFoundException {
    /*
     * 获取class对象的三种方式：
     *   1. Class.forName("全类名");
     *   2. 类名.class
     *   3. 对象.getClass();
     *
     * */
    // 获取的都是类的字节码文件对象

    // 最为常用的
    Class clazz1 = Class.forName("myReflect.reflectTest01.Student");
    System.out.println(clazz1);

    // 一般是当作参数进行传递
    Class<Student> clazz2 = Student.class;
    System.out.println(clazz2);

    // 当有这个类时，才可以使用
    Student s1=new Student();
    Class<? extends Student> clazz3 = s1.getClass();
    System.out.println(clazz3);
}
```



## 反射获取构造方法

![](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240611220240235.png)

```java
public static void main(String[] args) throws ClassNotFoundException, NoSuchMethodException {
      /*
    Class类中用于获取构造方法的方法
        Constructor<?>[] getConstructors()                                返回所有公共构造方法对象的数组
        Constructor<?>[] getDeclaredConstructors()                        返回所有构造方法对象的数组
        Constructor<T> getConstructor(Class<?>... parameterTypes)         返回单个公共构造方法对象
        Constructor<T> getDeclaredConstructor(Class<?>... parameterTypes) 返回单个构造方法对象


    Constructor类中用于创建对象的方法
        T newInstance(Object... initargs)                                 根据指定的构造方法创建对象
        setAccessible(boolean flag)                                       设置为true,表示取消访问检查
*/
    // 获取class字节码文件对象
    Class clazz = Class.forName("myReflect.reflectTest02.Student");

    // 获取构造方法
    Constructor[] cons1 = clazz.getConstructors();
    for (Constructor con : cons1) {
        System.out.println(con);
    }

    System.out.println("========================");

    Constructor[] cons2 = clazz.getDeclaredConstructors();
    for (Constructor con : cons2) {
        System.out.println(con);
    }

    System.out.println("========================");

    Constructor con3 = clazz.getConstructor();
    System.out.println(con3);

    System.out.println("========================");

    // 获取带参数的
    Constructor con4 = clazz.getConstructor(String.class);
    System.out.println(con4);

    // 获取构造方法的权限修饰符
    int modifiers = con4.getModifiers();
    System.out.println(modifiers);

    // 获取构造方法的全部参数
    Parameter[] parameters = con4.getParameters();
    for (Parameter parameter : parameters) {
        System.out.println(parameter);
    }

    // 暴力反射 表示临时取消校验
    con4.setAccessible(true);
}
```

## 反射获取成员变量

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240612191433238.png" alt="image-20240612191433238" style="zoom: 67%;" />

```java
public static void main(String[] args) throws ClassNotFoundException, NoSuchFieldException {
     /*
   Class类中用于获取成员变量的方法
        Field[] getFields()：                返回所有公共成员变量对象的数组
        Field[] getDeclaredFields()：        返回所有成员变量对象的数组
        Field getField(String name)：        返回单个公共成员变量对象
        Field getDeclaredField(String name)：返回单个成员变量对象

   Field类中用于创建对象的方法
        void set(Object obj, Object value)：赋值
        Object get(Object obj)              获取值

    */
    Class clazz = Class.forName("myReflect.reflectTest03.Student");

    // 获取成员变量
    Field[] fields1 = clazz.getFields();
    Arrays.stream(fields1).forEach(field -> System.out.println(field));
    System.out.println("===========");

    Field[] fields2 = clazz.getDeclaredFields();
    Arrays.stream(fields2).forEach(field -> System.out.println(field));
    System.out.println("===========");

    // 获取单个成员变量
    Field gender = clazz.getField("gender");
    System.out.println(gender);
    System.out.println("===========");

    // 获取权限修饰符
    int modifiers = gender.getModifiers();
    System.out.println(modifiers);

    // 获取变量名
    String name = gender.getName();
    System.out.println(name);

    // 获取变量数据类型
    Class<?> type = gender.getType();
    System.out.println(type);
}
```

## 反射获取成员方法

![image-20240612195900606](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240612195900606.png)

```java
public static void main(String[] args) throws ClassNotFoundException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {
     /*
   Class类中用于获取成员方法的方法
        Method[] getMethods()：返回所有公共成员方法对象的数组，包括继承的
        Method[] getDeclaredMethods()：返回所有成员方法对象的数组，不包括继承的
        Method getMethod(String name, Class<?>... parameterTypes) ：返回单个公共成员方法对象
        Method getDeclaredMethod(String name, Class<?>... parameterTypes)：返回单个成员方法对象


   Method类中用于创建对象的方法
        Object invoke(Object obj, Object... args)：运行方法
        参数一：用obj对象调用该方法
        参数二：调用方法的传递的参数（如果没有就不写）
        返回值：方法的返回值（如果没有就不写）

    获取方法的修饰符
    获取方法的名字
    获取方法的形参
    获取方法的返回值
    获取方法的抛出的异常

*/
    Class clazz = Class.forName("myReflect.reflectTest04.Student");

    // 获取里面所有的方法 包括父类中所有的公共方法
    Method[] methods1 = clazz.getMethods();
    Arrays.stream(methods1).forEach(method -> System.out.println(method));
    System.out.println("==========");

    // 获得子类中的方法 可以本类私有
    Method[] methods2 = clazz.getDeclaredMethods();
    Arrays.stream(methods2).forEach(method -> System.out.println(method));
    System.out.println("==========");

    // 获取单个的方法
    Method eat = clazz.getDeclaredMethod("eat", String.class);
    System.out.println(eat);
    System.out.println("==========");

    // 获取方法的形参
    Parameter[] parameters = eat.getParameters();
    Arrays.stream(parameters).forEach(parameter -> System.out.println(parameter));
    System.out.println("==========");

    // 获取方法抛出的异常
    Class[] exceptionTypes = eat.getExceptionTypes();
    Arrays.stream(exceptionTypes).forEach(e -> System.out.println(e));
    System.out.println("==========");

    //方法运行
    /*Method类中用于创建对象的方法
    Object invoke(Object obj, Object... args)：运行方法
    参数一：用obj对象调用该方法
    参数二：调用方法的传递的参数（如果没有就不写）
    返回值：方法的返回值（如果没有就不写）*/


    Student s = new Student();
    eat.setAccessible(true);
    //参数一s：表示方法的调用者
    //参数二"汉堡包"：表示在调用方法的时候传递的实际参数
    String result = (String) eat.invoke(s, "汉堡包");
    System.out.println(result);
}
```

## 反射的作用

1. 获取一个类里面所有的信息，获取到了之后，再执行其他的业务逻辑
2. 结合配置文件，动态的创建对象并调用方法
