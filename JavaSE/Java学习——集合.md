# Java学习——集合进阶

## 单列集合：

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240415130838293.png" alt="image-20240415130838293" style="zoom: 50%;" />

- list系列：添加的元素是**有序的，可重复的，有索引的**
- set系列：添加的元素是**无序的，不可重复的，无索引的**

### Collection

#### 通用方法

collection是单列集合的祖宗接口，他的**功能全部单列集合都能使用**

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240415131543535.png" alt="image-20240415131543535" style="zoom: 50%;" />

- 细节1：如果往list里面添加数据，那么**始终都为true**

- 细节2：如果往set里面添加数据，那么当**元素不存在时，为true，否则为false**

- 细节3：contains方法，底层是依赖equals()方法来判断是否存在，**所以当自定义类型的对象也想通过contains来判断，需要在JavaBean类中重写equals方法**，如果对于自定义类型的对象，没有重写equals方法，那么就会默认使用Object类中的equals()方法，Object中的equals()方法是依赖地址值进行判断

  ```java
      @Override
      public boolean equals(Object o) {
          if(this == o)
              return true;
          if(o ==null||getClass()!=o.getClass())
              return false;
          Student student=(Student) o;
          return age == student.age && Objects.equals(name, student.name);
      }
  ```

#### 遍历

##### 迭代器

迭代器在Java中的类是Iterator

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240415142209933.png" alt="image-20240415142209933" style="zoom: 50%;" />



```java
Collection<String>collection=new ArrayList<>();
collection.add("aaa");
collection.add("bbb");
collection.add("ccc");
collection.add("ddd");
collection.add("eee");

// 获取迭代器
// 迭代器默认指向集合的0索引处
Iterator<String> it=collection.iterator();
// 利用循环不断的获取集合的每一个元素
// hasNext():如果这个位置有元素
while (it.hasNext()){
    String str = it.next(); // next():获取元素 并且 移动指针
    // 删除元素时，不能使用集合的方法
    if("bbb".equals(str))
    {
        // collection.remove(str); // 这样会报错
        it.remove();
    }
}
```

细节1：迭代器遍历完毕，**指针不会复位**，如果想第二次遍历集合，那么需要再获取一个迭代器对象

细节2：循环中**只能使用一次next方法**

细节3：迭代器遍历时，**不能使用集合的方法进行增加和删除**，删除的话用it.remove()，添加的话暂时没有方法

细节4：迭代器遍历时，**是不依赖索引的**

##### 增强for

增强for的底层就是迭代器，所有的**单列集合**和**数组**才**可以用增强for**

```java
// 增强for遍历
// str其实就是一个第三方变量，在循环的过程中依次表示集合中的每一个数据
// 改变str不会改变集合中原本的数据
for (String str : collection) {
    System.out.println(str);
}
```

##### lambda表达式

```java
// lambda表达式进行遍历
// 首先写下匿名内部类的形式
// forEach
// 底层原理：其实也会遍历集合，依次得到每一个元素，把得到的每个元素，传递给下面的方法
// accept 的方法形参string就表示集合的每一个元素
collection.forEach(new Consumer<String>() {
    @Override
    // string 依次表示集合中的每一个数据
    public void accept(String string) {
        System.out.println(string);
    }
});

// 再写lambda表达式  (形参)->{方法体}
collection.forEach((String s)->{
    System.out.println(s);
});
```

### List集合

- 继承了很多collection的方法
- 因为List有索引，所以有很多操作索引的方法

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240416192625389.png" alt="image-20240416192625389" style="zoom: 50%;" />

```java
// List集合两个删除的方法
// 1、直接删除元素
// 2、按照索引进行删除

List<Integer>list=new ArrayList<>();
list.add(1);
list.add(2);
list.add(3);

// 删除元素
// 如果调用方法的时候，如果方法出现了重载的现象，优先调用实参和形参一致的方法
list.remove(1); // 按照索引
System.out.println(list);

// 手动把基本数据类型的1转化为Integer
list.remove(Integer.valueOf(1)); // 按照元素
System.out.println(list);
```

#### List集合的遍历方式

##### 普通for循环

```java
for (int i = 0; i < list.size(); i++) {
    System.out.println(list.get(i));
}
```

##### 列表迭代器

```java
// 列表迭代器遍历
// 在列表迭代器中添加了add()方法，可以添加元素
ListIterator<Integer> it = list.listIterator();
while (it.hasNext())
{
    int i=it.next();
    if(i==3)
    {
        it.add(2);
    }
    System.out.println(i);
}
System.out.println(list);
```

##### 总结

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240416200501975.png" alt="image-20240416200501975" style="zoom: 50%;" />

#### ArrayList

##### 底层原理

- 底层是**数组**结构
- 利用**空参**创建的集合，在底层创建一个**默认长度为0**的数组
- 添加**第一个**元素时，底层会创建一个**新的长度为10**的数组
- 存满时，会**扩容1.5倍**
- 如果一次添加多个元素，1.5倍放不下，则新创建的数组的长度以实际为准
- size有**两层**含义：当前**集合的长度**和**下一个元素应该放入的位置**

#### LinkedList

##### 底层原理

- 底层是**双向链表**

##### Linkedlist特有的方法

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240416204805561.png" alt="image-20240416204805561" style="zoom:50%;" />

### 泛型

- 泛型中不能写基本数据类型，**只能写引用数据类型**
- **指定泛型的具体类型**后，可以传入**该类类型或者其子类类型**
- 如果不写泛型，那么**默认类型是Object**

### Set集合

- **无序**：存取顺序不一致
- **不重复**：可以去除重复
- **无索引**：没有带索引的方法，所以不能用普通for遍历，也不能通过索引获取元素

set的方法与Collection一样

#### set的遍历

```java
Set<String>s=new HashSet<>();

// 添加元素
// 第一次添加，返回true
// 第二次添加，返回false
boolean r1 = s.add("张三");
boolean r2 = s.add("张三");

System.out.println(r1);
System.out.println(r2);

// 遍历
s.add("111");
s.add("222");
s.add("333");

// 迭代器遍历
Iterator<String> iterator = s.iterator();
while (iterator.hasNext())
{
    String str=iterator.next();
    System.out.println(str);
}

// 增强for
for (String string : s) {
    System.out.println(string);
}

// lambda表达式
s.forEach((String string)-> {
        System.out.println(string);
    }
);
```

#### HashSet

##### 原理

- HashSet的底层是用**哈希表**来储存的
- 哈希表底层的原理：jdk8之前：数组+链表 jdk8之后：数组+链表+红黑树

![](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240418195937748.png)

- jdk8之后，当**链表长度超过8**，且**数组长度大于等于64**时，自动将**链表转为红黑树**
- 如果集合中的元素是**自定义对象**，那么必须**重写hashcode和equals**方法

###### 哈希值

哈希值指的是**对象的整数表现形式**

- 如果没有重写hashcode方法，计算的哈希值是不一样的
- 如果已经**重写hashcode方法，不同的对象只要属性值相同，计算出的哈希值就是一样的**
- 但是在小部分情况下，不同的属性值或者不同的地址值计算出来的哈希值也有可能一样。(**哈希碰撞**)

 

```java
Student s1=new Student(23,"zhangsan");
Student s2=new Student(21,"lisi");

// 在JavaBean重写
@Override
public int hashCode() {
    return Objects.hash(age,name);
}

// 如果没有重写hashCode方法，不同对象的哈希值不同
// 重写hashCode之后，相同对象的哈希值相同
System.out.println(s1.hashCode());
System.out.println(s2.hashCode());
```

##### 为什么HashSet的存取顺序不一样

因为哈希值的顺序不一定相同，往链表中存的顺序不确定

##### Hashset是利用什么机制保证数据去重的?

利用HashCode方法和equals方法 

##### HashSet为什么没有索引

因为底层的数据结构不纯粹，过于复杂

#### LinkedHashSet

##### 特点

**有序**，不重复，无索引

- 保证存取的顺序是有序的

##### 原理

底层数据结构是依然哈希表，只是每个元素又额外的多了一个双链表的机制记录存储的顺序，**每个节点之间有双向链表**

![image-20240418201828927](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240418201828927.png)

#### TreeSet

##### 特点

不重复，无索引，**可排序**，默认是从小到大

##### 底层原理

红黑树

##### 默认的规则

- 对于数值类型:Integer，Double，默认按照从小到大的顺序进行排序
- 对于字符、字符串类型:按照字符在ASCII码表中的数字升序进行排序

##### TreeSet的两种排序方式

1. 默认的排序规则/自然排序：JavaBean类实现Comparable接口指定比较规则，如果不重写，会报错

2. ```
   public class Student implements Comparable<Student> {
       ...
   
       @Override
       public int compareTo(Student o) {
           // 按照年龄 从小到大排序
           
           // this表示当前要添加的元素，o表示已经存在的元素
           // 返回值
           // 负数：认为要添加的元素是小的，存左边
           // 正数：认为要添加的元素是大的，存右边
           // 0：认为要添加的元素已经存在，舍弃
           return this.getAge()-o.getAge();
       }
   }
   ```

   

3. 比较器排序：创建TreeSet对象的时候，传递比较器Comparator指定规则

```java
public static void main(String[] args) {
//        需求:请自行选择比较器排序和自然排序两种方式;
//        要求:存入四个字符串，“c”,“ab”,“df”,“qwer”按照长度排序，
//        如果一样长则按照首字母排序

    TreeSet<String>treeSet=new TreeSet<>(new Comparator<String>() {
        @Override
        public int compare(String o1, String o2) {
            // o1 表示要添加的元素
            // o2 表示已经存在的元素
            int res=o1.length()-o2.length();
            if(res==0)
            {
                // 如果一样长，按照首字母排序
                res=o1.compareTo(o2);
            }
            return res;
        }
    });
    treeSet.add("c");
    treeSet.add("ab");
    treeSet.add("df");
    treeSet.add("qwer");
    System.out.println(treeSet);
}
```

默认使用第一种，如果第一种不能满足当前需求，就使用第二种

### 单列集合使用场景

- 想要集合中的**元素可重复**：ArrayList，基于数组
- 想要集合中的**元素可重复，并且增删操作明显多于查询**：LinkedList，基于链表
- 想对集合中的**元素去重**：HashSet，基于哈希表
- 想对集合中的**元素去重，并且保证存取顺序**：LinkedHashSet，基于哈希表和双链表，效率低于HashSet
- 想对集合中的**元素去重，并且进行排序**：Treeset集合，基于红黑树

## 双列集合

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240419144208337.png" alt="image-20240419144208337" style="zoom: 50%;" />

### 特点

- 双列集合一次需要存一对数据，分别是key和value
- key不能重复，value可以重复
- key和value是一一对应的

### Map

<img src="C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240419134031159.png" alt="image-20240419134031159" style="zoom: 67%;" />

#### 遍历方式

##### 键找值

```java
// 获取所有的键，把键放到单列集合中
Set<String> stringSet = m.keySet();
// 遍历单列集合，得到每一个键
Iterator<String> it = stringSet.iterator();
while(it.hasNext())
{
    String key= it.next();
    // 利用键来获取值
    String value=m.get(key);
    System.out.println("key:"+key+" value:"+value);
}
```

##### 键值对

```java
// 通过键值对对象来遍历
Set<Map.Entry<String, String>> entrySet = m.entrySet();
// 遍历entrySet集合 获取每一个键值对对象
for (Map.Entry<String, String> stringStringEntry : entrySet) {
    System.out.println(stringStringEntry.getKey());
    System.out.println(stringStringEntry.getValue());
}
```

##### lambda表达式

```java
// 3-lambda表达式
m.forEach((String string, String string2)->{
        System.out.println(string+" "+string2);
    }
);
```

#### HashMap

##### 特点

- HashMap是Map里面的一个实现类
- 特点都是由键决定的：**无序，不重复，无索引**
- 底层原理和HashSet一样，都是**哈希表**
- **hashCode和equals**方法只**保证键的唯一**
- 如果键**存储自定义对象**，还是需要**重写hashCode和equals**方法，，如果值**存储自定义类型对象，不需要重写**

```java
public static void main(String[] args) {
    //某个班级80名学生，现在需要组成秋游活动，
    // 班长提供了四个景点依次是(A、B、C、D)
    // 每个学生只能选择一个景点，请统计出最终哪个景点想去的人数最多

    // 1、让学生先投票
    String arr[]={"A","B","C","D"};
    ArrayList<String>arrayList=new ArrayList<>();
    Random r=new Random();
    for (int i = 0; i < 80; i++) {
        arrayList.add(arr[r.nextInt(arr.length)]);
    }

    // 2、统计结果，放进map集合
    HashMap<String, Integer>hashMap=new HashMap<>();
    for (String name : arrayList) {
        if(hashMap.containsKey(name))
        {
            // 存在
            // 先获取key对应的value
            Integer count = hashMap.get(name);
            // 增加次数
            count++;
            // 更新次数
            hashMap.put(name,count);
        }else {
            // 不存在
            hashMap.put(name,1);
        }
    }

    // 3、寻找最大
    int maxInt = -1;
    String maxString = new String();
    Set<Map.Entry<String, Integer>> entries = hashMap.entrySet();
    for (Map.Entry<String, Integer> entry : entries) {
        if(entry.getValue()>maxInt)
        {
            maxInt=entry.getValue();
            maxString=entry.getKey();
        }
    }


    System.out.println(hashMap);
    System.out.println(maxInt);
    System.out.println(maxString);
}
```

#### LinkedHashMap

##### 特点

由键决定，**有序**，不重复，无索引

底层数据结构是依然哈希表，只是每个键值对元素又额外的多了一个**双链表**的机制记录存储的顺序

#### TreeMap

##### 特点

不重复，无索引，**可排序**（排序具体的查看TreeSet） 

```java
public static void main(String[] args) {
    // 键:整数表示id
    // 值:字符串表示商品名称
    // 要求:按照id的降序排列
    TreeMap<Integer,String>treeMap=new TreeMap<>(new Comparator<Integer>() {
        @Override
        public int compare(Integer o1, Integer o2) {
            int i=o2-o1;
            return i;
        }
    });

    treeMap.put(1,"aaa");
    treeMap.put(3,"ccc");
    treeMap.put(2,"bbb");
    System.out.println(treeMap);
}
```

```java
public static void main(String[] args) {
    // 键:学生对象
    // 值:籍贯
    // 要求:按照学生年龄的升序排列，年龄一样按照姓名的字母排列，同姓名年龄视为同一个人
    TreeMap<Student2,String>treeMap=new TreeMap<>(new Comparator<Student2>() {
        @Override
        public int compare(Student2 o1, Student2 o2) {
            int i=o1.getAge()-o2.getAge();
            if(i==0)
            {
                i=o1.getName().compareTo(o2.getName());
            }
            return i;
        }
    });
    Student2 stu1=new Student2("zhangsan",22);
    Student2 stu2=new Student2("lisi",22);
    Student2 stu3=new Student2("wangwu",23);
    treeMap.put(stu1,"suzhou");
    treeMap.put(stu2,"wuxi");
    treeMap.put(stu3,"yangzhou");

    System.out.println(treeMap);
}

@Override
public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    Student2 student = (Student2) o;
    return age == student.age && Objects.equals(name, student.name);
}

@Override
public int hashCode() {
    return Objects.hash(name, age);
}
```

```java
public static void main(String[] args) {
//        请统计字符串中每一个字符出现的次数，并按照以下格式输出
//        输出结果:
//        a(5)b(4)c(3)d(2)e(1)
    TreeMap<String,Integer>tm=new TreeMap<>();
    Scanner sc=new Scanner(System.in);
    String str=sc.next();
    for (int i = 0; i < str.length(); i++) {
        if(tm.containsKey(String.valueOf(str.charAt(i))))
        {
            Integer count = tm.get(String.valueOf(str.charAt(i)));
            count++;
            tm.put(String.valueOf(str.charAt(i)),count);
        }
        else {
            tm.put(String.valueOf(str.charAt(i)),1);
        }
    }

    tm.forEach((string, integer) -> System.out.print(string+"("+integer+")"));
}
```

### 可变参数

#### 特点

- 方法的形参个数是可以发生变化的，0,1,2...
- 格式：类型...名字  int...arr
- 底层原理：数组

```java
public static void main(String[] args) {
    System.out.println(getSum(1, 2, 3));
}
private static int getSum(int...arr)
{
    int sum=0;
    for (int i : arr) {
        sum+=i;
    }
    return sum;
}
```

#### 细节

1. 在方法形参中，**最多只能写一个**可变参数
2. 在方法当中，如果出了可变参数以外，还有其他的形参，那么**可变参数要写在最后**

## 不可变集合

### 特点

- 不能添加，不能删除，不能修改

- 作用：不想让别人修改集合中的内容
- 在List，Set，Map接口中都存在静态的of方法，可以获取一个不可变的集合

![image-20240422202640134](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240422202640134.png)

```java
public static void main(String[] args) {
    // 一旦创建完毕之后，是无法进行修改的，在下面的代码中，只能进行查询操作
    List<String>list=List.of("aaa","bbb","ccc","ddd");

    // 遍历
    Iterator<String> it = list.iterator();
    while (it.hasNext())
    {
        String str=it.next();
        System.out.println(str);
    }

    for (String s : list) {
        System.out.println(s);
    }

    list.forEach(string -> System.out.println(string));
}
```

### 细节

- Map 的of方法不能无限加，最多10对
- 可以通过Map.ofEntries()来创建超过10对的不可变集合

```java
public static void main(String[] args) {
    // Map的of方法最多10个键值对
    // 如果想要超过十个
    HashMap<String,String>hm=new HashMap<>();
    hm.put("aaa","111");
    hm.put("bbb","222");
    hm.put("ccc","333");
    hm.put("ddd","444");
    hm.put("eee","555");
    hm.put("fff","666");
    hm.put("ggg","777");
    hm.put("hhh","888");
    hm.put("iii","999");
    hm.put("jjj","AAA");
    hm.put("kkk","BBB");
    hm.put("lll","CCC");
    hm.put("mmm","DDD");
    hm.put("nnn","EEE");
    hm.put("ooo","FFF");

    // 利用上面的数据来获取一个不可变的集合
    // 获取到所有的键值对对象
    Set<Map.Entry<String, String>> entries = hm.entrySet();
    // 把entries变成一个数组
    // toArray方法会在底层比较集合的长度和数组的长度
    // 如果集合的长度 > 数组的长度 数组放不下，则会根据实际的个数，重新创建数组
    Map.Entry[] arr = entries.toArray(new Map.Entry[0]);
    // 创建一个不可变集合map1
    Map map1 = Map.ofEntries(arr);
    System.out.println(map1);


    // 简化生成不可变集合
    Map<String, String> map2 = Map.copyOf(hm);
    System.out.println(map2);
}
```

## Stream流

### 作用

结合lambda表达式，简化数组，集合的操作

### 使用步骤

1. 先得到一条Stream流，并把数据放上去

   ![image-20240426200016630](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240426200016630.png)

   双列集合时，要使用keySet()方法和entrySet()方法

   ```java
   // 单列集合获取Stream
   System.out.println("=====单列集合=====");
   ArrayList<String> list=new ArrayList<>();
   Collections.addAll(list,"a","b","c","d","e");
   // 获取到一条流水线，并把集合中的数据放到stream流中
   Stream<String> stream1 = list.stream();
   // 使用终结方法打印
   stream1.forEach(string -> System.out.println(string));
   
   // 双列集合获取Stream流
   System.out.println("=====双列集合=====");
   HashMap<String,Integer>hm=new HashMap<>();
   hm.put("aaa",111);
   hm.put("bbb",222);
   hm.put("ccc",333);
   hm.put("ddd",444);
   Set<String> keySet = hm.keySet();
   keySet.stream().forEach(new Consumer<String>() {
       @Override
       public void accept(String string) {
           System.out.println(string+" "+hm.get(string));
       }
   });
   System.out.println("===============");
   Set<Map.Entry<String, Integer>> entries = hm.entrySet();
   entries.stream().forEach(new Consumer<Map.Entry<String, Integer>>() {
       @Override
       public void accept(Map.Entry<String, Integer> stringIntegerEntry) {
           System.out.println(stringIntegerEntry.getKey()+" "+stringIntegerEntry.getValue());
       }
   });
   
   // 数组获取Stream流
   System.out.println("=====数组=====");
   int []arr= {1,2,3,4,5,6,7,8,9,10};
   Arrays.stream(arr).forEach(new IntConsumer() {
       @Override
       public void accept(int value) {
           System.out.println(value);
       }
   });
   
   // 零散的数据
   System.out.println("=====零散的数据=====");
   Stream.of(1,2,3,4,5).forEach(new Consumer<Integer>() {
       @Override
       public void accept(Integer integer) {
           System.out.println(integer);
       }
   });
   ```

2. 利用Stream流中的中间方法进行操作

   中间方法，返回**新的stream流**，**原来的Stream流只能使用一次**，建议使用**链式编程**

   修改Stream流中的数据，不会影响原来集合或者数组中的数据

   ![image-20240426200637599](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240426200637599.png)

   ```java
   // filter
   System.out.println("=====filter=====");
   arrayList.stream().filter(str -> {
       // 返回true，则留下。false则舍弃
       // A开头的留下
       if(str.startsWith("A"))
       {
           return true;
       }
       return false;
   }).filter(new Predicate<String>() {
       @Override
       public boolean test(String str) {
           return str.length()==3;
       }
   }).forEach(new Consumer<String>() {
       @Override
       public void accept(String str) {
           System.out.println(str);
       }
   });
   
   
   // limit 获取前几个元素
   System.out.println("=====limit=====");
   arrayList.stream().limit(3).
           forEach(new Consumer<String>() {
       @Override
       public void accept(String str) {
           System.out.println(str);
       }
   });
   
   // skip 跳过前几个元素
   System.out.println("=====skip=====");
   arrayList.stream().skip(2).forEach(new Consumer<String>() {
       @Override
       public void accept(String str) {
           System.out.println(str);
       }
   });
   
   // distinct 去重
   System.out.println("=====distinct=====");
   arrayList.stream().distinct().forEach(new Consumer<String>() {
       @Override
       public void accept(String string) {
           System.out.println(string);
       }
   });
   
   
   // concat 合并流
   System.out.println("=====concat=====");
   ArrayList<String>arrayList1=new ArrayList<>();
   arrayList1.add("X1");
   arrayList1.add("Y2");
   arrayList1.add("Z3");
   Stream.concat(arrayList.stream(),arrayList1.stream()).forEach(new Consumer<String>() {
       @Override
       public void accept(String string) {
           System.out.println(string);
       }
   });
   ```

3. 利用终结方法进行操作

   ![image-20240426200900604](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240426200900604.png)

```java
// long count() 统计
System.out.println(arrayList.stream().count());

// toArray() 收集数据 放到数组
Object[] array = arrayList.stream().toArray();
System.out.println(Arrays.toString(array));

// toArray方法参数的作用：负责创建一个指定类型的数组
// toArray方法底层，会依次得到流里面的每个数据，并把数据放到数组中
// toArray方法返回值：是一个装着流里面所有数据的数组
String[] arr = arrayList.stream().toArray(new IntFunction<String[]>() {
    // apply的形参：流中数据的个数，跟数组的长度保持一致
    // apply的返回值 具体类型的数组
    // 方法体：创建数组
    @Override
    public String[] apply(int value) {
        return new String[value];
    }
});

System.out.println(Arrays.toString(arr));

// collect
System.out.println("=====collect=====");
ArrayList<String> list1 = new ArrayList<>();
Collections.addAll(list1, "张无忌-男-15", "张无忌-男-15","周芷若-女-14", "赵敏-女-13", "张强-男-20", "张三丰-男-100", "张翠山-男-40", "张良-男-35", "王二麻子-男-37", "谢广坤-男-41");

// 收集到list集合当中
// 需求：把所有的男性收集起来
List<String> newList = list1.stream().
        filter(s -> s.split("-")[1].equals("男"))
        .collect(Collectors.toList());
System.out.println(newList);

// 收集到set集合当中
Set<String> newSet = list1.stream().filter(new Predicate<String>() {
    @Override
    public boolean test(String string) {
        return string.split("-")[1].equals("男");
    }
}).collect(Collectors.toSet());
System.out.println(newSet);

// 收集到Map集合
// 谁作为键 谁作为值
// 我要收集所有的男性
// 姓名=键
// 年龄-值
Map<String, Integer> newMap = list1.stream().filter(s -> s.split("-").equals("男"))
        /*
         toMap:参数1：键的生成规则
               参数2：值的生成规则
         参数1：
            Function 的泛型1：流中每个数据的类型
                       泛型2：Map集合中键的数据类型
               方法：apply的形参：表示流中的每个数据的类型
                    方法体：生成键的代码
                    apply的返回值：键的类型

         参数2：
            Function 的泛型1：流中每个数据的类型
                       泛型2：Map集合中值的数据类型
               方法：apply的形参：表示流中的每个数据的类型
                    方法体：生成值的代码
                    apply的返回值：值的类型
        * */
        .collect(Collectors.toMap(new Function<String, String>() {
            @Override
            public String apply(String string) {
                return string.split("-")[0];
            }
        }, new Function<String, Integer>() {
            @Override
            public Integer apply(String string) {
                return Integer.parseInt(string.split("-")[2]);
            }
        }));
System.out.println(newMap);
```

## 方法引用

把已经有的方法拿过来用，当作函数式接口中抽象方法的方法体

1. 引用处必须是接口
2. 被引用的方法必须存在
3. 被引用的方法的形参和返回值需要跟抽象方法保持一致
4. 被引用方法的功能满足当前需求

```java
public static void main(String[] args) {
    // 需求：创建一个数组，进行倒序排列
    Integer arr[]={3,5,4,1,6,2};

    // 匿名内部类
    Arrays.sort(arr, new Comparator<Integer>() {
        @Override
        public int compare(Integer o1, Integer o2) {
            return o2-o1;
        }
    });
    System.out.println(Arrays.toString(arr));

    // lambda表达式
    // 因为第二个参数是函数式接口，所以能写lambda表达式
    Arrays.sort(arr,(o1, o2) -> o2-o1);
    System.out.println(Arrays.toString(arr));

    // 方法引用
//        1. 引用处必须是函数式接口
//        2. 被引用的方法必须已经存在
//        3. 被引用方法的形参和返回值需要跟抽象方法保持一致
//        4. 被引用的方法功能要满足当前需求
    // 表示引用FunctionDemo1中的subtraction
    // 把这个方法当作抽象方法的方法体
    Arrays.sort(arr,FunctionDemo1::subtraction);
    System.out.println(Arrays.toString(arr));
}

public static int subtraction(int num1,int num2)
{
    return num2-num1;
}
```

### 方法引用的分类

#### 引用静态方法

格式：类名::静态方法

```java
ArrayList<String>list=new ArrayList<>();
Collections.addAll(list,"1","2","3","4","5");

// lambda 表达式
list.stream().map(string -> Integer.parseInt(string)).forEach(s-> System.out.println(s));
System.out.println("==========");
list.stream()
        .map(Integer::parseInt)
        .forEach(i-> System.out.println(i));
```

#### 引用成员方法

##### 引用其他类的成员方法

格式：其他类对象::方法名

```java
ArrayList<String>list=new ArrayList<>();
Collections.addAll(list,"张无忌","周芷若","赵敏","张强","张三丰");
// lambda表达式
list.stream()
        .filter(s->s.startsWith("张"))
        .filter(s->s.length()==3);

// 匿名内部类
list.stream().filter(new Predicate<String>() {
    @Override
    public boolean test(String string) {
        return string.startsWith("张")&&string.length()==3;
    }
}).forEach(s-> System.out.println(s));

// 方法引用
list.stream().filter(new StringOperation()::StringJudge);


public boolean StringJudge(String s)
{
    return s.startsWith("张")&&s.length()==3;
}
```

##### 引用本类的成员方法

格式：this::方法名

##### 引用父类的成员方法

super::方法名

#### 引用构造方法

格式：类名::new

```java
 /*
方法引用（引用构造方法）
格式
        类名::new

目的：
        创建这个类的对象

需求：
     集合里面存储姓名和年龄，要求封装成Student对象并收集到List集合中
*/
ArrayList<String>list=new ArrayList<>();
Collections.addAll(list,"张无忌,15", "周芷若,14", "赵敏,13", "张强,20", "张三丰,100", "张翠山,40", "张良,35", "王二麻子,37", "谢广坤,41");

List<Student> newList1 = list.stream().map(Student::new).collect(Collectors.toList());
System.out.println(newList1);

// 重写构造函数
public Student(String str)
{
    this.name=str.split(",")[0];
    this.age=Integer.parseInt(str.split(",")[1]);
}
```

#### 使用类名引用成员方法

格式：类名::成员方法

```java
/*
方法引用（类名引用成员方法）
格式
        类名::成员方法
需求：
     集合里面一些字符串，要求变成大写后进行输出

             方法引用的规则：
1.需要有函数式接口
2.被引用的方法必须已经存在
3.被引用方法的形参，需要跟抽象方法的第二个形参到最后一个形参保持一致，返回值需要保持一致。
4.被引用方法的功能需要满足当前的需求

抽象方法形参的详解：
第一个参数：表示被引用方法的调用者，决定了可以引用哪些类中的方法
            在Stream流当中，第一个参数一般都表示流里面的每一个数据。
            假设流里面的数据是字符串，那么使用这种方式进行方法引用，只能引用String这个类中的方法

第二个参数到最后一个参数：跟被引用方法的形参保持一致，如果没有第二个参数，说明被引用的方法需要是无参的成员方法

局限性：
    不能引用所有类中的成员方法。
    是跟抽象方法的第一个参数有关，这个参数是什么类型的，那么就只能引用这个类中的方法。
  */
//1.创建集合对象
ArrayList<String> list = new ArrayList<>();
//2.添加数据
Collections.addAll(list, "aaa", "bbb", "ccc", "ddd");

//3.变成大写后进行输出
//map(String::toUpperCase)
//拿着流里面的每一个数据，去调用String类中的toUpperCase方法，方法的返回值就是转换之后的结果。
list.stream().map(String::toUpperCase).forEach(s -> System.out.println(s));
```

#### 引用数组的构造方法

格式：数据类型[]::new

```java
public static void main(String[] args) {
     /*
    方法引用（数组的构造方法）
    格式
            数据类型[]::new
    目的：
            创建一个指定类型的数组
    需求：
         集合中存储一些整数，收集到数组当中

    细节：
        数组的类型，需要跟流中数据的类型保持一致。

   */
    //1.创建集合并添加元素
    ArrayList<Integer> list = new ArrayList<>();
    Collections.addAll(list, 1, 2, 3, 4, 5);

    Integer[]arr=list.toArray(new IntFunction<Integer[]>() {
        @Override
        public Integer[] apply(int value) {
            return new Integer[value];
        }
    });

    System.out.println(Arrays.toString(arr));

    System.out.println(list.stream().toArray(Integer[]::new));
}
```

