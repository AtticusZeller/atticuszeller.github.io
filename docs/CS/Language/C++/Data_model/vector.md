# Initialization

- __Empty Vector__:

  ```cpp
  std::vector<int> vec;
  ```

- __Pre-allocate Size__:

  ```cpp
  std::vector<int> vec(10);  // Contains 10 elements, all initialized to 0
  ```

- __Pre-allocate Size with Value__:

  ```cpp
  std::vector<int> vec(10, 1);  // Contains 10 elements, all initialized to 1
  ```

- __Initialize from Array__:

  ```cpp
  int arr[] = {1, 2, 3};
  std::vector<int> vec(arr, arr + sizeof(arr) / sizeof(int));
  ```

- __Initialize from Another Vector__:

  ```cpp
  std::vector<int> vec2(vec);
  ```

# Adding Elements

- __Append to End__:

  ```cpp
  vec.push_back(4);
  ```

- __Insert at Beginning__:

  ```cpp
  vec.insert(vec.begin(), 4);
  ```

- __Insert at Specific Position__:

  ```cpp
  vec.insert(vec.begin() + 1, 4);
  ```

- __append vector__

```cpp
vec.insert(vec.end(),vec_2.begin(),vec_2.end())
```

# Access Elements

- __Access Last Element__:

  ```cpp
  int last = vec.back();
  ```

- __Access First Element__:

  ```cpp
  int first = vec.front();
  ```

- __Access i-th Element (0-based)__:

  ```cpp
  int elem = vec[i];
  ```

# Removing Elements

- __Remove Last Element__:

  ```cpp
  vec.pop_back();    ->void
  ```

- __Remove i-th Element__:

  ```cpp
  vec.erase(vec.begin() + i);
  ```

- __Remove a Range of Elements__:

  ```cpp
  vec.erase(vec.begin() + i, vec.begin() + j);  // Removes elements from i to j-1
  ```

# Query Attributes

- __Get Vector Size__:

  ```cpp
  size_t size = vec.size();
  ```

- __Check if Vector is Empty__:

  ```cpp
  bool isEmpty = vec.empty();
  ```

# Other Common Operations

- __Clear Vector__:

  ```cpp
  vec.clear();
  ```

- __Resize Vector__:

  ```cpp
  vec.resize(20);  // New elements are initialized to 0
  ```

- __Find Element Position__:

  ```cpp
  std::find(vec.begin(), vec.end(), value) != vec.end()
  ```

- __Sort Vector__:

  ```cpp
  std::sort(vec.begin(), vec.end());
  ```

# Examples

```c++

#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> vec = {3, 1, 4, 1, 5, 9, 2, 6, 5};

    // 使用 std::min_element 和 lambda 函数找到最小正整数
    auto it = std::min_element(vec.begin(), vec.end(), [](int a, int b) {
        if (a <= 0) return false;
        if (b <= 0) return true;
        return a < b;
    });

    if (it != vec.end() && *it > 0) {
        std::cout << "最小正整数是：" << *it << std::endl;
    } else {
        std::cout << "没有找到正整数" << std::endl;
    }

    return 0;
}
```

```c++
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> vec = {1, 2, 2, 3, 4, 4, 5};

    // 先排序
    std::sort(vec.begin(), vec.end());

    // 使用 std::unique 去重
    auto last = std::unique(vec.begin(), vec.end());

    // 删除多余元素
    vec.erase(last, vec.end());

    // 输出去重后的向量
    for (const auto& elem : vec) {
        std::cout << elem << " ";
    }
    std::cout << std::endl;

    return 0;
}

```
