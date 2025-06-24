# 基础

1.  强数据类型，不同类型不可赋值。
2.  范围
    - RANGE n1 (DOWN)TO n2
    - (n1 (DOWN)TO n2)
    - var’RANGE
3.  注释--
4.  实体
    - ENTITY name IS  
        （可选）GENERIC(name1,…:datatype:=initial_value;  
        name2:datatype:=initial_value  
        );  
        （可选）PORT(name1,…:direction datatype;  
        name2:direction datatype  
        );  
        END ENTITY name;
    - 类属参数说明：端口宽度、器件延时等参数。必须在端口说明前。编译时赋新值，仿真和综合时只读。不同类型的参数要分行写。可以在作为元件调用时GENERIC MAP再定义。
    - 端口说明：端口方向：IN OUT INOUT BUFFER LINKAGE（任意方向）
5.  构造体
    - ARCHITECTURE name OF entity_name IS  
        （可选）声明（信号、常数、数据类型、函数的定义）  
        BEGIN  
        并行处理语句;  
        END name;
    - 构造体名不可与实体名重复
    - 并行处理语句：行为级、RTL、结构级

# 类型

1.  标识符
    - 基本标识符：字母数字下划线；字母开头末尾不是下划线；不分大小写
    - 扩展标识符：\\XXX\\可使用所有字符；表示反斜杠就用2个；分大小写
2.  数据对象：可被赋值的对象

- 信号：表示电路连线，全局量，在实体、构造体、程序包声明，为子程序的信息通道
    - - SIGNAL name : datatype 范围 :=initial_type ;
        - 范围和数据类型相同可不要约束条件；声明信号同时赋初值，仅在仿真有效。  
            范围要求有range的那个形式
        - 赋值：name<= TRANSPORT/INERTIAL expression AFTER time ;
            - 新事项：赋值语句被执行
            - 传播延时：导线延时  
                信号被多次赋值，顺序执行。信号驱动器按更新时间先后保持多个事件。新事件要么按更新时间顺序插入序列，要么替换更新时间相同的旧事件（如果有这样的旧事件）并删除序列后面所有事件。
            - 惯性延时：元件延时，指定时间信号保持才有效，模拟电容滤脉冲，电路上为节点电压或晶体管状态。默认惯性延时。  
                只能保持一个事件。旧事件被新事件替换，除非两者值相同且旧事件更新在前。
            - Δ延时：默认存在，如：a<=3; b<=a+4; b用的是之前的a不是新的a<=3
            - 信号赋值的合并：用逗号相连整个<=右边部分，分号改逗号
- 变量：无实际对应，局部量，在进程、子程序使用
- VARIABLE name : datatype 范围 :=initial_value ;
- 赋值:=（立即赋值符号）没有延时立即生效
- 常量：全局量，用于固定的数据位宽、固定电平、固定延时，在实体、构造体、程序包、进程、子程序声明。
- CONSTANT name : datatype 范围 :=initial_value ;

1.  标准数据类型
    - 列举
        - BIT（’0’、’1’） BIT_VECTOR↓
        - INTEGER NATURAL POSITIVE（-1） REAL（）
        - BOOLEAN CHARACTER STRING TIME（fs ps ns us ms sec min hr）
        - SEVERITY LEVEL（NOTE WARNING ERROR FAILURE）用于系统调试
    - BIT_VECTOR数组，表示数据总线。
        - 从左往右设置序号，从0开始：BIT_VECTOR(n1 DOWNTO n2)  
            BIT_VECTOR(n1 TO n2)
        - 赋值：B、O、X后加位矢量：B”1010”；默认为B  
            可用科学计数法：1.3E4  
            基数表示：基数#数字#指数，指数：En（n为数）同上，可以省略但#不省
        - 角标：部分赋值：inst(4) inst(n1 DOWNTO n2) inst(n1 TO n2)
        - 数字间可加下划线分隔
    - INTEGER不能进行位操作和逻辑操作
    - BOOLEAN只能关系运算不能算术运算
    - CHARACTER用’ ’，包括字母（分大小写）、数字、符号。STRING用””。
    - TIME整数+空格+单位
2.  用户自定义数据类型
    - TYPE name IS datatype;还有存取、文件、时间类型等
    - 枚举类型：TYPE name IS (n1,n2…);  
        STD_LOGIC_1164下STD_LOGIC类型：  
        _‘U’初始 ‘Z’高阻 ‘X’不定 ‘W’弱不定 ‘-’无关  
        ‘0’强 ‘1’强 ‘L’弱 ‘H’弱  
        _还有STD_LOGIC_VECTOR类型
    - 数组类型（成员类型相同）：TYPE name IS ARRAY 范围 OF datatype；
        - 不定范围：(NATURAL RANGE <>)自然数个元素
        - (INTEGER RANGE 0 TO 1)=(0 TO 1)：  
            INTEGER类型限定范围可省INTEGER，但若要标明INTEGER就要有RANGE。
        - 多维数组范围：（0 TO 3,0 TO 1）
        - 访问操作可以整体（直接变量名），可以用下标（多维的用逗号隔开）
    - 记录类型（成员类型不同）：  
        TYPE name IS RECORD  
        name1:datatype;  
        …  
        END RECORD;
        - 访问可以整体可以成员（用.分隔）
3.  用户自定义子类型
    - 给已定义类型加范围限制方便程序阅读、编写、调试。  
        SUBTYPE name IS datatype 范围 ;
4.  数据类型转换
    - STD_LOGIC_1164程序包（BIT和logic）：  
        TO_STDLOGICVECTOR(d) TO_BITVECTOR(d)  
        TO_STDLOGIC(d) TO_BIT(d)
    - STD_LOGIC_ARITH程序包（INTEGER UNSIGNED SIGNED和logic）  
        CONV_STD_LOGIC_VECTOR(d)  
        CONV_INTEGER(d)没logic_vector
    - STD_LOGIC_UNSIGNED程序包  
        CONV_INTEGER(d) d为STD_LOGIC_VECTOR。
5.  操作
    - 逻辑运算：NOT（优先级最高） AND OR NAND NOR XOR。运算符左右两边和结果数据类型要相同，预定义包STANDARD包只能对BIT型运算。
    - VHDL没有左右优先级差别，就是说语法认为先算前面的还是后面的都一样，但是事实上有区别，所以会报错。记得加括号。如果表达式只有AND、OR、XOR运算符可以不加括号。（NOT有优先级有时可以无括号）
    - 算术运算：MOD求模（商向-∞靠近）；  
        REM（remain）求余（商向0靠近）；  
        \*\*指数；ABS绝对值  
        STANDARD包只对整数运算，加别的包操作数的位长不同也会语法错。
    - 能够真正综合的只有+ - \*；  
        \*对于多位数据会产生大量门，/ MOD REM的分母是2的幂时也可被综合。
    - 关系运算：/=不等于。操作数数据类型要相同，位长可不同，此时左边对齐从左到右比较
    - 并置运算：&或 , 连接。从左到右连接。  
        令c(5)=c(4)=’0’,c(3)=b(1),c(2)=b(0),c(1)=’1’,c(0)=a：  
        c<=(‘0’,’0’,’1’,b,a);  
        c<=’0’&’0’&b&’1’&a;  
        c&lt;=(5=&gt;’0’,4=>’0’,3=>b(1),2=>b(0),1=>’1’,0=>a);  
        使用OTHERS赋值，OTHERS只能在最后  
        c&lt;=(5 DOWNTO 4=&gt;’0’,3=>b(1),2=>b(0),0=>a,  
        OTHERS=>’1’);

# 语句

1.  信号赋值语句
    - 一般信号赋值语句：进程、子程序中就是顺序赋值语句，并发结构中就是并行赋值语句。  
        3者只有一般信号赋值语句用于顺序。
    - 条件信号赋值：并发  
        signal_name<=expr1 time_delay WHEN if_expr1 ELSE  
        …  
        expr2 time_delay;
    - 选择信号赋值：并发  
        WITH expr SELECT  
        signal_name<=expr1 time_delay WHEN if_expr1,  
        …  
        expr2 time_delay WHEN OTHERS;  
        expr要是一个具体的信号或变量（不是如a1&a2&a3的形式）
2.  进程
    - 内容是一般信号赋值语句或顺序描述语句。
    - 敏感信号列表：（不可用WAIT语句）  
        label:PROCESS(signal_list)  
        说明;  
        BEGIN  
        顺序语句块;  
        END PROCESS label;
        - 前面有进程标号，后面就要有。  
            说明是此进程内有效的数据类型、子程序、变量等。  
            敏感信号列表信号间,间隔。
        - 初始化执行一遍挂起等待，列表任意信号事件发生激活执行并挂起。
    - WAIT语句：顺序执行语句，在进程的顺序语句块内。初始化执行一次进程到wait语句挂起，激活后继续循环到wait语句挂起等待。  
        PROCESS后不可用括号列表。
        - WAIT ON signal_list;
        - WAIT UNTIL if_expr;
        - WAIT FOR time_expr;
        - WAIT;无限等待，不被激活。
        - 组合使用：WAIT ON a FOR 50ns;  
            可以有多个WAIT语句。
    - 隐式进程：构造体内每一个并发信号赋值语句和元件调用语句。敏感信号是赋值表达式或端口映射中所有信号。
3.  进程执行
    - 零延时事件：构造体可以没有进程，若有多个进程则并发执行，用信号传递完成进程之间通信。进程内语句顺序执行（仿真时钟上激活在同一时刻，此时仿真时间停留），全部执行完开始算延时时间再更新信号（仿真时钟上看非常短），完成一个仿真周期，再继续。
    - 传播延时事件：进程激活执行时信号每次赋值都作为事件再信号驱动器排队，在更新信号之前完成排队、冲洗（新事件冲洗旧事件）。
    - 惯性延时事件：同上类似。
4.  顺序描述语句
    - 顺序赋值语句（一般信号赋值语句、变量赋值语句）、顺序控制语句。
    - 可用来对系统时序控制、条件分支、迭代算法行为描述，也可以算术运算、逻辑运算、信号和变量的赋值、子程序的调用等。
    - 顺序控制语句只能在进程和子程序存在，包括WAIT IF CASE LOOP
    - 双重语句（可顺序可并发）包括一般信号赋值语句、断言语句、子程序调用。
    - IF语句：
        - IF bool_expr1 THEN  
            顺序语句;  
            ELSIF bool_expr2 THEN  
            顺序语句;  
            …  
            ELSE  
            顺序语句;  
            END IF;
        - IF语句是带有优先级顺序的顺序执行语句，顺序不可颠倒  
            顺序语句块可以有多条语句  
            \=条件信号赋值语句
    - CASE语句：
        - CASE 条件表达式 IS  
            WHEN 条件1 => 顺序语句;  
            …  
            WHEN OTHERS=> 顺序语句;  
            END CASE;
        - CASE语句同时判断  
            顺序语句块可以有多条语句  
            \=选择信号赋值语句  
            多个条件使用一个顺序语句，条件之间用 | 连接。条件是整数类型可以用n1 TO n2的形式。
    - FOR LOOP：
        - label:  
            FOR for_variable IN range LOOP  
            顺序语句;  
            END LOOP label;
        - 循环变量不用声明直接使用，默认是整数。  
            在循环体内只可读。范围为离散值  
            range要求：for i in 1 to 5 loop
    - WHILE LOOP：  
        label:  
        WHILE 条件 LOOP  
        顺序语句;  
        END LOOP label;
    - LOOP：  
        label: LOOP  
        顺序语句;  
        END LOOP label;
    - 循环控制语句：
        - EXIT（相当于break） NEXT（相当于continue）
        - EXIT label;  
            EXIT label WHEN 条件;
        - NEXT语法同上。未指定标号退出当前循环，指定标号直接跳出对应循环  
            EXIT在所有循环语句中使用。
5.  子程序
    - 顺序子结构，可被多次调用，不能递归调用（非重入），被调用时会初始化，子程序的值不能保持。可用在顺序子结构、构造体、块。
    - 函数：输入若干输出一个。
        - 函数声明可选。（包的子程序声明部分）  
            FUNCTION name (argu_list) RETURN datatype;  
            参数列表必须IN类型，IN可省略，只需说明参数名、参数类型（信号/常量不要变量，默认信号？）、数据类型。
        - 函数体：（包体内）  
            FUNCTION name (argu_list) RETURN datatype IS  
            说明  
            BEGIN  
            顺序语句  
            END name;
        - 说明定义函数内部所需变量，函数体内RETURN返回函数值并结束函数执行。
    - 过程：用输入输出参数完成
        - 声明可选。  
            PROCEDURE name (argu_list);  
            参数列表说明参数类型（信号、变量、常量，默认变量）、数据类型、方向（IN/OUT/INOUT，默认IN）
        - 过程体：  
            PROCEDURE name (argu_list) IS  
            说明  
            BEGIN  
            顺序语句  
            END name;
        - RETURN可用于结束过程。
6.  块
    - 并发子结构，执行过程与顺序无关。用于构造体的结构化描述。
    - Label:BLOCK  
        说明  
        BEGIN  
        并发处理语句  
        END BLOCK label;
    - 说明用于信号的映射和参数的定义，通过GENERIC、GENERIC MAP、PORT、PORT MAP实现。  
        说明的项目：USE语句、子程序说明和子程序体、类型、常数、信号、元件说明。
7.  断言
    - 监测电路模型是否正常工作，输出信息警告。
    - ASSERT if_expr REPORT err_info SEVERTY level;  
        条件表达式是正常工作条件，判真就跳过。错误信息是将输出的字符串。错误级别是NOTE WARNING ERROR FAILURE。
8.  元件
    - 层次化调用，用实体创造实例。各元件实例之间用信号连接。元件实例调用语句在构造体内并行。  
        一般元件是库中已编译、验证的设计单元。
    - 声明：只能在当前设计单元的构造体说明部分声明  
        COMPONENT component_name IS  
        类属参数声明  
        端口外观声明  
        END COMPONENT;  
        元件的声明要和对应实体完全一致（参数、端口的类型、名称），实体没有类属参数声明则元件也不要有。
    - 调用：成为实例  
        instance_name:component_name  
        GENERIC MAP (argu_mapping);  
        PORT MAP(port_mapping);  
        若元件没有类属参数则省略类属参数映射。整个声明只要一个分号。  
        映射：位置映射（按照循序一一对应）；名称映射(in2=>b,…,in1=>a);
    - 元件配置：配置语句为元件选择不同构造体/已有配置（实体和构造体的）  
        CONFIGURATION config_name OF entity_name IS  
        FOR art_name（主调实体-构造体信息）  
        \------------  
        FOR instance_name:component_name  
        USE CONFIGURATION lib_name.conf_name;--构造体  
        END FOR;  
        或：  
        FOR instance_name:component_name  
        USE ENTITY lib_name.entity_name(art_name);--实体  
        END FOR;  
        \------------（调用元件-构造体/配置信息）  
        END FOR; （主调实体-构造体信息）  
        END config_name;  
        instance_name可以是OTHERS、ALL代替。
9.  生成
    - 一般用于同类元件组成的阵列。GENERATE语句是并发语句，只能出现在构造体、并发子结构。体内一般是调用生成元件，端口映射一般是信号数组，可以换循环变量以改变信号名。
    - FOR-GENERATE:  
        label:FOR for_variable IN range GENERATE  
        并发处理语句;  
        END GENERATE label;  
        循环变量不用定义，体内只可读，只能是并发语句。必须有标号。
    - IF-GENERATE:  
        label:IF bool_expr GENERATE  
        并发处理语句;  
        END GENERATE label;  
        语句自身和体内语句都是并发语句。没有else！

# 设计共享

1.  程序包
    - 结构单元，包括公共/基本数据类型、变量、常量、信号、子程序、元件说明。包头：声明↑；包体：子程序描述。包头没有声明子程序就不用包体。
    - 包头：  
        PACKAGE name IS  
        类型声明;  
        子程序声明;  
        END name;
    - 包体：  
        PACKAGE BODY name IS  
        子程序描述;  
        END name;
2.  库
    - 编译后的程序集合。可有多个包。参考库声明一般在程序最前面。可以参考多个库，但库不能嵌套。
    - 声明：LIBRARY name;
    - IEEE库：
        - STD_LOGIC_1164 包括STD_LOGIC数据类型、子程序
        - STD_LOGIC_ARITH
        - STD_LOGIC_SIGNED 必须同时调用ARITH包
        - STD_LOGIC_UNSIGNED
    - STD库：预定义库，不用LIBRARY也不用USE
        - STANDARD包：数据类型BIT BOOLEAN INTEGER REAL TIME和子程序
        - TEXTIO包：ASCII文件的文件类型、子程序
    - WORK库：project下所有设计单元
3.  USE语句
    - 指定需要的包中条目可用，要先声明库使库可见。
    - USE lib_name.pack_name.item_name;  
        USE lib_name.pack_name.ALL;
4.  范围
    - 紧随其后的设计单元的实体-配置；紧随其后的包头-包体

# 仿真、组合逻辑

1.  仿真
    - 行为仿真：未综合的文件
    - 功能仿真：已综合未布线，不考虑实际延迟，门级仿真
    - 时序仿真：综合后指定FPGA型号仿真
    - 仿真激励：testbench，所有数字系统都要先初始化——使能置0，清除置1，延时一段时间再开始。初始化就是用外部引脚控制的。
2.  穷举
    - process内设变量&连接联系case语句
    - process外构造体内信号&连接联系case语句
    - if语句控制使能、优先级
3.  ROM
    1.  architecture声明：  
        SUBTYPE word IS STD_LOGIC_VECTOR(k-1 DOWNTO 0);--k位  
        TYPE memory IS ARRAY (0 TO n) OF word;--n个字  
        FILE **romin**:TEXT IS IN “rom_n_k.in”;
    2.  process声明：  
        VARIABLE rom:memory;  
        VARIABLE startup:BOOLEAN:=TRUE;  
        VARIABLE l:LINE;
    3.  初始化：  
        IF startup THEN  
        FOR j IN 0 TO n LOOP  
        READLINE(**romin**,l);--读行到l  
        READ(l,rom(j));  
        END LOOP;  
        startup:=FALSE;  
        END IF;
    4.  使用：  
        rom(CONV_INTEGER(adr))<=…;--作数组索引要integer型  
        

# 时序逻辑

1.  时钟为敏感量
    - PROCESS(clk)…IF…
    - WAIT UNTIL clk=’1’;
    - WAIT ON clk UNTIL clk=’1’;
    - WAIT UNTIL clk’EVENT AND clk=’1’;
2.  时钟边沿
    - 关系表达式  
        ①clk’EVENT  
        ②clk=’1’/’0’;  
        ③clk’LAST_VALUE=’0’/’1’;  
        ④RISING_EDGE(clk)/FALLING_EDGE(clk)
    - 方式：PROCESS(clk)—IF或PROCESS—WAIT UNTIL
        - IF①②/ IF①②③/IF④；
        - WAIT UNTIL②/ WAIT UNTIL①②；
3.  时钟
    - 同步复位：IF时钟边沿，嵌套：IF复位，ELSE…
    - 异步复位：IF复位，ELSIF时钟边沿…
    - 同步使能：IF时钟边沿，IF使能…
4.  D触发器：综合常用D触发器加组合逻辑构成
5.  T触发器：等效D触发器Q’连D
6.  RS触发器：NOR/NAND-RTL连接
7.  寄存器
    - 行为级-用内部信号描述，另一个process连接内外信号。
    - 锁存寄存器：并入并出
    - 移位寄存器：
        - 串入串出：D触发器的d、q相连。移位行为级描述：  
            process内：a(5)<=din;a(4 downto 0)<=a(5 downto 1);  
            process外：dout<=a(0);
        - 串入并出：D触发器d、q相连，输出总线连各个q
8.  计数器
    - 同步计数器：clk相同，en级联进位
    - 异步（行波）计数器：en相同，clk级联进位
        - 布置时左→右—低位→高位。
        - n个触发器要n+1个内部信号。
        - 每个D触发器的d连自己的qn（T触发器），clk连前一个qn（行波）。
9.  分频器
    - 代码决定初始状态不稳定，从后面稳定的才能对齐到0状态
    - n分频就是翻转次数/n。上升沿计数n/2次（=n次翻转）输出翻转1次
    - 2<sup>n</sup>分频直接用计数器信号的各个位（bit\[n\]- 2<sup>n+1</sup>分频）
    - 偶数分频（10分频为例）
        - 上升沿计数，占空比1/2，因为一个count周期只翻转一次
        - range 1 to 5表示计数count=2,3,4,5,1（可以用到5）（此时才翻转）
        - 写法：if count=5: count=1;clk_out翻转;else count++;
    - 奇数分频占空比（5分频为例）
        - 上升沿计数，占空比为x/5，x为整数，因为一个count周期翻转2次
        - if count=4: count=0;else count++;  
            if count<3:freq=’1’;else freq=’0’;  
            注意先后顺序，freq的process受count驱动
        - count:0,1,2,3,4；freq在count=0,1,2时高，占空比=3/5
        - 可以覆盖偶数分频方法：1/2=5/10（10分频为例）
    - 奇数分频占空比1/2：用两个process计两个counter各记录上升沿和下降沿，两个counter连接产生一个序列，小于特定值就翻转即可。
    - 用unsigned包就可以对std_logic_vector做加法
10. 序列信号产生器
    - 计数器+数据选择器
    - 移位寄存器（数组在移位）
11. 序列信号检测器
    - 状态机  
        case q(0,1,2,…)if din=…(from q=…) then q++ else q=0  
        最后一位q用组合逻辑输出，另起process
    - 移位寄存器：输出同上，输入在数组后移位

# 状态机

1.  两个定义
    - 状态枚举
        - Type main_state is(state_1,…);
        - Constant state_1:std_logic_vector(2 downto 0):=  
            ”001”;
    - 状态变量
        - Signal current_state:main_state;  
            signal next_state:main_state;
2.  三个进程
    - 状态寄存器
        - 异步复位  
            Process(reset,clk)  
            if reset=’1’ then  
            current_state<=initial;  
            elseif clk’event and clk=’1’ then  
            current_state<=next_state
        - 同步复位  
            if clk  
            if reset……initial……else……next
    - 转移逻辑
        - Process(current_state,input)  
            case current_state is  
            when state_1=>  
            if(input…)then next_state<=state_x  
            elsif……next_state<=state_y  
            when……  
            when others=> next_state<=initial
    - 输出逻辑
        - 同上，每个when的if前/后加输出
        - Moore的process不用input
3.  两段式：转移逻辑、输出逻辑在一个process，建议用在Mealy机。
4.  编码
    - 直接输出、自然编码（触发器少，译码麻烦）、格雷码（译码优化）、独热码（触发器多，译码简单）