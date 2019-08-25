# java8新特性

1. 速度更快
2. 代码更少（Lambda）
3. 强大的stream api
4. 并与并行
5. 最大化减少空指针异常(Optional)
6. Nashorn引擎，允许在JVM上运行JS应用

Lambda本质：函数式接口的实例

## 1、Lambda表达式

使用原生实现

```java
@Test
public void test01(){

    Runnable runnable = new Runnable() {
        @Override
        public void run() {
            System.out.println("lambda test");
        }
    };

    runnable.run();
}
```

使用Lambda表达式

```java
@Test
public void test02(){
    Runnable runnable = ()-> System.out.println("runnable test02");
    runnable.run();
}
```



在Lambda操作符左边的是：Lambda形参列表，对应于原来的接口抽象方法中的形参

在Lambda操作符右边的是：Lambda体，对应于原来的抽象方法

Lambda表达式的6种使用情况：

1. 无参数，无返回值

   ```java
   @Test
   public void test02(){
       Runnable runnable = ()-> System.out.println("runnable test02");
       runnable.run();
   }
   ```

2. 有一个参数，没有返回值

   ```java
   @Test
   public void test03(){
       Consumer<String> consumer = new Consumer<String>() {
           @Override
           public void accept(String s) {
               System.out.println(s);
           }
       };
   
       consumer.accept("consumer accept");
   }
   
   @Test
   public void test04(){
       Consumer<String> consumer = (String s) -> System.out.println(s);
   
       consumer.accept("consumer accept");
   }
   ```

3. 数据类型可以省略，因为可以由编译器推断得出，称为“类型推断”

   ```java
   @Test
   public void test03(){
       Consumer<String> consumer = new Consumer<String>() {
           @Override
           public void accept(String s) {
               System.out.println(s);
           }
       };
   
       consumer.accept("consumer accept");
   }
   
   @Test
   public void test04(){
       Consumer<String> consumer = (s) -> System.out.println(s);
   
       consumer.accept("consumer accept");
   }
   ```

4. 如果只有一个参数，参数外部的小括号可以省略

   ```java
   @Test
   public void test05(){
       Consumer<String> consumer = s -> System.out.println(s);
   
       consumer.accept("consumer accept");
   }
   ```

5. 需要两个或以上的参数，有多条语句，并且有返回值

   ```java
   @Test
   public void test06() {
       Comparator<Integer> comparator = new Comparator<Integer>() {
           @Override
           public int compare(Integer o1, Integer o2) {
               return o1.compareTo(o2);
           }
       };
       comparator.compare(1,2);
   }
   
   @Test
   public void test07() {
       Comparator<Integer> comparator = (o1, o2) -> {
           System.out.println(o1);
           System.out.println(o2);
           return o1.compareTo(o2);
       };
       
       comparator.compare(1,2);
   }
   ```

6. 当Lambda体只有一条语句时，return与大括号都可以省略

   ```java
   @Test
   public void test08() {
       Comparator<Integer> comparator = (o1, o2) -> o1.compareTo(o2);
       System.out.println(comparator.compare(1,2));
   }
   ```

7. 



## 2、函数式接口

四大函数式接口：

1. 消费型

   Consumer<T> void accept(T t)

2. 供给型

   Supplier<T> T get()

3. 函数型

   Function<T,R> 	R apply(T t) 

4. 断定型

   Predicate<T> boolean test(T t)

   ```java
   public List<String> filterString(List<String> list, Predicate<String> predicate) {
   
       List<String> filterList = new ArrayList<>();
       for (String s : list) {
           if (predicate.test(s)) {
               filterList.add(s);
           }
       }
       return filterList;
   }
   
   @Test
   public void test10() {
       List<String> list = Arrays.asList("北京", "天津", "西京", "南京", "普京");
       List<String> filterString = filterString(list, s -> s.contains("京"));
       System.out.println(filterString);
   }
   ```

## 3、方法引用与构造器引用

​	本质：方法引用本质就是Lambda表达式，而Lambda表达式作为函数式接口的实例。所以，方法应用就是函数式接口的实例。

​	要求：接口中抽象方法的形参列表与返回值，必须与方法引用的方法形参列表与返回值一致

​	使用方法：类（对象）:: 方法名

1. 通过对象调用非静态方法，当要传递给Lambda体的操作，已经有实现的方法了，就可以使用方法引用

   ```java
   @Test
   public void test11(){
       Consumer<String> consumer =  s -> System.out.println(s);
       consumer.accept("hello world");
   
       System.out.println("-------------------------");
   
       Consumer consumer1 = System.out::println;
       consumer1.accept("hello lambda");
   }
   ```

2. 通过类调用静态方法

   ```java
   @Test
   public void test12(){
       Comparator<Integer> comparator = (t1,t2) ->Integer.compare(t1,t2);
       int compare = comparator.compare(1, 2);
       System.out.println(compare);
   }
   
   //Integer中的int compare(int x, int y)
   //Compare中的int compare(T o1, T o2);
   @Test
   public void test13(){
       Comparator<Integer> comparator = Integer::compare;
       int compare = comparator.compare(1, 2);
       System.out.println(compare);
   }
   ```

   ```java
   @Test
   public void test14(){
   
       Function<Double, Long> function = d -> Math.round(d);
       System.out.println(function.apply(1.0));
   
       System.out.println("***************************");
   
       Function<Double, Long> function1 = Math::round;
   
       System.out.println(function1.apply(11.23));
   }
   ```

3. 通过类调用静态方法

   ```java
   /**
    * Comparator int compare(T o1, T o2);
    * String boolean equals(Object anObject)
    */
   @Test
   public void test15(){
       Comparator<String> comparator = (s1,s2) -> s1.compareTo(s2);
   
       System.out.println(comparator.compare("abc", "abd"));
   
       Comparator<String> comparator1 = String::compareTo;
   
       System.out.println(comparator1.compare("abc", "abd"));
   }
   ```

4. 构造器引用

   无参构造器

   ```java
   @Test
   public void test16(){
       Supplier<Person> supplier = new Supplier<Person>() {
           @Override
           public Person get() {
               return new Person();
           }
       };
       Person person1 = supplier.get();
       System.out.println("-----------------");
   
       Supplier<Person> supplier1 = ()->new Person();
       Person person = supplier1.get();
       System.out.println("------------------");
   
       Supplier<Person> supplier2 = Person::new;
       Person person2 = supplier2.get();
       
   }
   ```

   一个参数的构造器

   ```java
   @Test
   public void test17(){
       Function<String, Person> function1 = new Function<String, Person>() {
           @Override
           public Person apply(String name) {
               return new Person(name);
           }
       };
       Person xiaoyou = function1.apply("xiaoyou");
       System.out.println("-----------------------");
   
       Function<String, Person> function2 = (name)->new Person(name);
       Person xiaoyou1 = function2.apply("xiaoyou");
       System.out.println("------------------------");
   
       Function<String, Person> function3 = Person::new;
       Person xiaoyou2 = function3.apply("xiaoyou");
       
   }
   ```

   多个参数

   ```java
   @Test
   public void test18() {
       BiFunction<String, String, Person> biFunction1 = new BiFunction<String, String, Person>() {
           @Override
           public Person apply(String name, String password) {
               return new Person(name, password);
           }
       };
       Person person1 = biFunction1.apply("xiaoyou", "root");
       System.out.println("-----------------");
   
       BiFunction<String, String, Person> biFunction2 = (name, password) -> new Person(name, password);
       Person person2 = biFunction2.apply("xiaoyou", "root");
       System.out.println("-----------------");
   
       BiFunction<String, String, Person> biFunction3 = Person::new;
       Person person3 = biFunction3.apply("xiaoyou", "root");
   
   }
   ```

5. 数组引用

   ```java
   @Test
   public void test19(){
       Function<Integer, String[]> function = new Function<Integer, String[]>() {
           @Override
           public String[] apply(Integer length) {
               return new String[length];
           }
       };
       String[] strings = function.apply(10);
       System.out.println("------------------");
   
       Function<Integer, String[]> function1 = length->new String[length];
       String[] strings1 = function1.apply(5);
       System.out.println("-----------------");
   
       Function<Integer, String[]> function2 = String[]::new;
       function2.apply(1);
       
   }
   ```

## 4、Stream API

Stream是数据渠道，用于操作数据源（集合、数组等）所生成的元素序列。

集合讲的是数据，Stream讲的是计算。

Stream 关注的是计算，与CPU打交道

Collection关注的是存储，与内存打交道

Stream 特点：

1. Stream 自己不会存储元素
2. Stream 不会改变源对象，Stream计算后，会返回一个持有结果的新的Stream。
3. Stream 操作是延迟的。这意味着他们会等到需要结果的时候才执行。

Stream 操作的步骤：

1. 创建Stream 对象：传入一个数据源（集合、数组）， 创建一个流
2. 中间操作：一个中间操作链，对数据源的数据进行处理
3. 终止操作：一旦执行终止操作，就==执行中间操作链==，并产生结果。之后，不会再执行。

### 创建Stream

1. 通过集合创建

   + 获取一个串行流

     ```java
     @Test
     public void test01(){
        List<Person> personList = Person.getPersons();
        Stream<Person> stream = personList.stream();
     }
     ```

   + 获取一个并行流

     ```java
     @Test
     public void test02(){
        List<Person> personList = Person.getPersons();
        Stream<Person> personStream = personList.parallelStream();
     }
     ```

2. 通过数组创建

   + 基本类型

     ```java
     @Test
     public void test03(){
        int arr[] = {1,2,3};
        IntStream intStream = Arrays.stream(arr);
     }
     ```

   + 自定义类型

     ```java
     @Test
     public void test04(){
        Person person[] = {new Person("xiaoyou"), new Person("xiaoliang")};
        Stream<Person> personStream = Arrays.stream(person);
     }
     ```

   

3. 通过Stream 的of 创建

   ```java
   @Test
   public void test05(){
      Stream<Integer> integerStream = Stream.of(1, 2, 3, 4);
   
      Stream<Person> personStream = Stream.of(new Person("xiaoyou"), new Person("xiaoliang"));
      
   }
   ```

4. 创建无限流

   + 迭代

     ```java
     @Test
     public void test06(){
        //从0开始，迭代生成10个偶数，并输出
         //limit是中间操作
         //forEach是终止操作
        Stream.iterate(0, t->t+2).limit(10).forEach(System.out::println);
     }
     ```

   + 生成

     ```java
     @Test
     public void test07(){
        Stream.generate(Math::random).limit(10).forEach(System.out::println);
     }
     ```

5. 、

### 中间操作

1. 筛选与切片

   + filter(Predicate p) : 接收Lambda，从流中排除某些元素

     原生

     ```java
     @Test
     public void test08(){
        List<Person> persons = Person.getPersons();
        Stream<Person> stream = persons.stream();
        Stream<Person> personStream = stream.filter(new Predicate<Person>() {
           @Override
           public boolean test(Person person) {
              if (person.getName().equals("xiaoyou")) {
                 return true;
              }
              return false;
           }
        });
        personStream.forEach(new Consumer<Person>() {
           @Override
           public void accept(Person person) {
              System.out.println(person);
           }
        });
     }
     ```

     精简

     ```java
     @Test
     public void test09(){
        // List<Person> persons = Person.getPersons();
        // Stream<Person> stream = persons.stream();
        // stream.filter(person -> person.getName().equals("xiaoyou")).forEach(System.out::println);
        
        Person.getPersons().stream().filter(person -> person.getName().equals("xiaoyou")).forEach(System.out::println);
     }
     ```

     

   + limit(long maxSize): 截断流，使其元素不超过给定数量

     ```java
     @Test
     public void test10(){
        Person.getPersons().stream().limit(2).forEach(System.out::println);
     
     }
     ```

   + skip(long n): 跳过元素，返回一个扔掉了n个元素的流，若流中元素不足n个，则返回一个空流，与limit(n) 互补

     ```java
     @Test
     public void test11(){
         //跳过3条数据，取后面的所有数据
        Person.getPersons().stream().skip(3).forEach(System.out::println);
         //跳过3条数据，取接下来的一条数据
        Person.getPersons().stream().skip(3).limit(1).forEach(System.out::println);
     
     }
     ```

   + distinct：去重，通过流生成的hashCode与equals去除重复元素

     ```java
     @Test
     public void test12(){
        Person.getPersons().stream().limit(6).distinct().forEach(System.out::println);
        Person.getPersons().stream().distinct().limit(3).forEach(System.out::println);
     }
     ```

2. 映射

   + map(Function f): 接收一个函数作为参数，该函数会被应用到每个元素上，并将其映射成一个新元素

   + mapToDouble(ToDoubleFunction f)：: 接收一个函数作为参数，该函数会被应用到每个元素上，产生一个新的 DoubleStream

     ```java
     @Test
     public void test13(){
        List<String> list = Arrays.asList("aa", "bb", "cc", "dd");
        list.stream().map(str->str.toUpperCase()).forEach(System.out::println);
     }
     ```

     ```java
     @Test
     public void test14(){
        List<Person> persons = Person.getPersons();
        persons.stream()
              .filter(person -> person.getName().equals("xiaoyou"))
              .map(person -> person.getName().toUpperCase())
              .forEach(System.out::println);
     
     }
     ```

   + mapToInt(ToIntfunction f): 接收一个函数作为参数，该函数会被应用到每个元素上，产生一个新的IntStream 

     ```java
     @Test
     public void test15(){
         Person.getPersons()
               .stream()
               .map(person -> person.getName())
               .filter(str->str.length() > 3)
               .forEach(System.out::println);
     
         Person.getPersons()
               .stream()
               .map(Person::getName)
               .filter(name -> name.length()>7)
               .forEach(System.out::println);
     }
     ```

   + mapToLong(ToLongFunction f)：: 接收一个函数作为参数，该函数会被应用到每个元素上，产生一个新的LongStream 

   + flatMap(Function f): 接收一个函数作为参数，将流中的每一个元素都映射成一个流，然后把所有的流连接成一个流

     ```java
     @Test
     public void test16(){
     
        List<List> outList = new ArrayList<>();
     
        List<String> innerList1 = new ArrayList<>();
        innerList1.add("a");
        innerList1.add("b");
        innerList1.add("c");
     
        List<String> innerList2 = new ArrayList<>();
        innerList2.add("z");
        innerList2.add("y");
        innerList2.add("x");
     
        outList.add(innerList1);
        outList.add(innerList2);
     
        outList.stream().flatMap(Collection::stream).forEach(System.out::println);
        
        outList.stream().flatMap(list -> list.stream()).forEach(System.out::println);
     }
     ```

   + 

3. 排序

   + sorted：产生一个新流，按自然顺序排序(升序)

     ```java
     @Test
     public void test17(){
        List<Integer> integerList = Arrays.asList(1, 5, 2, 6, 3, 9, 4, 8, 7);
        integerList.stream().sorted().forEach(System.out::println);
     }
     ```

   + sorted(Comparator com)：产生一个新流，按比较器顺序排序

     ```java
     @Test
     public void test18(){
        List<Person> persons = Person.getPersons();
     
        persons.stream().sorted((person1, person2) ->{
           return Integer.compare(person1.getId(),person2.getId());
        }).forEach(System.out::println);
     
        persons.stream()
              .sorted((person1, person2) -> Integer.compare(person1.getId(), person2.getId()))
              .forEach(System.out::println);
     
        persons.stream()
              .sorted(Comparator.comparingInt(Person::getId))
              .forEach(System.out::println);
     
     }
     ```

4. \

### 终止操作

​	终止操作会从流的流水线产生结果，其结果可以是不是流的任何结果。流进行了终止操作，不能再次使用。

1. 匹配与查找

   + allMatch(Predicate p)：检查是否匹配所有元素

     ```java
     @Test
     public void test20(){
         boolean allMatch = Person.getPersons()
             .stream()
             .allMatch(person -> person.getId() > 0);
         System.out.println(allMatch);
     }
     ```

   + anyMatch(Predicate p)：检查是否匹配至少一个元素

     ```java
     @Test
     public void test21(){
        boolean anyMatch = Person.getPersons()
              .stream()
              .anyMatch(person -> person.getId() == 1);
        System.out.println(anyMatch);
     }
     ```

   + noneMatch(Predicate p)：检查是否没有匹配所有元素

     ```java
     @Test
     public void test22(){
        boolean noneMatch = Person.getPersons()
              .stream()
              .noneMatch(person -> person.getId() > 10);
        System.out.println(noneMatch);
     }
     ```

   + findFirst(Predicate p)：返回第一个元素

     ```java
     @Test
     public void test23(){
        Optional<Person> person = Person.getPersons().stream().findFirst();
        System.out.println(person);
     }
     ```

   + findAny(Predicate p)：返回当前流中的任意元素

     ```java
     @Test
     public void test24() {
        Optional<Person> person = Person.getPersons().stream().findAny();
        System.out.println(person);
     }
     
     @Test
     public void test24() {
         Optional<Person> person = Person.getPersons().parallelStream().findAny();
         System.out.println(person);
     }
     ```

   + count

     ```java
     @Test
     public void test25(){
        long count = Person.getPersons()
              .stream()
              .filter(person -> person.getId() > 5)
              .count();
        System.out.println(count);
     }
     ```

   + max(Comparator com)

     ```java
     @Test
     public void test26(){
        Optional<Integer> max = Person.getPersons().stream().map(Person::getId).max(Integer::compareTo);
        System.out.println(max);
     }
     ```

   + min(Comparator com)

     ```java
     @Test
     public void test27(){
        Optional<Person> min1 = Person.getPersons()
              .stream()
              .min((Person person1, Person person2) -> Integer.compare(person1.getId(), person2.getId()));
     
        Optional<Person> min2 = Person.getPersons()
              .stream()
              .min(Comparator.comparingInt(Person::getId));
     
        System.out.println(min1);
        System.out.println(min2);
     }
     ```

   + forEach(Consumer con)

     ```java
     @Test
     public void test28(){
        //流中的foreach
        Person.getPersons().stream().forEach(System.out::println);
     
        //集合中的foreach
        Person.getPersons().forEach(System.out::println);
     }
     ```

2. 规约

   + reduce(T iden, BinaryOperator b)：可以将流中元素反复结合起来，得到一个值，返回T

     ```java
     @Test
     public void test29(){
     
        List<Integer> integers = Arrays.asList(1, 2, 3, 4, 5);
         //reduce :第一个参数是初始值
        Integer reduce = integers.stream().reduce(0, Integer::sum);
        System.out.println(reduce);
     }
     ```

   + reduce(BinaryOperator b)：可以将流中元素反复结合起来，得到一个值，返回Optional[T]

     ```java
     @Test
     public void test30(){
        Optional<Integer> reduce = Person.getPersons().stream().map(Person::getId).reduce(Integer::sum);
        System.out.println(reduce);
     
     }
     ```

3. 收集

   + collect(Collector coll)：将流转换为其他形式。接收一个Collector接口的实现，用于给Stream中元素做汇总的方法。

     ```java
     @Test
     public void test31() {
        Person.getPersons()
              .stream()
              .map(person -> new Person(person.getName(), person.getPassword()))
              .collect(Collectors.toList())
              .stream()
              .forEach(System.out::println);
     
        Person.getPersons()
              .stream()
              .filter(person -> person.getPassword().equals("root"))
              .collect(Collectors.toList())
              .stream()   //此行可有可无
              .forEach(System.out::println);
     
     }
     ```



## 5、Optional类

Optional类可以避免空指针异常。

![1561204104712](img\1561204104712.png)



