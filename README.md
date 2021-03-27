# Tutorial

> The CMake tutorial provides a step-by-step guide that covers common build system issues that CMake helps address. Seeing how various topics all work together in an example project can be very helpful. The tutorial documentation and source code for examples can be found in the `Help/guide/tutorial` directory of the CMake source code tree. Each step has its own subdirectory containing code that may be used as a starting point. The tutorial examples are progressive so that each step provides the complete solution for the previous step.



### Demo1 单个文件

> 对应源代码目录： [Demo1](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo1)

简单的项目，几行代码就可以，如一个最简单的相加程序。

```c
#include <stdio.h>

int add(int a, int b)
{
	printf("\nit is my add function!\n");
	return a+b;
}

int main()
{
	int sum = add(1, 2);
	printf("my sum is :%d\n\n", sum);	
	return 0;
}

```

编写CMakeLists.txt文件，保存在与main.c同一目录下。

```cmake
# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo1)

# 指定生成目标
add_executable(demo main.c)

```

CMakeLists.txt的语法比较简单，由命令、注释和空格组成。注意

1. 命令区别大小写
2.  ‘#’ 后是注释

上述的几个命令：

1. **cmake_minimum_required**： 指定运行此配置文件所需的 CMake 的最低版本；
2. **project** :参数值是 `Demo1`，该命令表示项目的名称是 `Demo1`
3. **add_executable**: 将[main.c](https://github.com/wodingdong/Cmake-Tutorial/blob/main/Demo1/main.c)编译成一个名为demo的可执行文件。

编译项目，建议在当前目录新建一个目录，将编译后的文件放在该目录，不与源文件混在一起。编译后得到demo的可执行文件。

```
root@dong:/home/dong/Cmake-Tutorial/Demo1# mkdir build
root@dong:/home/dong/Cmake-Tutorial/Demo1# cd build/
root@dong:/home/dong/Cmake-Tutorial/Demo1/build# cmake ..
-- The C compiler identification is GNU 7.5.0
-- The CXX compiler identification is GNU 7.5.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /home/dong/testgit/cmtu/Cmake-Tutorial/Demo1/build
root@dong:/home/dong/Cmake-Tutorial/Demo1/build# ll
总用量 40
drwxr-xr-x 3 root root  4096 3月  27 10:34 ./
drwxr-xr-x 3 root root  4096 3月  27 10:34 ../
-rw-r--r-- 1 root root 12674 3月  27 10:34 CMakeCache.txt
drwxr-xr-x 5 root root  4096 3月  27 10:34 CMakeFiles/
-rw-r--r-- 1 root root  1540 3月  27 10:34 cmake_install.cmake
-rw-r--r-- 1 root root  4778 3月  27 10:34 Makefile
root@dong:/home/dong/Cmake-Tutorial/Demo1/build# make
Scanning dependencies of target demo
[ 50%] Building C object CMakeFiles/demo.dir/main.c.o
[100%] Linking C executable demo
[100%] Built target demo
root@dong:/home/dong/Cmake-Tutorial/Demo1/build# ./demo 

it is my add function!
my sum is :3

```



### Demo2 多个文件

> 对应源代码目录： [Demo2](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo2)

目录结构是

.
├── add.c
├── add.h
├── CMakeLists.txt
└── main.c

 这时，对应的CMakeLists.txt是：

```cmake
# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo2)

# first 第一种添加源文件的方式
add_executable(demo add.h add.c main.c)
```

但是要是源文件比较多的时候，一个个添加太麻烦，更好的方法是使用 **aux_source_directory**,该命令会查找指定目录下的所有源文件，然后将结果存进指定变量名，可以多次添加，因些修改的CMakeLists.txt是：

```cmake
# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo2)

# first 第一种添加源文件的方式
#add_executable(demo add.h add.c main.c)

# second 第二种添加源文件的方式，推荐这种
aux_source_directory(. DIR_SRCS)

# 指定生成目标
add_executable(demo ${DIR_SRCS})
```

后面的编译与上述一致。

### Demo3 多个目录和文件

> 对应源代码目录： [Demo3](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo3)

### Demo4 静态库

> 对应源代码目录： [Demo4](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo4)

### Demo5 动态库

> 对应源代码目录： [Demo5](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo5)

### Demo6 使用静态库

> 对应源代码目录： [Demo6](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo6)

### Demo7 使用动态库

> 对应源代码目录： [Demo7](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo7)

### Demo8 生成库并同时使用

> 对应源代码目录： [Demo8](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo8)

### Demo_install 程序安装

> 对应源代码目录： [Demo_install](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo_install)

### Demode_pack 程序打包

> 对应源代码目录： [Demo_pack](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo_pack)

### 相关链接

- [官方网站](http://www.cmake.org/ )
- [官方文档](https://www.hahack.com/codes/cmake/)
- [官方教程](https://cmake.org/cmake-tutorial)
- [hahack](https://www.hahack.com/codes/cmake/)



