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

```sh
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

项目结构是：

.
├── add

│   ├── add.c

│   └── add.h

├── CMakeLists.txt

└── main.c

需要将add目录下的源文件也要包含进来，这时CMakeLists.txt是：

```cmake
# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo3)

# 添加源文件
aux_source_directory(. DIR_SRCS)
# 将add目录下的源文件也包含进来
aux_source_directory(add DIR_SRCS)

# 头文件要包含的目录
include_directories(add)

# 指定生成目标
add_executable(demo ${DIR_SRCS})

```



### Demo4 静态库

> 对应源代码目录： [Demo4](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo4)

若只想将add函数封装成一个库，一个静态库，那么CMakeLists.txt是下面，**add_library参数是默认是STATIC**

```cmake
# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo4)

# 添加源文件
aux_source_directory(. DIR_LIB_SRCS)

# 生成静态库文件
add_library(myaddfun STATIC ${DIR_LIB_SRCS})

```

编译生成libaddfun.a文件

```sh
root@dong:/home/dong/Cmake-Tutorial/Demo4# mkdir build
root@dong:/home/dong/Cmake-Tutorial/Demo4# cd build/
root@dong:/home/dong/Cmake-Tutorial/Demo4/build# cmake ..
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
-- Build files have been written to: /home/dong/Cmake-Tutorial/Demo4/build
root@dong:/home/dong/Cmake-Tutorial/Demo4/build# make
Scanning dependencies of target myaddfun
[ 50%] Building C object CMakeFiles/myaddfun.dir/add.c.o
[100%] Linking C static library libmyaddfun.a
[100%] Built target myaddfun
root@dong:/home/dong/Cmake-Tutorial/Demo4/build# ll
总用量 44
drwxr-xr-x 3 root root  4096 3月  27 10:56 ./
drwxr-xr-x 3 root root  4096 3月  27 10:55 ../
-rw-r--r-- 1 root root 12730 3月  27 10:56 CMakeCache.txt
drwxr-xr-x 5 root root  4096 3月  27 10:56 CMakeFiles/
-rw-r--r-- 1 root root  1540 3月  27 10:56 cmake_install.cmake
-rw-r--r-- 1 root root  1700 3月  27 10:56 libmyaddfun.a
-rw-r--r-- 1 root root  4817 3月  27 10:56 Makefile
```

### Demo5 动态库

> 对应源代码目录： [Demo5](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo5)

与上述Demo4一致，需要将STATIC改成**SHARED**,CMakeLists.txt是：

```cmake
# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo4)

# 添加源文件
aux_source_directory(. DIR_LIB_SRCS)

# 生成动态库文件
add_library(myaddfun SHARED ${DIR_LIB_SRCS})
```

编译：

```sh
root@dong:/home/dong/testgit/cmtu/Cmake-Tutorial/Demo5/build# make
Scanning dependencies of target myaddfun
[ 50%] Building C object CMakeFiles/myaddfun.dir/add.c.o
[100%] Linking C shared library libmyaddfun.so
[100%] Built target myaddfun
root@dong:/home/dong/testgit/cmtu/Cmake-Tutorial/Demo5/build# ll
总用量 48
drwxr-xr-x 3 root root  4096 3月  27 11:05 ./
drwxr-xr-x 3 root root  4096 3月  27 11:04 ../
-rw-r--r-- 1 root root 12730 3月  27 11:04 CMakeCache.txt
drwxr-xr-x 5 root root  4096 3月  27 11:05 CMakeFiles/
-rw-r--r-- 1 root root  1540 3月  27 11:04 cmake_install.cmake
-rwxr-xr-x 1 root root  7896 3月  27 11:05 libmyaddfun.so*
-rw-r--r-- 1 root root  4817 3月  27 11:04 Makefile
```

### Demo6 使用静态库

> 对应源代码目录： [Demo6](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo6)

使用外部静态库，这里使用Demo4中生成的静态库，

- 需要使用**include_directories** 添加头文件
- 使用**link_directories**查找链接的目录
- 使用**target_link_libraries**链接库文件， 这里去查找libmyaddfun.a文件

CMakeList是：

```cmake
# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo6)

# 添加源文件
aux_source_directory(. DIR_SRCS)

# 包含头文件路径
include_directories(../Demo4/)

# 链接库的目录路径
link_directories(../Demo4/build)

# 指定生成目标
add_executable(demo ${DIR_SRCS})

# 需要链接库的名称
target_link_libraries(demo myaddfun)

```

编译：

```sh
root@dong:/home/dong/Cmake-Tutorial/Demo6/build# make
Scanning dependencies of target demo
[ 50%] Building C object CMakeFiles/demo.dir/main.c.o
/home/dong/Cmake-Tutorial/Demo6/main.c: In function ‘main’:
/home/dong/Cmake-Tutorial/Demo6/main.c:6:2: warning: implicit declaration of function ‘printf’ [-Wimplicit-function-declaration]
  printf("my sum is :%d\n\n", sum);
  ^~~~~~
/home/dong/Cmake-Tutorial/Demo6/main.c:6:2: warning: incompatible implicit declaration of built-in function ‘printf’
/home/dong/Cmake-Tutorial/Demo6/main.c:6:2: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’
[100%] Linking C executable demo
[100%] Built target demo
root@dong:/home/dong/Cmake-Tutorial/Demo6/build# ll
总用量 52
drwxr-xr-x 3 root root  4096 3月  27 11:10 ./
drwxr-xr-x 3 root root  4096 3月  27 11:10 ../
-rw-r--r-- 1 root root 12674 3月  27 11:10 CMakeCache.txt
drwxr-xr-x 5 root root  4096 3月  27 11:10 CMakeFiles/
-rw-r--r-- 1 root root  1540 3月  27 11:10 cmake_install.cmake
-rwxr-xr-x 1 root root  8400 3月  27 11:10 demo*
-rw-r--r-- 1 root root  4778 3月  27 11:10 Makefile

```

### Demo7 使用动态库

> 对应源代码目录： [Demo7](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo7)

与使用静态库一致，这里使用Demo5生成的动态库，CMakeLists.txt是：

```cmake
# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo7)

# 添加源文件
aux_source_directory(. DIR_SRCS)

# 包含头文件路径
include_directories(../Demo5/)

# 链接库的目录路径
link_directories(../Demo5/build)

# 指定生成目标
add_executable(demo ${DIR_SRCS})

# 需要链接库的名称
target_link_libraries(demo myaddfun)
```

### Demo8 生成库并同时使用

> 对应源代码目录： [Demo8](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo8)

项目结构是：

.
├── add

│   ├── add.c

│   ├── add.h

│   └── CMakeLists.txt

├── CMakeLists.txt

├── main.c

└── sub

​    ├── CMakeLists.txt

​    ├── sub.c

​    └── sub.h

可以在程序中生成静态库或动态库并使用，CMakeLists.txt

```cmake
# cmake最低版本要求
cmake_minimum_required (VERSION 3.10)

# 项目名称
project (Demo8)

# 包含头文件路径
include_directories(add)
include_directories(sub)

# 添加源文件
aux_source_directory(. DIR_SRCS)

# 添加add sub 子目录
add_subdirectory(add)
add_subdirectory(sub)

# 指定生成目标
add_executable(demo ${DIR_SRCS})

# 需要链接库的名称
target_link_libraries(demo myaddfun mysubfun)
```

在add和sub目录中需要写一个CMakeLists.txt生成库文件：

```cmake
aux_source_directory(. DIR_LIB_SRCS)

add_library(myaddfun STATIC ${DIR_LIB_SRCS})
```

编译：

```sh
root@dong:/home/dong/Cmake-Tutorial/Demo8# mkdir build
root@dong:/home/dong/Cmake-Tutorial/Demo8# cd build/
root@dong:/home/dong/Cmake-Tutorial/Demo8/build# cmake ..
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
-- Build files have been written to: /home/dong/Cmake-Tutorial/Demo8/build
root@dong:/home/dong/Cmake-Tutorial/Demo8/build# make
Scanning dependencies of target myaddfun
[ 16%] Building C object add/CMakeFiles/myaddfun.dir/add.c.o
[ 33%] Linking C static library libmyaddfun.a
[ 33%] Built target myaddfun
Scanning dependencies of target mysubfun
[ 50%] Building C object sub/CMakeFiles/mysubfun.dir/sub.c.o
/home/dong/Cmake-Tutorial/Demo8/sub/sub.c: In function ‘sub’:
/home/dong/Cmake-Tutorial/Demo8/sub/sub.c:5:2: warning: implicit declaration of function ‘printf’ [-Wimplicit-function-declaration]
  printf("\n it is my sub function!\n");
  ^~~~~~
/home/dong/Cmake-Tutorial/Demo8/sub/sub.c:5:2: warning: incompatible implicit declaration of built-in function ‘printf’
/home/dong/Cmake-Tutorial/Demo8/sub/sub.c:5:2: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’
[ 66%] Linking C static library libmysubfun.a
[ 66%] Built target mysubfun
Scanning dependencies of target demo
[ 83%] Building C object CMakeFiles/demo.dir/main.c.o
/home/dong/Cmake-Tutorial/Demo8/main.c: In function ‘main’:
/home/dong/Cmake-Tutorial/Demo8/main.c:8:2: warning: implicit declaration of function ‘printf’ [-Wimplicit-function-declaration]
  printf("my sum is :%d\n\n", sum);
  ^~~~~~
/home/dong/Cmake-Tutorial/Demo8/main.c:8:2: warning: incompatible implicit declaration of built-in function ‘printf’
/home/dong/Cmake-Tutorial/Demo8/main.c:8:2: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’
[100%] Linking C executable demo
[100%] Built target demo
root@dong:/home/dong/Cmake-Tutorial/Demo8/build# ll
总用量 60
drwxr-xr-x 5 root root  4096 3月  27 11:21 ./
drwxr-xr-x 5 root root  4096 3月  27 11:20 ../
drwxr-xr-x 3 root root  4096 3月  27 11:21 add/
-rw-r--r-- 1 root root 12786 3月  27 11:21 CMakeCache.txt
drwxr-xr-x 5 root root  4096 3月  27 11:21 CMakeFiles/
-rw-r--r-- 1 root root  1813 3月  27 11:21 cmake_install.cmake
-rwxr-xr-x 1 root root  8456 3月  27 11:21 demo*
-rw-r--r-- 1 root root  5616 3月  27 11:21 Makefile
drwxr-xr-x 3 root root  4096 3月  27 11:21 sub/
```

在这个目录下的add和sub下生成静态库文件：

```sh
root@dong:/home/dong/testgit/cmtu/Cmake-Tutorial/Demo8/build# ll add/ sub/
add/:
总用量 28
drwxr-xr-x 3 root root 4096 3月  27 11:21 ./
drwxr-xr-x 5 root root 4096 3月  27 11:21 ../
drwxr-xr-x 3 root root 4096 3月  27 11:21 CMakeFiles/
-rw-r--r-- 1 root root 1138 3月  27 11:21 cmake_install.cmake
-rw-r--r-- 1 root root 1700 3月  27 11:21 libmyaddfun.a
-rw-r--r-- 1 root root 5578 3月  27 11:21 Makefile

sub/:
总用量 28
drwxr-xr-x 3 root root 4096 3月  27 11:21 ./
drwxr-xr-x 5 root root 4096 3月  27 11:21 ../
drwxr-xr-x 3 root root 4096 3月  27 11:21 CMakeFiles/
-rw-r--r-- 1 root root 1138 3月  27 11:21 cmake_install.cmake
-rw-r--r-- 1 root root 1700 3月  27 11:21 libmysubfun.a
-rw-r--r-- 1 root root 5578 3月  27 11:21 Makefile
```



### Demo_install 程序安装

> 对应源代码目录： [Demo_install](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo_install)

CMake 也可以指定安装规则，以及添加测试。这两个功能分别可以通过在产生 Makefile 后使用 `make install` 来执行

在add/CMakeLists.txt和sub/CMakeLists.txt添加下面：

```cmake
# 指定 add 库的安装路径
install (TARGETS myaddfun DESTINATION lib)
install (FILES add.h DESTINATION include)
```

指明myaddfun和mysubfun库的安装路径 。之后修改根目录下的CMakeLists.txt，添加下面的：

```cmake
# 指定安装路径
install (TARGETS demo DESTINATION bin)
```

通过上述的修改，生成的demo文件和add,sub函数库文件libmyaddfun.o，libmysubfun.o被复制到**/usr/local/bin**下，对应的add.h和sub.h会复制到/usr/local/include下（这里的 `/usr/local/` 是默认安装到的根目录，可以通过修改 `CMAKE_INSTALL_PREFIX` 变量的值来指定这些文件应该拷贝到哪个根目录）

```sh
root@dong:/home/dong/Cmake-Tutorial/Demo_install/build# make
Scanning dependencies of target mysubfun
[ 16%] Building C object sub/CMakeFiles/mysubfun.dir/sub.c.o
/home/dong/Cmake-Tutorial/Demo_install/sub/sub.c: In function ‘sub’:
/home/dong/Cmake-Tutorial/Demo_install/sub/sub.c:5:2: warning: implicit declaration of function ‘printf’ [-Wimplicit-function-declaration]
  printf("\n it is my sub function!\n");
  ^~~~~~
/home/dong/Cmake-Tutorial/Demo_install/sub/sub.c:5:2: warning: incompatible implicit declaration of built-in function ‘printf’
/home/dong/Cmake-Tutorial/Demo_install/sub/sub.c:5:2: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’
[ 33%] Linking C static library libmysubfun.a
[ 33%] Built target mysubfun
Scanning dependencies of target myaddfun
[ 50%] Building C object add/CMakeFiles/myaddfun.dir/add.c.o
[ 66%] Linking C static library libmyaddfun.a
[ 66%] Built target myaddfun
Scanning dependencies of target demo
[ 83%] Building C object CMakeFiles/demo.dir/main.c.o
/home/dong/Cmake-Tutorial/Demo_install/main.c: In function ‘main’:
/home/dong/Cmake-Tutorial/Demo_install/main.c:8:2: warning: implicit declaration of function ‘printf’ [-Wimplicit-function-declaration]
  printf("my sum is :%d\n\n", sum);
  ^~~~~~
/home/dong/Cmake-Tutorial/Demo_install/main.c:8:2: warning: incompatible implicit declaration of built-in function ‘printf’
/home/dong/Cmake-Tutorial/Demo_install/main.c:8:2: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’
[100%] Linking C executable demo
[100%] Built target demo
root@dong:/home/dong/Cmake-Tutorial/Demo_install/build# make install
[ 33%] Built target mysubfun
[ 66%] Built target myaddfun
[100%] Built target demo
Install the project...
-- Install configuration: ""
-- Installing: /usr/local/bin/demo
-- Installing: /usr/local/lib/libmyaddfun.a
-- Installing: /usr/local/include/add.h
-- Installing: /usr/local/lib/libmysubfun.a
-- Installing: /usr/local/include/sub.h
```

安装好后，执行`demo`：

```sh
root@dong:/home/dong/Cmake-Tutorial/Demo_install# demo 

it is my add function!

 it is my sub function!
my sum is :3

my sub is :7
```



### Demode_pack 程序打包

> 对应源代码目录： [Demo_pack](https://github.com/wodingdong/Cmake-Tutorial/tree/main/Demo_pack)

配置生成各种平台上的安装包，包括二进制安装包和源码安装包。为了完成这个任务，我们需要用到 CPack ，它同样也是由 CMake 提供的一个工具，专门用于打包.

首先在根目录的CMakeLists.txt添加下述：

```cmake
# 构建一个 CPack 安装包
include (InstallRequiredSystemLibraries)
set (CPACK_RESOURCE_FILE_LICENSE
  "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")

include (CPack)
```

后面是上述demo一样编译构建，执行`cpack`命令

- 生成二进制安装包：

  ```
  cpack -C CPackConfig.cmake
  ```

- 生成源码安装包

  ```
  cpack -C CPackSourceConfig.cmake
  ```

  执行一下：

  ```sh
  root@dong:/home/dong/Cmake-Tutorial/Demo_pack/build# cpack -C CPackConfig.cmake 
  CPack: Create package using STGZ
  CPack: Install projects
  CPack: - Run preinstall target for: DemoPack
  CPack: - Install project: DemoPack
  CPack: Create package
  CPack: - package: /home/dong/Cmake-Tutorial/Demo_pack/build/DemoPack-0.1.1-Linux.sh generated.
  CPack: Create package using TGZ
  CPack: Install projects
  CPack: - Run preinstall target for: DemoPack
  CPack: - Install project: DemoPack
  CPack: Create package
  CPack: - package: /home/dong/Cmake-Tutorial/Demo_pack/build/DemoPack-0.1.1-Linux.tar.gz generated.
  CPack: Create package using TZ
  CPack: Install projects
  CPack: - Run preinstall target for: DemoPack
  CPack: - Install project: DemoPack
  CPack: Create package
  CPack: - package: /home/dong/Cmake-Tutorial/Demo_pack/build/DemoPack-0.1.1-Linux.tar.Z generated.
  
  ```

  这里在该目录下生成3个不同格式的二进制包文件：

  ```sh
  root@dong:/home/dong/Cmake-Tutorial/Demo_pack/build# ll DemoPack-0.1.1-Linux.
  DemoPack-0.1.1-Linux.sh      DemoPack-0.1.1-Linux.tar.Z
  DemoPack-0.1.1-Linux.tar.gz 
  ```

  这 3 个二进制包文件所包含的内容是完全相同的。我们可以执行其中一个。此时会出现一个由 CPack 自动生成的交互式安装界面:

  ```sh
  root@dong:/home/dong/Cmake-Tutorial/Demo_pack/build# sh DemoPack-0.1.1-Linux.sh 
  DemoPack Installer Version: 0.1.1, Copyright (c) Humanity
  This is a self-extracting archive.
  The archive will be extracted to: /home/dong/Cmake-Tutorial/Demo_pack/build
  
  If you want to stop extracting, please press <ctrl-C>.
  It is a test how to genarate a pack
  The MIT License (MIT)
  
  Copyright (c) 2021 wodingdong
  
  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies o
  f
  the Software, and to permit persons to whom the Software is furnished to do so,
  subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNES
  S
  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  
  
  Do you accept the license? [yN]: 
  y
  By default the DemoPack will be installed in:
    "/home/dong/Cmake-Tutorial/Demo_pack/build/DemoPack-0.1.1-Linux"
  Do you want to include the subdirectory DemoPack-0.1.1-Linux?
  Saying no will install in: "/home/dong/Cmake-Tutorial/Demo_pack/build" [Yn]: 
  y
  
  Using target directory: /home/dong/Cmake-Tutorial/Demo_pack/build/DemoPack-0.1.1-Linux
  Extracting, please wait...
  
  Unpacking finished successfully
  ```

  安装到目录后，执行：

  ```
  root@dong:/home/dong/Cmake-Tutorial/Demo_pack/build# ./DemoPack-0.1.1-Linux/bin/demo 
  
  it is my add function!
  
   it is my sub function!
  my sum is :3
  
  my sub is :7
  ```

  ### 最后

  可以执行`auto_compile_run.sh`和`auto_clean.py`去一键生成Demo1-8的程序:

  ```
  root@dong:/home/dong/Cmake-Tutorial# sh auto_compile_run.sh 
  ************ + Demo1 + result**********
  
  it is my add function!
  my sum is :3
  
  ************ + Demo2 + result**********
  
  it is my add function!
  my sum is :3
  
  ************ + Demo3 + result**********
  
  it is my add function!
  my sum is :3
  
  -- Configuring done
  -- Generating done
  -- Build files have been written to: /home/dong/Cmake-Tutorial/Demo4/build
  [100%] Built target myaddfun
  ************ + Demo4 + result**********
  -- Configuring done
  -- Generating done
  -- Build files have been written to: /home/dong/Cmake-Tutorial/Demo5/build
  [100%] Built target myaddfun
  ************ + Demo5 + result**********
  ************ + Demo6 + result**********
  
  it is my add function!
  my sum is :3
  
  ************ + Demo7 + result**********
  
  it is my add function!
  my sum is :3
  
  ************ + Demo8 + result**********
  
  it is my add function!
  
   it is my sub function!
  my sum is :3
  
  my sub is :7
  ```

  

### 相关链接

- [官方网站](http://www.cmake.org/ )
- [官方文档](https://www.hahack.com/codes/cmake/)
- [官方教程](https://cmake.org/cmake-tutorial)
- [hahack](https://www.hahack.com/codes/cmake/)



