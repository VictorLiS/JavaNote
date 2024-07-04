# Web前端开发

## web的三个组成部分

- HTML:负责网页的结构(页面元素和内容)
- CS5:负责网页的表现(页面元素的外观、位置等页面样式，如:颜色、大小等)
- JavaScript:负责网页的行为(交互效果)

## HTML、CSS

### 介绍

HTML:**超文本标记**语言

- 超文本：超越了文本的限制，比普通文本更强大。除了文字信息，还可以定义图片、音频、视频等内容。
- 标记语言：由标签构成的语言

  - HTML标签都是预定义好的。例如:使用<a>展示超链接，使用<img>展示图片，<vide0>展示视频。
- HTML代码直接在浏览器中运行，HTML标签由浏览器解析。

CSS：层叠样式表，用于控制页面的样式

### 标签结构

```html
<html>
		<head>
				<title>标题</title>
		</head>
		<body>
				体
		</body>
</html>
```

#### 特点

- HTML标签不区分大小写
- HTML标签属性值单双引号都可以
- HTML语法松散

#### 标题排版

##### 图片标签  

img

- src：指定图像的位置（相对路径/绝对路径）
- weight：图像的宽度（像素/相对于父元素的百分比）
- height：图像的高度（像素/相当于父元素的百分比）

##### 标题标签 

h1-h6

##### 水平线标签 

hr

```html
<body>
    <!-- 
    img标签: 
        src: 图片资源路径
        width: 宽度(px, 像素 ; % , 相对于父元素的百分比)
        height: 高度(px, 像素 ; % , 相对于父元素的百分比)
        
        <img src="img/news_logo.png" width="80%" >

    路径书写方式:
        绝对路径:
            1. 绝对磁盘路径: D:\Study\java_study\代码\JavaWeb\HTML\新浪新闻演示\img\news_logo.png
                           <img src="D:\Study\java_study\代码\JavaWeb\HTML\新浪新闻演示\img\news_logo.png">

            2. 绝对网络路径: https://i2.sinaimg.cn/dy/deco/2012/0613/yocc20120613img01/news_logo.png
                           <img src="https://i2.sinaimg.cn/dy/deco/2012/0613/yocc20120613img01/news_logo.png">
        相对路径:
            ./ : 当前目录 , ./ 可以省略的
            ../: 上一级目录
     -->
     <img src="img/news_logo.png",width="100%"> 新浪政务 > 正文
     <h1>
        焦点访谈: 中国底气 新思想夯实大国粮仓
     </h1>
     
     <hr>
     2023年03月02日 21:50央视网
     <hr>
</body>
```

#### 标题样式

修改样式需要在html中插入CSS

##### CSS引入方式

| 名称     | 语法描述                                     | 示例                                        |
| -------- | -------------------------------------------- | ------------------------------------------- |
| 行内样式 | 在标签内使用style属性，属性值是css属性键值对 | <h1 style="xxx:xxx;">中国新闻网</h1>        |
| 内嵌样式 | 定义<style>标签，在标签内部定义css样式       | <style> h1 {...} </style>                   |
| 外联样式 | 定义<link>标签，通过href属性引入外部css文件  | <link rel="stylesheet" href="css/news.css"> |

##### 颜色表示

![image-20240626151854223](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240626151854223.png)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- 字符集为utf-8 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>焦点访谈:中国底气 新思想夯实大国粮仓</title>

    <!-- 方式二：内嵌样式 -->
     <style>
        h1 {
            /* color: red; */

            /* color: rgb(255, 0, 0); */

            color: #4d4f53;
        }
     </style>

     <!-- 方式三：外联样式 -->
      <!-- <link rel="stylesheet" href="./CSS/news.css"> -->

</head>
<body>
     <img src="img/news_logo.png",width="100%"> 新浪政务 > 正文
     <!-- 方式一：行内样式 -->
     <!-- <h1 style="color: red;">
        焦点访谈:中国底气 新思想夯实大国粮仓
     </h1> -->
     <h1>
        焦点访谈:中国底气 新思想夯实大国粮仓
     </h1>
     <hr>
     2023年03月02日 21:50央视网
     <hr>
</body>
</html>
```

##### CSS选择器

顾名思义：选择器是选取需设置样式的元素（标签），但是我们根据业务场景不同，选择的标签的需求也是多种多样的，所以选择器有很多种，因为我们是做后台开发的，所以对于css选择器，我们只学习最基本的3种。

**选择器通用语法如下**：

```css
选择器名   {
    css样式名：css样式值;
    css样式名：css样式值;
}
```

**1.元素（标签）选择器：** 

- 选择器的名字必须是标签的名字
- 作用：选择器中的样式会作用于所有同名的标签上

~~~
元素名称 {
    css样式名:css样式值；
}
~~~

例子如下：

~~~css
 div{
     color: red;
 }
~~~

**2.id选择器:**

- 选择器的名字前面需要加上#
- 作用：选择器中的样式会作用于指定id的标签上，而且有且只有一个标签（由于id是唯一的）

~~~
#id属性值 {
    css样式名:css样式值；
}
~~~

例子如下：

~~~css
#did {
    color: blue;
}
~~~

**3.类选择器：**

- 选择器的名字前面需要加上 .
- 作用：选择器中的样式会作用于所有class的属性值和该名字一样的标签上，可以是多个

~~~
.class属性值 {
    css样式名:css样式值；
}
~~~

例子如下：

~~~css
.cls{
     color: green;
 }
~~~

**优先级**

id选择器>类选择器>元素选择器

```html
<!-- 文档类型为html -->
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- 字符集为utf-8 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>焦点访谈:中国底气 新思想夯实大国粮仓</title>

    <!-- 方式二：内嵌样式 -->
     <style>
        h1 {
            /* color: red; */

            /* color: rgb(255, 0, 0); */

            color: #4d4f53;
        }

        /* id选择器 */
        #time{
         color: #968D92;
         font-size: 13px; /*设置字体的大小*/
        }
     </style>
</head>
<body>
     <img src="img/news_logo.png",width="100%"> 新浪政务 > 正文
     <h1>
        焦点访谈:中国底气 新思想夯实大国粮仓
     </h1>

     <hr>
     <span class="cls1" id="time">2023年03月02日 21:50</span>
     <span>央视网</span>
     <hr>
</body>
</html>
```

##### 超链接

- 标签: &lt;a href="..." target="...">央视网</a>
- 属性:
  - href: 指定资源访问的url
  - target: 指定在何处打开资源链接
    - _self: 默认值，在当前页面打开
    - _blank: 在空白页面打开

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- 字符集为utf-8 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>焦点访谈:中国底气 新思想夯实大国粮仓</title>

    <!-- 方式二：内嵌样式 -->
     <style>
        h1 {
            /* color: red; */

            /* color: rgb(255, 0, 0); */

            color: #4d4f53;
        }

        /* id选择器 */
        #time{
         color: #968D92;
         font-size: 12px;
        }

        a{
         color: black;
         text-decoration: none; /* 设置一个文本为标准的文本 */
        }
     </style>
</head>
<body>
     <img src="img/news_logo.png"> <a href="http://gov.sina.com.cn/" target="_self">新浪政务</a>  > 正文
     <!-- 方式一：行内样式 -->
     <!-- <h1 style="color: red;">
        焦点访谈:中国底气 新思想夯实大国粮仓
     </h1> -->
     
     <h1>
        焦点访谈:中国底气 新思想夯实大国粮仓
     </h1>

     <hr>
     <span class="cls1" id="time">2023年03月02日 21:50</span>
     <span>
      <a href="https://news.cctv.com/2023/03/02/ARTIUCKFf9kE9eXgYE46ugx3230302.shtml" target="_blank">
         央视网
      </a></span>
     <hr>
</body>
</html>
```

#### 正文样式

##### 视频标签

视频标签: &lt;video>

- 属性: 
  - src: 规定视频的url
  - controls: 显示播放控件
  - width: 播放器的宽度
  - height: 播放器的高度

##### 音频标签

音频标签: &lt;audio>

- 属性:
  - src: 规定音频的url
  - controls: 显示播放控件

##### **段落标签**

- 换行标签: &lt;br>
  - 注意: 在HTML页面中,我们在编辑器中通过回车实现的换行, 仅仅在文本编辑器中会看到换行效果, 浏览器是不会解析的, HTML中换行需要通过br标签

- 段落标签: &lt;p>
  - 如: &lt;p> 这是一个段落 &lt;/p>

##### **文本格式标签**

| 效果   | 标签 | 标签(强调) |
| ------ | :--: | :--------: |
| 加粗   |  b   |   strong   |
| 倾斜   |  i   |     em     |
| 下划线 |  u   |    ins     |
| 删除线 |  s   |    del     |

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- 字符集为utf-8 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>焦点访谈:中国底气 新思想夯实大国粮仓</title>

    <!-- 方式二：内嵌样式 -->
     <style>
        h1 {
            color: #4d4f53;
        }

        /* id选择器 */
        #time{
         color: #968D92;
         font-size: 12px;
        }

        a{
         color: black;
         text-decoration: none; /* 设置一个文本为标准的文本 */
        }

        p{
         text-indent: 35px; /* 设置首行缩进 */
         line-height: 40px; /* 设置行高 */
        }
        
        #plast{
         text-align: right; /* 对齐方式：靠右 */
        }
     </style>
</head>
<body>
     <img src="img/news_logo.png"> <a href="http://gov.sina.com.cn/" target="_self">新浪政务</a>  > 正文
     <!-- 方式一：行内样式 -->
     <!-- <h1 style="color: red;">
        焦点访谈:中国底气 新思想夯实大国粮仓
     </h1> -->
     
     <h1>
        焦点访谈:中国底气 新思想夯实大国粮仓
     </h1>

     <hr>
     <span class="cls1" id="time">2023年03月02日 21:50</span>
     <span>
      <a href="https://news.cctv.com/2023/03/02/ARTIUCKFf9kE9eXgYE46ugx3230302.shtml" target="_blank">
         央视网
      </a></span>
     <hr>

     <!-- 正文 -->
      <!-- 视频 -->
      <video src="./video/1.mp4" controls="controls"></video>

      <!-- 音频 -->
<!--        <audio src="./audio/1.mp3" controls="controls"></audio> -->
        <p>
         <b>央视网消息</b>（焦点访谈）：党的十八大以来，以习近平同志为核心的党中央始终把解决粮食安全问题作为治国理政的头等大事，
         重农抓粮一系列政策举措有力有效，我国粮食产量站稳1.3万亿斤台阶，实现谷物基本自给、口粮绝对安全。
         我们把饭碗牢牢端在自己手中，为保障经济社会发展提供了坚实支撑，
         为应对各种风险挑战赢得了主动。连续八年1.3万亿斤，这个沉甸甸的数据是如何取得的呢？
        </p>

        <p>
         人勤春来早，春耕农事忙。立春之后，由南到北，我国春耕春管工作陆续展开，春天的田野处处生机盎然。
        </p>

        <img src="./img/1.jpg">

        <p>
         中国式现代化一个重要的中国特色是人口规模巨大的现代化。我们粮食生产的发展，
         意味着我们要立足国内，解决14亿多人吃饭的问题。仓廪实，天下安。保障粮食安全是一个永恒的课题，
         任何时候都不能放松。在以习近平同志为核心的党中央坚强领导下，亿万中国人民辛勤耕耘、不懈奋斗，
         我们就一定能够牢牢守住粮食安全这一“国之大者”，把中国人的饭碗牢牢端在自己手中，夯实中国式现代化基础。
        </p>

        <p id="plast">
         责任编辑：XXX SN242
        </p>
</body>
</html>
```

#### 正文排版

##### 盒子模型

- 盒子：页面中所有的元素（标签），都可以看做是一个 盒子，由盒子将页面中的元素包含在一个矩形区域内，通过盒子的视角更方便的进行页面布局

- 盒子模型组成：内容区域（content）、内边距区域（padding）、边框区域（border）、外边距区域（margin）

<img src="D:/Study/java_study/黑马资料/JavaWeb/day01-HTML-CSS/讲义/assets/image-20230310092820616.png" alt="image-20230310092820616" style="zoom:80%;" /> 

##### 布局标签

- 布局标签：实际开发网页中，会大量频繁的使用 div 和 span 这两个没有语义的布局标签。

- 标签：<div> <span>

- 特点：

  - div标签：

    - 一行只显示一个（独占一行）

    - 宽度默认是父元素的宽度，高度默认由内容撑开

    - 可以设置宽高（width、height）

  - span标签：

    - 一行可以显示多个

    - 宽度和高度默认由内容撑开

    - 不可以设置宽高（width、height）

代码编写好了, 可以通过浏览器打开该页面, 通过开发者工具,我们就可以看到盒子的大小, 以及盒子各个组成部分(内容、内边距、边框、外边距)：

![image-20230310094312355](D:/Study/java_study/黑马资料/JavaWeb/day01-HTML-CSS/讲义/assets/image-20230310094312355.png) 



我们也可以，通过浏览器的开发者工具，清晰的看到这个盒子，以及每一个部分的大小：

![image-20230310094412539](D:/Study/java_study/黑马资料/JavaWeb/day01-HTML-CSS/讲义/assets/image-20230310094412539.png) 

#####  布局实现

```html
<!-- 文档类型为html -->
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- 字符集为utf-8 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>焦点访谈:中国底气 新思想夯实大国粮仓</title>

    <!-- 方式二：内嵌样式 -->
     <style>
        h1 {
            /* color: red; */

            /* color: rgb(255, 0, 0); */

            color: #4d4f53;
        }

        /* 元素选择器 */
        /* span{
         color: #968D92;
        } */

        /* 类选择器 */
        /* .cls1{
         color: #968D92;
        } */

        /* id选择器 */
        #time{
         color: #968D92;
         font-size: 12px;
        }

        a{
         color: black;
         text-decoration: none; /* 设置一个文本为标准的文本 */
        }

        p{
         text-indent: 35px; /* 设置首行缩进 */
         line-height: 40px; /* 设置行高 */
        }
        
        #plast{
         text-align: right; /* 对齐方式：靠右 */
        }

        #center{
         width: 65%;
            /* margin: 0% 17.5% 0% 17.5% ; */ /* 外边距, 上 右 下 左 */
         margin: 0 auto;
        }
     </style>
</head>
<body>
   <div id="center">
     <img src="img/news_logo.png"> <a href="http://gov.sina.com.cn/" target="_self">新浪政务</a>  > 正文
     <!-- 方式一：行内样式 -->
     <!-- <h1 style="color: red;">
        焦点访谈:中国底气 新思想夯实大国粮仓
     </h1> -->
     
     <h1>
        焦点访谈:中国底气 新思想夯实大国粮仓
     </h1>

     <hr>
     <span class="cls1" id="time">2023年03月02日 21:50</span>
     <span>
      <a href="https://news.cctv.com/2023/03/02/ARTIUCKFf9kE9eXgYE46ugx3230302.shtml" target="_blank">
         央视网
      </a></span>
     <hr>

     <!-- 正文 -->
      <!-- 视频 -->
      <video src="./video/1.mp4" controls="controls"></video>

      <!-- 音频 -->
<!--        <audio src="./audio/1.mp3" controls="controls"></audio> -->
        <p>
         <b>央视网消息</b>（焦点访谈）：党的十八大以来，以习近平同志为核心的党中央始终把解决粮食安全问题作为治国理政的头等大事，
         重农抓粮一系列政策举措有力有效，我国粮食产量站稳1.3万亿斤台阶，实现谷物基本自给、口粮绝对安全。
         我们把饭碗牢牢端在自己手中，为保障经济社会发展提供了坚实支撑，
         为应对各种风险挑战赢得了主动。连续八年1.3万亿斤，这个沉甸甸的数据是如何取得的呢？
        </p>

        <p>
         人勤春来早，春耕农事忙。立春之后，由南到北，我国春耕春管工作陆续展开，春天的田野处处生机盎然。
        </p>

        <img src="./img/1.jpg">

        <p>
         中国式现代化一个重要的中国特色是人口规模巨大的现代化。我们粮食生产的发展，
         意味着我们要立足国内，解决14亿多人吃饭的问题。仓廪实，天下安。保障粮食安全是一个永恒的课题，
         任何时候都不能放松。在以习近平同志为核心的党中央坚强领导下，亿万中国人民辛勤耕耘、不懈奋斗，
         我们就一定能够牢牢守住粮食安全这一“国之大者”，把中国人的饭碗牢牢端在自己手中，夯实中国式现代化基础。
        </p>

        <p id="plast">
         责任编辑：XXX SN242
        </p>
      </div>
</body>
</html>
```

### 表格标签

![image-20240629211858475](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240629211858475.png)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HTML-表格</title>
    <style>
        td {
            text-align: center; /* 单元格内容居中展示 */
        }
    </style>
</head>
<body>
    <table border="1px" cellspacing="0"  width="600px">
        <tr>
            <th>序号</th>
            <th>品牌Logo</th>
            <th>品牌名称</th>
            <th>企业名称</th>
        </tr>
        <tr>
            <td>1</td>
            <td> <img src="../img/huawei.jpg" width="100px"> </td>
            <td>华为</td>
            <td>华为技术有限公司</td>
        </tr>
        <tr>
            <td>2</td>
            <td> <img src="../img/alibaba.jpg"  width="100px"> </td>
            <td>阿里</td>
            <td>阿里巴巴集团控股有限公司</td>
        </tr>
    </table>
</body>
</html>
```

### 表单标签

- 表单场景: 表单就是在网页中负责数据采集功能的，如：注册、登录的表单。 

- 表单标签: &lt;form>
- 表单属性:
  - action: 规定表单提交时，向何处发送表单数据，表单提交的URL。
  - method: 规定用于发送表单数据的方式，常见为： GET、POST。
    - GET：表单数据是拼接在url后面的， 如： xxxxxxxxxxx?username=Tom&age=12，url中能携带的表单数据大小是有限制的。
    - POST： 表单数据是在请求体（消息体）中携带的，大小没有限制。

- 表单项标签: 不同类型的input元素、下拉列表、文本域等。
  - input: 定义表单项，通过type属性控制输入形式
  - select: 定义下拉列表
  - textarea: 定义文本域

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <!-- 
    form表单属性: 
        action: 表单提交的url, 往何处提交数据 . 如果不指定, 默认提交到当前页面
        method: 表单的提交方式 .
            get: 在url后面拼接表单数据, 比如: ?username=Tom&age=12 , url长度有限制 . 默认值
            post: 在消息体(请求体)中传递的, 参数大小无限制的.
    -->   
    <form action="" method="get">
        用户名:<input type="text" name="username">
        年龄:<input type="text" name="age">

        <input type="submit" value="提交">
    </form>
</body>
</html>
```

#### 表单项

有以下三种

在一个表单中，可以存在很多的表单项，而虽然表单项的形式各式各样，但是表单项的标签其实就只有三个，分别是：

- &lt;input>: 表单项 , 通过type属性控制输入形式。

  ![image-20240629220201288](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240629220201288.png)

- &lt;select>: 定义下拉列表, &lt;option> 定义列表项

- &lt;textarea>: 文本域

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HTML-表单项标签</title>
</head>
<body>

<!-- value: 表单项提交的值 -->
<form action="" method="post">
     姓名: <input type="text" name="name"> <br><br>
     密码: <input type="password" name="password"> <br><br> 
     性别: <input type="radio" name="gender" value="1"> 男
          <label><input type="radio" name="gender" value="2"> 女 </label> <br><br>
     爱好: <label><input type="checkbox" name="hobby" value="java"> java </label>
          <label><input type="checkbox" name="hobby" value="game"> game </label>
          <label><input type="checkbox" name="hobby" value="sing"> sing </label> <br><br>
     图像: <input type="file" name="image">  <br><br>
     生日: <input type="date" name="birthday"> <br><br>
     时间: <input type="time" name="time"> <br><br>
     日期时间: <input type="datetime-local" name="datetime"> <br><br>
     邮箱: <input type="email" name="email"> <br><br>
     年龄: <input type="number" name="age"> <br><br>
     学历: <select name="degree">
               <option value="">----------- 请选择 -----------</option>
               <option value="1">大专</option>
               <option value="2">本科</option>
               <option value="3">硕士</option>
               <option value="4">博士</option>
          </select>  <br><br>
     描述: <textarea name="description" cols="30" rows="10"></textarea>  <br><br>
     <input type="hidden" name="id" value="1">
	 	
     <!-- 表单常见按钮 -->
     <input type="button" value="按钮">
     <input type="reset" value="重置"> 
     <input type="submit" value="提交">   
     <br>
</form>

</body>
</html>
```

## Java Script

### 介绍

是一门跨平台、面向对象的脚本语言。是用来控制网页行为的，它能使网页可交互

### 引入方式

**第一种方式：**内部脚本，将JS代码定义在HTML页面中

- JavaScript代码必须位于&lt;script&gt;&lt;/script&gt;标签之间
- 在HTML文档中，可以在任意地方，放置任意数量的&lt;script&gt;
- 一般会把脚本置于&lt;body&gt;元素的底部，可改善显示速度

例子：

~~~html
<script>
    alert("Hello JavaScript")
</script>
~~~

**第二种方式：**外部脚本将， JS代码定义在外部 JS文件中，然后引入到 HTML页面中

- 外部JS文件中，只包含JS代码，不包含&ltscript&gt;标签
- 引入外部js的&lt;script&gt;标签，必须是双标签

例子：

~~~html
<script src="js/demo.js"></script>
~~~

注意：demo.js中只有js代码，没有&lt;script&gt;标签

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JS-引入方式</title>
    <!-- 内部脚本 -->
     <script>
        alert('Hello js 内部脚本');
     </script>

     <!-- 外部脚本 -->
      <script src="./js/demo.js"></script>
</head>
<body>
    
</body>
</html>
```

### 基础语法

#### 书写语法

##### 输出

- 区分大小写：与 Java 一样，变量名、函数名以及其他一切东西都是区分大小写的

- 每行结尾的分号可有可无

- 大括号表示代码块

- 注释：

  - 单行注释：// 注释内容

  - 多行注释：/* 注释内容 */

js中3钟输出语句，来演示书写语法

| api              | 描述             |
| ---------------- | ---------------- |
| window.alert()   | 警告框           |
| document.write() | 在HTML 输出内容  |
| console.log()    | 写入浏览器控制台 |

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JS-基本语法</title>
</head>
<body>
    <script>
        // 方式1：弹出一个警告框
        alert('hello JS');

        // 方式2：写入html界面
        document.write('hello JS');

        // 方式3：往浏览器的控制台输出
        console.log('Hello JS');
    </script>
</body>
</html>
```

##### 变量

| 关键字 | 解释                               |
| ------ | ---------------------------------- |
| var    | 变量声明的关键字                   |
| let    | let只在代码块内生效，局部变量      |
| const  | 声明常量的，常量一旦声明，不能修改 |

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        // var 定义变量
        // 特点1：作用域比较大，全局变量
        // 特点2：可以重复定义
        // 在代码块中定义的，在代码块外面也能获取到
        var a=10;
        a='张三';
        alert(a);

        // let 定义变量
        // 特点1：局部变量，代码块中定义的，不能在代码块外面访问
        // 特点2：不能重复定义
        {
            let b=1;
        }

        // const变量 常量，不能改变
        const pi=3.14;
        
    </script>
</body>
</html>
```

##### 数据类型、运算符、流程控制语句、数据类型转换

| 数据类型  | 描述                                               |
| --------- | -------------------------------------------------- |
| number    | 数字（整数、小数、NaN(Not a Number)）              |
| string    | 字符串，单双引皆可                                 |
| boolean   | 布尔。true，false                                  |
| null      | 对象为空                                           |
| undefined | 当声明的变量未初始化时，该变量的默认值是 undefined |

使用 typeof 运算符可以获取数据类型

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        //原始数据类型
        alert(typeof 3); //number
        alert(typeof 3.14); //number

        alert(typeof "A"); //string
        alert(typeof 'Hello');//string

        alert(typeof true); //boolean
        alert(typeof false);//boolean

        alert(typeof null); //object 

        var a ;
        alert(typeof a); //undefined
    </script>
</body>
</html>
```

| 运算规则   | 运算符                                                       |
| ---------- | ------------------------------------------------------------ |
| 算术运算符 | + , - , * , / , % , ++ , --                                  |
| 赋值运算符 | = , += , -= , *= , /= , %=                                   |
| 比较运算符 | > , < , >= , <= , != , == , ===   注意     **== 会进行类型转换，=== 不会进行类型转换** |
| 逻辑运算符 | && , \|\| , !                                                |
| 三元运算符 | 条件表达式 ? true_value: false_value                         |

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        var a=10;
        alert(a=="10"); // true
        alert(a==='10'); // false
        alert(a===10); // true
    </script>
</body>
</html>
```

**数据类型转换**

- 字符串转换为数字
  - 将字符串字面值转为数字。如果字面值不是数字，则转为NaN
- 其他类型转换为boolean
  - Number:0和NaN为false，其他均转为true
  - String:空字符串为false，其他均转为true
  - Null和 undefined:均转为false

**流程控制语句和Java一致，if...else，switch，for，while，do...while**

### 函数

#### **定义方式1**

~~~html
function 函数名(参数1,参数2..){
    要执行的代码
}

<script>
    function add(a,b) 
    {
        return a+b;
    }

    var res=add(10,20);

    alert(res);
</script>
~~~

**注意**

- 形参不需要指定类型
- 返回值也不需要定义类型

#### **定义方式2**

~~~html
var functionName = function (参数1,参数2..){   
	//要执行的代码
}

<script>
    var add=function(a,b)
    {
        return a+b;
    }

    var res=add(10,20);

    alert(res);
</script>
~~~

**函数的调用可以传递多个参数**

### 对象

#### 基本对象

##### Array

Array对象时用来定义数组的。常用语法格式有如下2种：

方式1：

~~~js
var 变量名 = new Array(元素列表); 
~~~

例如：

~~~js
var arr = new Array(1,2,3,4); //1,2,3,4 是存储在数组中的数据（元素）
~~~



方式2：

~~~js
var 变量名 = [ 元素列表 ]; 
~~~

例如：

~~~js
var arr = [1,2,3,4]; //1,2,3,4 是存储在数组中的数据（元素）
~~~

数组定义好了，那么我们该如何获取数组中的值呢？和java中一样，需要通过索引来获取数组中的值。语法如下：

~~~js
arr[索引] = 值;
~~~

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        // 定义数组
        var arr1=new Array(1,2,3,4);
        console.log(arr1[0]);
        console.log(arr1[1]);

        var arr2=[5,6,7,8];    
    </script>
</body>
</html>
```

js中，数组的长度是可变的，也可以存储任意的数据类型

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        // 特点：长度可变，类型可变
        var arr=[5,6,7,8];
        arr[10]=50;
        console.log(arr[10]); // 输出50
        console.log(arr[9]); // 输出undefined
        console.log(arr[8]); // 输出undefined

        arr[9]='A';
        arr[8]=true;

        console.log(arr);
    </script>
</body>
</html>
```

![image-20240702145601271](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240702145601271.png)

**属性和方法**

Array作为一个对象，那么对象是有属性和方法的，所以接下来我们介绍一下Array对象的属性和方法

官方文档中提供了Array的很多属性和方法，但是我们只学习常用的属性和方法，如下图所示：

属性：

| 属性   | 描述                         |
| :----- | :--------------------------- |
| length | 设置或返回数组中元素的数量。 |

方法：

| 方法方法  | 描述                                             |
| :-------- | :----------------------------------------------- |
| forEach() | 遍历数组中的每个有值得元素，并调用一次传入的函数 |
| push()    | 将新元素添加到数组的末尾，并返回新的长度         |
| splice()  | 从数组中删除元素                                 |

- length属性：

```html
for (let index = 0; index < arr.length; index++) {
    console.log(arr[index]);
}
```

- foreach

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        var arr=[5,6,7,8];
        // foreach：遍历数组中有值的元素
        arr.forEach(function(e)
        {
            console.log(e);
        })

        // 箭头函数实现foreach
        arr.forEach((e)=>{console.log(e);})
    </script>
</body>
</html>
```

- push

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        // push 添加元素
        var arr=[5,6,7,8];
        arr.push(7,8,9);
        console.log(arr);
    </script>
</body>
</html>
```

- splice

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        // 特点：长度可变，类型可变
        var arr=[5,6,7,8];
        // splice 删除 (起始索引，个数)
        arr.splice(2,3);
        console.log(arr);
    </script>
</body>
</html>
```

##### String

String对象的创建方式有2种：

方式1：

~~~js
var 变量名 = new String("…") ; //方式一
~~~

例如：

~~~js
var str = new String("Hello String");
~~~



方式2：

~~~js
var 变量名 = "…" ; //方式二
~~~

例如：

~~~js
var str = 'Hello String';
~~~

String对象也提供了一些常用的属性和方法，如下表格所示：

属性：

| 属性   | 描述           |
| ------ | -------------- |
| length | 字符串的长度。 |

方法：

| 方法        | 描述                                     |
| ----------- | ---------------------------------------- |
| charAt()    | 返回在指定位置的字符。                   |
| indexOf()   | 检索字符串。                             |
| trim()      | 去除字符串两边的空格                     |
| substring() | 提取字符串中两个指定的索引号之间的字符。 |

- length属性：

  length属性可以用于返回字符串的长度，添加如下代码：

  ~~~js
  //length
  console.log(str.length);
  ~~~

- charAt()函数：

  charAt()函数用于返回在指定索引位置的字符，函数的参数就是索引。添加如下代码：

  ~~~js
  console.log(str.charAt(4));
  ~~~

- indexOf()函数

  indexOf()函数用于检索指定内容在字符串中的索引位置的，返回值是索引，参数是指定的内容。添加如下代码：

  ~~~js
  console.log(str.indexOf("lo"));
  ~~~

- trim()函数

  trim()函数用于去除字符串两边的空格的。添加如下代码：

  ~~~js
  var s = str.trim();
  console.log(s.length);
  ~~~

- substring()函数

  substring()函数用于截取字符串的，函数有2个参数。

  参数1：表示从那个索引位置开始截取。包含

  参数2：表示到那个索引位置结束。不包含

  ~~~js
  console.log(s.substring(0,5));
  ~~~

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        //创建字符串对象
        //var str = new String("Hello String");
        var str = "  Hello String    ";

        console.log(str);

        // charAt() 用于返回在指定索引位置的字符 
        console.log(str.charAt(3));

        // indexOf() 检索该字符位于哪个位置
        console.log(str.indexOf("t"));

        // trim 用于删除两边的空格
        var s=str.trim();
        console.log(s);

        // substring 截取子字符串（start,end）
        console.log(str.substring(2,7));

    </script>
</body>
</html>
```

##### JSON

js中的自定义对象

~~~js
var 对象名 = {
    属性名1: 属性值1, 
    属性名2: 属性值2,
    属性名3: 属性值3,
    函数名称: function(形参列表){}
};

~~~

我们可以通过如下语法调用属性：

~~~js
对象名.属性名
~~~

通过如下语法调用函数：

~~~js
对象名.函数名()
~~~

```js
<script>
    //自定义对象
    var user = {
        name: "Tom",
        age: 10,
        gender: "male",
        eat(){
             console.log("用膳~");
        }
    }

    console.log(user.name);
    user.eat();
</script>
```

**json**

JSON对象：**J**ava**S**cript **O**bject **N**otation，JavaScript对象标记法。是通过JavaScript标记法书写的文本。其格式如下：

~~~js
{
    "key":value,
    "key":value,
    "key":value
}
~~~

其中，**key必须使用引号并且是双引号标记，value可以是任意数据类型。**

**JSON字符串转为JS对象**

```js
var jsobject=JSON.parse(userstr);
```

**JS对象转为JSON字符串**

```js
var jsonstr=JSON.stringify(jsObject)
```

```js
// 定义json
var jsonStr='{"name":"tom","age":18,"addr":["北京","上海","深圳"]}';

// json字符串转为js对象
var jsObject=JSON.parse(jsonStr);

// js对象转为json字符串
JSON.stringify(jsObject);
```

#### BOM

浏览器对象模型

允许JavaScript与浏览器对话，**JavaScript将浏览器的各个组成部分封装为对象**

##### 组成

| 对象名称  | 描述           |
| :-------- | :------------- |
| Window    | 浏览器窗口对象 |
| Navigator | 浏览器对象     |
| Screen    | 屏幕对象       |
| History   | 历史记录对象   |
| Location  | d地址栏对象    |

![image-20240702165627261](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240702165627261.png)

##### window

window对象指的是浏览器窗口对象，是JavaScript的全部对象，所以对于window对象，我们可以直接使用，并且对于window对象的方法和属性，我们可以省略window.例如：我们之前学习的alert()函数其实是属于window对象的,其完整的代码如下：

~~~
window.alert('hello');
~~~

其可以省略window.  所以可以简写成

~~~
alert('hello')
~~~

所以对于window对象的属性和方法，我们都是采用简写的方式。window提供了很多属性和方法，下表列出了常用属性和方法

window对象提供了获取其他BOM对象的属性：

| 属性      | 描述                  |
| --------- | --------------------- |
| history   | 用于获取history对象   |
| location  | 用于获取location对象  |
| Navigator | 用于获取Navigator对象 |
| Screen    | 用于获取Screen对象    |

也就是说我们要使用location对象，只需要通过代码`window.location`或者简写`location`即可使用

window也提供了一些常用的函数，如下表格所示：

| 函数          | 描述                                               |
| ------------- | -------------------------------------------------- |
| alert()       | 显示带有一段消息和一个确认按钮的警告框。           |
| comfirm()     | 显示带有一段消息以及确认按钮和取消按钮的对话框。   |
| setInterval() | 按照指定的周期（以毫秒计）来调用函数或计算表达式。 |
| setTimeout()  | 在指定的毫秒数后调用函数或计算表达式。             |

```js
<script>
    // 获取
    window.alert('hello');

    // confirm 对话框 点击确认，返回true 反之false
    var flag=confirm('您确认删除么？');

    // 定时器 周期性的执行某一个函数
    var i=0;
    setInterval(function(){
        i++;
        console.log(i);
    },2000);

    // 定时器 延迟指定时间执行一次
    setTimeout(function(){
        alert('timeout')
    },3000);
</script>
```

##### location

location是指代浏览器的地址栏对象，对于这个对象，我们常用的是href属性，用于获取或者设置浏览器的地址信息

```js
// location 
// href 可以做到点击就跳转
alert(location.href);
location.href="https://www.cug.edu.cn/";
```

#### DOM

DOM：Document Object Model 文档对象模型。也就是 JavaScript 将 HTML 文档的各个组成部分封装为对象。

DOM 其实我们并不陌生，之前在学习 XML 就接触过，只不过 XML 文档中的标签需要我们写代码解析，而 HTML 文档是浏览器解析。封装的对象分为

- Document：整个文档对象
- Element：元素对象
- Attribute：属性对象
- Text：文本对象
- Comment：注释对象

如下图，左边是 HTML 文档内容，右边是 DOM 树

![image-20240702174020464](C:\Users\19736\AppData\Roaming\Typora\typora-user-images\image-20240702174020464.png)

##### DOM的作用

- 改变 HTML 元素的内容
- 改变 HTML 元素的样式（CSS）
- 对 HTML DOM 事件作出反应
- 添加和删除 HTML 元素

总而达到动态改变页面效果目的，具体我们可以查看代码中提供的

##### 获取元素的方法

| 函数                              | 描述                                     |
| --------------------------------- | ---------------------------------------- |
| document.getElementById()         | 根据id属性值获取，返回单个Element对象    |
| document.getElementsByTagName()   | 根据标签名称获取，返回Element对象数组    |
| document.getElementsByName()      | 根据name属性值获取，返回Element对象数组  |
| document.getElementsByClassName() | 根据class属性值获取，返回Element对象数组 |

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JS-对象-DOM</title>
</head>

<body>
    <img id="h1" src="./图片素材/off.gif">  <br><br>

    <div class="cls">传智教育</div>   <br>
    <div class="cls">黑马程序员</div>  <br>

    <input type="checkbox" name="hobby"> 电影
    <input type="checkbox" name="hobby"> 旅游
    <input type="checkbox" name="hobby"> 游戏
</body>

<script>
    //1. 获取Element元素

    //1.1 获取元素-根据ID获取
    // var img = document.getElementById('h1');
    // alert(img);

    //1.2 获取元素-根据标签获取 - div
    // var divs = document.getElementsByTagName('div');
    // for (let i = 0; i < divs.length; i++) {
    //     alert(divs[i]);
    // }


    //1.3 获取元素-根据name属性获取
    // var ins = document.getElementsByName('hobby');
    // for (let i = 0; i < ins.length; i++) {
    //     alert(ins[i]);
    // }


    //1.4 获取元素-根据class属性获取
    // var divs = document.getElementsByClassName('cls');
    // for (let i = 0; i < divs.length; i++) {
    //     alert(divs[i]);
    // }



    //2. 查询参考手册, 属性、方法
    var divs = document.getElementsByClassName('cls');
    var div1 = divs[0];
    
    div1.innerHTML = "传智教育666";

</script>
</html>
```

### 事件监听

#### 事件绑定

##### 方式一

通过html标签中的事件属性进行绑定

例如一个按钮，我们对于按钮可以绑定单机事件，可以借助标签的onclick属性，属性值指向一个函数。

在VS Code中创建名为09. JS-事件-事件绑定.html，添加如下代码：

~~~html
<input type="button" id="btn1" value="事件绑定1" onclick="on()">
~~~

很明显没有on函数，所以我们需要创建该函数，代码如下：

~~~html
<script>
    function on(){
        alert("按钮1被点击了...");
    }
</script>
~~~

##### 方式二

通过DOM中Element元素的事件属性进行绑定

依据我们学习过得DOM的知识点，我们知道html中的标签被加载成element对象，所以我们也可以通过element对象的属性来操作标签的属性。此时我们再次添加一个按钮，代码如下：

~~~html
<input type="button" id="btn2" value="事件绑定2">
~~~

我们可以先通过id属性获取按钮对象，然后操作对象的onclick属性来绑定事件，代码如下：

~~~js
document.getElementById('btn2').onclick = function(){
    alert("按钮2被点击了...");
}
~~~

#### 常见的事件

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JS-事件-常见事件</title>
</head>

<body onload="load()">

    <form action="" style="text-align: center;" onsubmit="subfn()">
        <input type="text" name="username" onblur="bfn()" onfocus="ffn()" onkeydown="kfn()">
        
        <input id="b1" type="submit" value="提交">

        <input id="b1" type="button" value="单击事件" onclick="fn1()">
    </form>  

    <br><br><br>

    <table width="800px" border="1" cellspacing="0" align="center" onmouseover="over()" onmouseout="out()">
        <tr>
            <th>学号</th>
            <th>姓名</th>
            <th>分数</th>
            <th>评语</th>
        </tr>
        <tr align="center">
            <td>001</td>
            <td>张三</td>
            <td>90</td>
            <td>很优秀</td>
        </tr>
        <tr align="center">
            <td>002</td>
            <td>李四</td>
            <td>92</td>
            <td>优秀</td>
        </tr>
    </table>

</body>

<script>
    //onload : 页面/元素加载完成后触发
    function load(){
        console.log("页面加载完成...")
    }

    //onclick: 鼠标点击事件
    function fn1(){
        console.log("我被点击了...");
    }

    //onblur: 失去焦点事件
    function bfn(){
        console.log("失去焦点...");
    }

    //onfocus: 元素获得焦点
    function ffn(){
        console.log("获得焦点...");
    }

    //onkeydown: 某个键盘的键被按下
    function kfn(){
        console.log("键盘被按下了...");
    }

    //onmouseover: 鼠标移动到元素之上
    function over(){
        console.log("鼠标移入了...")
    }

    //onmouseout: 鼠标移出某元素
    function out(){
        console.log("鼠标移出了...")
    }

    //onsubmit: 提交表单事件
    function subfn(){
        alert("表单被提交了...");
    }

</script>
</html>
```

#### 案例

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JS-事件-案例</title>
</head>
<body>

    <img id="light" src="./图片素材/off.gif"> <br>

    <input type="button" value="点亮" onclick="on()"> 
    <input type="button"  value="熄灭" onclick="off()">

    <br> <br>

    <input type="text" id="name" value="ITCAST" onfocus="lower()" onblur="upper()">
    <br> <br>

    <input type="checkbox" name="hobby"> 电影
    <input type="checkbox" name="hobby"> 旅游
    <input type="checkbox" name="hobby"> 游戏
    <br>

    <input type="button" value="全选" onclick="checkall()"> 
    <input type="button" value="反选" onclick="reverse()">

</body>

<script>

    //1. 点击 "点亮" 按钮, 点亮灯泡; 点击 "熄灭" 按钮, 熄灭灯泡; 
    function on(){
        var img=document.getElementById("light");
        img.src="./图片素材/on.gif";
    }
    
    function off(){
        var img=document.getElementById("light");
        img.src="./图片素材/off.gif";
    }

    //2. 输入框聚焦后, 展示小写; 输入框离焦后, 展示大写; onfocus onblur 
    function lower()
    {
        var input=document.getElementById('name');
        input.value=input.value.toLowerCase();
    }
    

    function upper()
    {
        var input=document.getElementById('name');
        input.value=input.value.toUpperCase();
    }

    //3. 点击 "全选" 按钮使所有的复选框呈现选中状态 ; 点击 "反选" 按钮使所有的复选框呈现取消勾选的状态 ; -- onclick
    function checkall()
    {
        let divs=document.getElementsByName("hobby");
        for (let index = 0; index < divs.length; index++) {
            const element = divs[index];
            element.checked=true;
        }
    }

    function reverse()
    {
        let divs=document.getElementsByName("hobby");
        for (let index = 0; index < divs.length; index++) {
            const element = divs[index];
            element.checked=false;
        }
    }


</script>
</html>
```
