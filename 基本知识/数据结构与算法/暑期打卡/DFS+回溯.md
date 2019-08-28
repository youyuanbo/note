#  	DFS+回溯

## 题目列表

1. Leetcode 17. Letter Combinations of a Phone Number

2. Leetcode 79. Word Search

3. Leetcode 46. Permutations

   相似题目：39、40、46、47、78、90

4. Leetcode 47. Permutations Ⅱ

5. Leetcode 78. Subsets

6. Leetcode 90. Subsets Ⅱ

7. Leetcode 216. Combination Sum Ⅱ

8. Leetcode 52. N-Queues Ⅱ

9. Leetcode 37. Sudoku Slover

10. Leetcode 473. Matchsticks to Square

## 题解

### 1. Leetcode 17. Letter Combinations of a Phone Number

题目：

```java
//给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。 
//
// 给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。 
//
// 
//
// 示例: 
//
// 输入："23"
//输出：["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
// 
//
// 说明: 
//尽管上面的答案是按字典序排列的，但是你可以任意选择答案输出的顺序。 
// Related Topics 字符串 回溯算法
```



使用迭代完成：

1. 初始化数字对应的字母字符串，定义返回结果集合result
2. 判断传入的数字字符串是否为空，如果为空，返回一个空的集合
3. 遍历传入的字符串
   1. 定义一个临时集合temp
   2. 遍历result集合
      1. 遍历当前数字对应的字符串
         1. 将result中的元素与当前数字对应的字符串中的每一个字母连接起来
         2. 将连接后的结果加入到temp中
   3. 用temp更新result
4. 返回result

```java
class Solution {

    //定义数字对应的字母
    String[] letter = {"abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};

    public List<String> letterCombinations(String digits) {
        //如果传入的数字字符串为空，返回一个空的集合
        if (digits.length() == 0) return new ArrayList<>();
        //定义返回结果集合
        List<String> result = new ArrayList<>();
        //向result中添加一个空的字符串
        result.add("");
        //遍历传入的数字字符串
        for (char c : digits.toCharArray()) {
            //定义一个零时的List，用于存储中间结果
            List<String> temp = new ArrayList<>();
            //遍历原result
            for (String s : result) {
                //遍历当前数字对应的字母字符串
                for (char c1 : letter[c - '2'].toCharArray()) {
                    //取出原result集合中的每一个字符串，取出当前数字对应的字母字符串中的每一个字符
                    //将这两部分拼接在一起，加入到temp集合中
                    temp.add(s + c1);
                }
            }
            //更新result集合
            result = temp;
        }
        //返回结果集合
        return result;
    }
}
```



### 2. Leetcode 79. Word Search

1. 题目

   ```java
   //给定一个二维网格和一个单词，找出该单词是否存在于网格中。 
   //
   // 单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。 
   //
   // 示例: 
   //
   // board =
   //[
   //  ['A','B','C','E'],
   //  ['S','F','C','S'],
   //  ['A','D','E','E']
   //]
   //
   //给定 word = "ABCCED", 返回 true.
   //给定 word = "SEE", 返回 true.
   //给定 word = "ABCB", 返回 false. 
   // Related Topics 数组 回溯算法
   
   ```

   

2. 题解

```java
class Solution {
    //定义全局变量：行、列
    int row;
    int col;
    //定义全部变量：上下左右位置变动时，坐标变换
    int[] dx = {-1, 0, 1, 0};
    int[] dy = {0, 1, 0, -1};

    public boolean exist(char[][] board, String word) {
        //如果board数组为空，返回false
        if (board.length == 0 || board[0].length == 0) return false;
        //获取board的行与列数
        row = board.length;
        col = board[0].length;
        //循环board中的每一个点
        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                //如果找到，返回true
                if (dfs(board, i, j, word, 0)) return true;
            }
        }
        return false;
    }

    /**
     * 进行深入搜索
     * @param board 搜索面板
     * @param x 当前搜索起始坐标
     * @param y 当前搜索起始坐标
     * @param word  需要查找的单词
     * @param index 当前应搜索的字符下标（word的第几个字母）
     * @return
     */
    private boolean dfs(char[][] board, int x, int y, String word, int index) {
        //如果board[x][y]与当前字符不想等，返回false
        if (board[x][y] != word.charAt(index)) return false;
        //如果已经搜索到了单词的最后一个字母，搜索完成，返回true
        if (index == word.length() - 1) return true;
        //标记当前点，以免重复搜索
        board[x][y] = '.';
        //遍历四个方向的搜索
        for (int i = 0; i < 4; i++) {
            int a = x + dx[i];
            int b = y + dy[i];
            if (a >= 0 && a < row && b >= 0 && b < col) {
                if (dfs(board, a, b, word, index + 1)) return true;
            }
        }
        //还原board[x][y]
        board[x][y] = word.charAt(index);
        //如果没有查找到，返回false
        return false;
    }
}class Solution {
    //定义全局变量：行、列
    int row;
    int col;
    //定义全部变量：上下左右位置变动时，坐标变换
    int[] dx = {-1, 0, 1, 0};
    int[] dy = {0, 1, 0, -1};

    public boolean exist(char[][] board, String word) {
        //如果board数组为空，返回false
        if (board.length == 0 || board[0].length == 0) return false;
        //获取board的行与列数
        row = board.length;
        col = board[0].length;
        //循环board中的每一个点
        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                //如果找到，返回true
                if (dfs(board, i, j, word, 0)) return true;
            }
        }
        return false;
    }

    /**
     * 进行深入搜索
     * @param board 搜索面板
     * @param x 当前搜索起始坐标
     * @param y 当前搜索起始坐标
     * @param word  需要查找的单词
     * @param index 当前应搜索的字符下标（word的第几个字母）
     * @return
     */
    private boolean dfs(char[][] board, int x, int y, String word, int index) {
        //如果board[x][y]与当前字符不想等，返回false
        if (board[x][y] != word.charAt(index)) return false;
        //如果已经搜索到了单词的最后一个字母，搜索完成，返回true
        if (index == word.length() - 1) return true;
        //标记当前点，以免重复搜索
        board[x][y] = '.';
        //遍历四个方向的搜索
        for (int i = 0; i < 4; i++) {
            int a = x + dx[i];
            int b = y + dy[i];
            if (a >= 0 && a < row && b >= 0 && b < col) {
                if (dfs(board, a, b, word, index + 1)) return true;
            }
        }
        //还原board[x][y]
        board[x][y] = word.charAt(index);
        //如果没有查找到，返回false
        return false;
    }
}
```



### 3. Leetcode 46. Permutations

1. 题目

   ```java
   //给定一个没有重复数字的序列，返回其所有可能的全排列。 
   //
   // 示例: 
   //
   // 输入: [1,2,3]
   //输出:
   //[
   //  [1,2,3],
   //  [1,3,2],
   //  [2,1,3],
   //  [2,3,1],
   //  [3,1,2],
   //  [3,2,1]
   //] 
   // Related Topics 回溯算法
   ```

   

2. 题解

```java
class Solution {

    int size;
    //标记当前元素是否可以访问
    List<Boolean> visited = new ArrayList<>();
    //记录当前路径上的所有元素
    List<Integer> path = new ArrayList<>();
    //定义返回结果集合
    List<List<Integer>> result = new ArrayList<>();

    public List<List<Integer>> permute(int[] nums) {
        //获取nums的长度
        size = nums.length;
        //初始化visited集合
        for (int i = 0; i < size; i++) {
            visited.add(false);
        }
        //调用辅助方法
        dfs(nums, 0);

        return result;
    }

    /**
     * 回溯
     *
     * @param nums  数字数组
     * @param index 当前数字位置（path中有几个数字）
     */
    public void dfs(int[] nums, int index) {
        //如果index与size相等，说明产生了一组答案
        if (index == size) {
            //将答案添加到result中
            result.add(new ArrayList<>(path));
            return;
        }

        //遍历
        for (int i = 0; i < size; i++) {
            //如果visited.get(i)为false，说明可以访问当前元素
            if (!visited.get(i)) {
                //标记当前元素
                visited.set(i, true);
                //在path中添加当前元素
                path.add(nums[i]);
                //递归
                dfs(nums, index + 1);
                //回溯（恢复现场）
                path.remove(path.size() - 1);
                //回溯（恢复现场）
                visited.set(i, false);
            }
        }
    }
}
```

```java
class Solution {

    List<List<Integer>> res = new ArrayList<>();
    int[] visited;
    List<Integer> tmp = new ArrayList<Integer>();

    public List<List<Integer>> permute(int[] nums) {

        visited = new int[nums.length];
        backtrack(nums);
        return res;

    }

    private void backtrack(int[] nums) {
        if (tmp.size() == nums.length) {
            res.add(new ArrayList<>(tmp));
            return;
        }
        for (int i = 0; i < nums.length; i++) {
            if (visited[i] == 1) continue;
            visited[i] = 1;
            tmp.add(nums[i]);
            backtrack(nums);
            visited[i] = 0;
            tmp.remove(tmp.size() - 1);
        }
    }
}
```



### 4. Leetcode 47. Permutations Ⅱ

1. 题目

   ```java
   //给定一个可包含重复数字的序列，返回所有不重复的全排列。 
   //
   // 示例: 
   //
   // 输入: [1,1,2]
   //输出:
   //[
   //  [1,1,2],
   //  [1,2,1],
   //  [2,1,1]
   //] 
   // Related Topics 回溯算法
   
   ```

2. 题解

```java
class Solution {
    int size;
    List<Boolean> isVisited = new ArrayList<>(3);
    List<Integer> path = new ArrayList<>(3);
    List<List<Integer>> result = new ArrayList<>();

    public List<List<Integer>> permuteUnique(int[] nums) {
        size = nums.length;
        Arrays.sort(nums);

        for (int i = 0; i < size; i++) {
            isVisited.add(false);
            path.add(0);
        }

        dfs(nums, 0, 0);

        return result;
    }

    private void dfs(int[] nums, int index, int start) {
        if (index == size) {
            result.add(new ArrayList<>(path));
            return;
        }

        for (int i = start; i < size; i++) {
            if (!isVisited.get(i)) {
                isVisited.set(i, true);
                path.set(i, nums[index]);
                dfs(nums, index + 1, index + 1 < size && nums[index] == nums[index + 1] ? i + 1 : 0);
                isVisited.set(i, false);
            }
        }
    }
}
```

```java
class Solution {
    List<List<Integer>> res = new ArrayList<>();
    int[] visited;

    public List<List<Integer>> permuteUnique(int[] nums) {

        Arrays.sort(nums);
        visited = new int[nums.length];
        backtrack(nums, new ArrayList<Integer>());
        return res;

    }

    private void backtrack(int[] nums, ArrayList<Integer> tmp) {
        if (tmp.size() == nums.length) {
            res.add(new ArrayList<>(tmp));
            return;
        }

        for (int i = 0; i < nums.length; i++) {
            //如果当前值已经被访问过
            //如果当前值得上一个没有被访问，并且当前数字与上一个数字相等
            //跳过本轮循环，进入下一轮循环
            if (visited[i] == 1 || (i > 0 && visited[i - 1] == 0 && nums[i - 1] == nums[i])) continue;
            //更改当前元素的访问标志
            visited[i] = 1;
            //将当前元素添加到temp中
            tmp.add(nums[i]);
            //递归
            backtrack(nums, tmp);
            //恢复现场
            tmp.remove(tmp.size() - 1);
            //恢复现场
            visited[i] = 0;
        }
    }
}
```



### 5. Leetcode 78. Subsets

1. 题目

   ```java
   //给定一组不含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。 
   //
   // 说明：解集不能包含重复的子集。 
   //
   // 示例: 
   //
   // 输入: nums = [1,2,3]
   //输出:
   //[
   //  [3],
   //  [1],
   //  [2],
   //  [1,2,3],
   //  [1,3],
   //  [2,3],
   //  [1,2],
   //  []
   //] 
   // Related Topics 位运算 数组 回溯算法
   ```

   

2. 题解

```java
class Solution {
    public List<List<Integer>> subsets(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        // 1<<num.length 二进制中，将1向左移动num.length位
        for (int i = 0; i < 1 << nums.length; i++) {
            List<Integer> temp = new ArrayList<>();
            for (int j = 0; j < nums.length; j++) {
                //i >> j & 1 将i向右移动j位，并与1做与运算
                //二进制表示下：返回i的第j位是否为1
                int i1 = i >> j & 1;
                if (i1 != 0) {
                    temp.add(nums[j]);
                }
            }
            result.add(temp);
        }
        return result;
    }
}
```

### 6. Leetcode 90. Subsets Ⅱ

1. 题目

   ```java
   //给定一个可能包含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。 
   //
   // 说明：解集不能包含重复的子集。 
   //
   // 示例: 
   //
   // 输入: [1,2,2]
   //输出:
   //[
   //  [2],
   //  [1],
   //  [1,2,2],
   //  [2,2],
   //  [1,2],
   //  []
   //] 
   // Related Topics 数组 回溯算法
   ```

   

2. 题解

```java
class Solution {

    public List<List<Integer>> subsetsWithDup(int[] nums) {
        Set<List<Integer>> result = new HashSet<>();
        Arrays.sort(nums);

        // 1<<num.length 二进制中，将1向左移动num.length位
        for (int i = 0; i < 1 << nums.length; i++) {
            List<Integer> temp = new ArrayList<>();
            for (int j = 0; j < nums.length; j++) {
                //i >> j & 1 将i向右移动j位，并与1做与运算
                //二进制表示下：返回i的第j位是否为1
                int i1 = i >> j & 1;
                if (i1 != 0) {
                    temp.add(nums[j]);
                }
            }
            result.add(temp);
        }
        return new ArrayList<>(result);
    }
}
```



```java
class Solution {

    List<List<Integer>> result = new ArrayList();
    List<Integer> path = new ArrayList<>();

    public List<List<Integer>> subsetsWithDup(int[] nums) {
        Arrays.sort(nums);

        dfs(nums, 0);
        return result;
    }

    public void dfs(int[] nums, int index) {

        if (index == nums.length) {
            result.add(new ArrayList<>(path));
            return;
        }

        //统计相同字母数
        int count = 0;
        while (count + index < nums.length && nums[count + index] == nums[index]) count++;

        //向下递归
        for (int i = 0; i <= count; i++) {
            dfs(nums, index + count);
            path.add(nums[index]);
        }

        //恢复现场
        for (int i = 0; i <= count; i++) {
            path.remove(path.size() - 1);

        }
    }
}
```



### 7. Leetcode 216. Combination Sum Ⅱ

1. 题目

   ```java
   //找出所有相加之和为 n 的 k 个数的组合。组合中只允许含有 1 - 9 的正整数，并且每种组合中不存在重复的数字。 
   //
   // 说明： 
   //
   // 
   // 所有数字都是正整数。 
   // 解集不能包含重复的组合。 
   // 
   //
   // 示例 1: 
   //
   // 输入: k = 3, n = 7
   //输出: [[1,2,4]]
   // 
   //
   // 示例 2: 
   //
   // 输入: k = 3, n = 9
   //输出: [[1,2,6], [1,3,5], [2,3,4]]
   // 
   // Related Topics 数组 回溯算法
   ```

   

2. 题解

   ```java
   import java.util.ArrayList;
   import java.util.List;
   
   //leetcode submit region begin(Prohibit modification and deletion)
   class Solution {
   
       //定义返回结果集变量
       List<List<Integer>> result;
       //定义路径变量
       List<Integer> path;
   
       public List<List<Integer>> combinationSum3(int k, int n) {
   
           result = new ArrayList<>();
           path = new ArrayList<>();
   
           //调用递归方法
           dfs(k, 1, n);
           return result;
       }
   
       /**
        * 递归方法
        *
        * @param k     当前还差几个参数
        * @param start 从第几开始搜索（1-9）
        * @param n     离目标和值，还差多少
        */
       private void dfs(int k, int start, int n) {
           //如果k==0，说明当前已经找到了k个参数
           if (k == 0) {
               //如果n==0，说明当前找到的几个参数之和，与目标值相等
               if (n == 0) {
                   //将当前的一组解，添加到result集合中
                   result.add(new ArrayList<>(path));
               }
               return;
           }
           //循环，从start开始搜索，最大到9
           for (int i = start; i <= 9; i++) {
               //将当前元素，添加到路径中
               path.add(i);
               //递归，k-1：将参数个数减少一个，i+1：搜索起始点增大，n-i：目标值减小
               dfs(k - 1, i + 1, n - i);
               //恢复现场
               path.remove(path.size() - 1);
           }
       }
   }
   //leetcode submit region end(Prohibit modification and deletion)
   ```

   

### 8. Leetcode 52. N-Queues Ⅱ

1. 题目

   ![1566961459258](image\1566961459258.png)

   ```java
   //n 皇后问题研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。 
   //
   // 
   //
   // 上图为 8 皇后问题的一种解法。 
   //
   // 给定一个整数 n，返回 n 皇后不同的解决方案的数量。 
   //
   // 示例: 
   //
   // 输入: 4
   //输出: 2
   //解释: 4 皇后问题存在如下两个不同的解法。
   //[
   // [".Q..",  // 解法 1
   //  "...Q",
   //  "Q...",
   //  "..Q."],
   //
   // ["..Q.",  // 解法 2
   //  "Q...",
   //  "...Q",
   //  ".Q.."]
   //]
   // 
   // Related Topics 回溯算法	
   ```

   

2. 题解

   1. 每一列上只能右一个皇后，col[N]：表示当前列是否有皇后
   2. 每一行上只能有一个皇后
   3. 每一条斜线上只能有一个皇后

   ```java
   class Solution {
   
       int result = 0;
       int size;
       //定义列访问变量，如果值为1，说明不能被访问，只有值为0时，才能被访问
       int[] col;
       //正斜线
       int[] d;
       //反斜线
       int[] ud;
   
       public int totalNQueens(int n) {
   
           size = n;
           col = new int[size];
           d = new int[size * 2];
           ud = new int[size * 2];
           //从第0行开始递归
           dfs(0);
           return result;
       }
   
       public void dfs(int row) {
           //如果递归填充行数等于size（棋盘行数），说明已经填充完n皇后，并且没有冲突，说明已经找到了一种解决方案
           if (row == size) {
               result++;
               return;
           }
   
           //遍历每一行
           for (int i = 0; i < size; i++) {
               //如果第row行的第i列没有皇后，并且正斜线与反斜线上都没有皇后，说明此位置可以放置皇后
               if (col[i] == 0 && d[row + i] == 0 && ud[row - i + size] == 0) {
                   //改变当前位置的标志
                   col[i] = d[row + i] = ud[row - i + size] = 1;
                   //递归至下一行
                   dfs(row + 1);
                   //恢复现场
                   col[i] = d[row + i] = ud[row - i + size] = 0;
               }
           }
       }
   }
   ```

   

### 9. Leetcode 37. Sudoku Slover

1. 题目

   ![1566974688731](E:\Note\基本知识\数据结构与算法\暑期打卡\image\1566974688731.png)

   

   ![1566974661617](E:\Note\基本知识\数据结构与算法\暑期打卡\image\1566974661617.png)

   

   ```java
   //编写一个程序，通过已填充的空格来解决数独问题。 
   //
   // 一个数独的解法需遵循如下规则： 
   //
   // 
   // 数字 1-9 在每一行只能出现一次。 
   // 数字 1-9 在每一列只能出现一次。 
   // 数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。 
   // 
   //
   // 空白格用 '.' 表示。 
   //
   // 
   //
   // 一个数独。 
   //
   // 
   //
   // 答案被标成红色。 
   //
   // Note: 
   //
   // 
   // 给定的数独序列只包含数字 1-9 和字符 '.' 。 
   // 你可以假设给定的数独只有唯一解。 
   // 给定数独永远是 9x9 形式的。 
   // 
   // Related Topics 哈希表 回溯算法
   ```

   

2. 题解

   1. 从前往后依次枚举每一个空格，确定该空格应该填写哪一个数字
   2. 状态记录：三个状态条件必须同时满足
      1. 行：row[9] [9] 记录某一行是否已经存在某一个数字
      2. 列：col [9] [9] 记录某一列是否已经存在某一个数字
      3. 单元格：cell [3] [3] [9] 记录某一个9宫格中是否已经存在某一个数字
   3. 枚举现在的数独面板，将当前的填充情况记录在三个状态数组中
   4. 调用递归函数，从左上角（0,0）开始，以行为主遍历
      1. 判断在当前行，列是否等于9（越界）。	如果等于，将行向下移动（row+1），列置为0（col=0）
      2. 判断行是否等于9（越界）。如果等于，返回true，递归结束
      3. 如果当前位置已经被填充，递归到下一个点（dfs(board, row, col+1)），行不变，列加一
      4. 循环，遍历每一行，当满足三个状态条件时：
         1. 更新board [x] [y]的值
         2. 更新三个状态条件
         3. 递归到下一个位置（dfs(board, row,col+1)）,行不变，列加一
            1. 如果递归调用成功，返回true
         4. 恢复状态条件现场
         5. 恢复board现场
         6. 结束循环，返回false
   5. 结束程序

   ```java
   class Solution {
       //记录行状态，row[x][y]：表示在x行已经存在数字y
       int[][] row;
       //记录列状态，row[x][y]：表示在x列已经存在数字y
       int[][] col;
       //记录九宫格状态：cell[x][y][z]:表示在(x，y)这个九宫格中，已经存在数字y
       int[][][] cell;
   
       public void solveSudoku(char[][] board) {
           row = new int[9][9];
           col = new int[9][9];
           cell = new int[3][3][9];
   
           //初始化状态数组
           for (int i = 0; i < 9; i++) {
               for (int j = 0; j < 9; j++) {
                   char c = board[i][j];
                   //如果当前位置上的值不是小数点（空格），说明当前位置上有数字，记录
                   if (c != '.') {
                       int num = c - '1';
                       row[i][num] = 1;
                       col[j][num] = 1;
                       cell[i / 3][j / 3][num] = 1;
                   }
               }
           }
           //调用递归函数
           dfs(board, 0, 0);
       }
   
       private boolean dfs(char[][] board, int x, int y) {
           //如果行数等于9，说明填充完毕，返回true
           if (x == 9) {
               return true;
           }
           //如果列数等于9，说明到了每一行的末尾，跳转到下一行起始位置
           if (y == 9) {
               x++;
               y = 0;
           }
           //如果当前位置不为空，递归到下一个位置
           if (board[x][y] != '.') {
               return dfs(board, x, y + 1);
           }
           //枚举当前行的每一个位置，确定当前位置应该填入哪一个数字
           for (int i = 0; i < 9; i++) {
               //如果满足状态条件
               if (row[x][i] == 0 && col[y][i] == 0 && cell[x / 3][y / 3][i] == 0) {
                   //更改九宫格中的，当前位置的值
                   board[x][y] = (char) (i + '1');
                   //更改状态数组
                   row[x][i] = col[y][i] = cell[x / 3][y / 3][i] = 1;
                   //递归到下一个位置
                   if (dfs(board, x, y + 1)) return true;
                   //恢复现场
                   row[x][i] = col[y][i] = cell[x / 3][y / 3][i] = 0;
                   //恢复现场
                   board[x][y] = '.';
               }
           }
           //如果循环完毕，都没有返回，说明存在冲突，返回false
           return false;
       }
   }
   ```

   

### 10. Leetcode 473. Matchsticks to Square

1. 题目

   

2. 题解

   1. 搜索顺序：

      + 依次拼正方形的每一条边

   2. 剪枝：

      1. 从大到小枚举，每次剪枝去掉的分支会更多
      2. 每条边内部的木棒长度规定成从大到小
      3. 如果当前木棒拼接失败，则跳过接下来所有长度相同的木棒
      4. 如果当前木棒拼接失败，且是当前边的第一个，则直接剪掉当前分支
      5. 如果当前木棒拼接失败，且是当前边的最后一个，则直接剪掉当前分支

   3. 伪代码

      1. 输入：木棒数组
      2. 输出：如果能够拼接成功，返回true；否则，返回false
      3. 初始化：申请一个数组isUse，长度与木棒输入相等，记录当前木棒是否已经被使用过
      4. 计算木棒总和，如果等于0,或者除以4取余数不等于0，返回false
      5. 对木棒数组按降序排序
      6. 计算正方形变成，正方形变成为木棒长度总和的1/4
      7. 调用递归函数，函数接受的参数：木棒数组(nums)，当前拼接的正方形边数（1<=edge<=4），当前木棒长度(cur)
         1. 如果当前木棒长度等于正方形边长，则拼接下一条边（edge++，cur=0）
         2. 如果当前边数等于4,说明拼接完成，返回true
         3. 遍历木棒数组，拼接正方形边
            1. 需满足：当前木棒没有被使用，当前边加上当前木棒的长度，小于正方形边长
            2. 改变当前木棒的使用标记
            3. 递归拼接当前边，如果拼接成功，返回true
            4. 恢复木棒使用标记
            5. 剪枝：如果当前木棒拼接失败，则跳过接下来所有长度相同的木棒
            6. 剪枝：如果当前木棒拼接失败，且是当前边的第一个，则直接剪掉当前分支
            7. 剪枝：如果当前木棒拼接失败，且是当前边的最后一个，则直接剪掉当前分支

      ```java
      class Solution {
          //isUsed：标记当前木棒是否已经被使用
          int[] isUsed;
          //正方形边长
          int length;
      
          public boolean makesquare(int[] nums) {
      
              int sum = 0;
              Integer data[] = new Integer[nums.length];
              for (int i = 0; i < nums.length; i++) {
                  //计算所有木棒总长
                  sum += nums[i];
                  //将int类型转换为Integer类型
                  data[i] = nums[i];
              }
      
              //如果木棒总长不能整除4或者木棒数组为空，说明不能拼接成正方形
              if (sum % 4 != 0 || nums.length == 0) {
                  return false;
              }
      
              //初始化isUsed数组
              isUsed = new int[nums.length];
              //计算正方形边长
              length = sum / 4;
              //将data（nums数组的Integer类型数组）数组按降序排序
              Arrays.sort(data, Collections.reverseOrder());
              //将排序后的数组，赋值给nums
              for (int i = 0; i < data.length; i++) {
                  nums[i] = data[i];
              }
      
              //递归调用
              return dfs(nums, 0, 0);
          }
      
          private boolean dfs(int[] nums, int edge, int curLength) {
              //如果当前边长度等于正方形边长，说明此边拼接完成
              if (curLength == length) {
                  //拼接下一条边
                  edge++;
                  //初始化当前边的边长为0
                  curLength = 0;
              }
              //如果已经拼接完成4条边，说明正方形拼接完成
              if (edge == 4) {
                  return true;
              }
              //遍历每一条木棒
              for (int i = 0; i < nums.length; i++) {
                  //如果当前木棒没有被使用，并且当前边拼接上当前木棒后，新的边长不会超过正方形边长，则可以拼接当前木棒
                  if (isUsed[i] == 0 && curLength + nums[i] <= length) {
                      //更改当前木棒的使用标记为已经被使用
                      isUsed[i] = 1;
                      //递归，拼接下一根木棒
                      if (dfs(nums, edge, curLength + nums[i])) {
                          //如果拼接成功，返回true
                          return true;
                      }
                      //恢复现场（恢复木棒使用标记）
                      isUsed[i] = 0;
                      //剪枝：如果当前木棒拼接失败，则跳过接下来所有长度相同的木棒
                      while (i + 1 < nums.length && nums[i + 1] == nums[i]) i++;
                      //剪枝：如果当前木棒拼接失败，且是当前边的第一个，则直接剪掉当前分支
                      if (curLength == 0) return false;
                      //剪枝：如果当前木棒拼接失败，且是当前边的最后一个，则直接剪掉当前分支
                      if (curLength + nums[i] == length) return false;
                  }
              }
              //如果遍历完所有木棒，都没有拼接成功，返回false
              return false;
          }
      }
      ```

      