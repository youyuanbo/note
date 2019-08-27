#  DFS+回溯

## 题目

1. Leetcode 17. Letter Combinations of a Phone Number
2. Leetcode 79. Word Search
3. Leetcode 46. Permutations
4. Leetcode 47. Permutations Ⅱ
5. Leetcode 78. Subsets
6. Leetcode 90. Subsets Ⅱ
7. Leetcode 216. Combination Sum Ⅱ
8. Leetcode 52. N-Queues Ⅱ
9. Leetcode 37. Sudoku Slover
10. Leetcode 473. Matchsticks to Square

## 题解

### 1. Leetcode 17. Letter Combinations of a Phone Number

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

相似题目：39、40、46、47、78、90

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

### 8. Leetcode 52. N-Queues Ⅱ

### 9. Leetcode 37. Sudoku Slover

### 10. Leetcode 473. Matchsticks to Square

