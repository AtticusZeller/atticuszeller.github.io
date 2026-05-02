# Set

- std::set is an associative container that contains a sorted set of unique objects. It is usually implemented as a red-black tree.

## Initialization

- __Empty Set__:

  ```cpp
  std::set<int> mySet;
  ```

## Insert Elements

- __Insert Single Element__ (Average case O(log n)):

  ```cpp
  mySet.insert(10); // Insert an element
  ```

- __Emplace Element__ (Average case O(log n)):

  ```cpp
  mySet.emplace(10); // Construct and insert element
  ```

## Access Elements

- __Find Element__ (Average case O(log n)):

  ```cpp
  auto it = mySet.find(10); // Returns iterator to the element if found, otherwise returns mySet.end()
  ```

## Removing Elements

- __Remove Element by Value__ (Average case O(log n)):

  ```cpp
  mySet.erase(10); // Erases element with value 10
  ```

## Query Attributes

- __Get Set Size__ (O(1)):

  ```cpp
  size_t size = mySet.size(); // Returns the number of elements
  ```

- __Check if Set is Empty__ (O(1)):

  ```cpp
  bool isEmpty = mySet.empty(); // Returns true if set is empty, otherwise false
  ```

## Iterating through Set

- __Using Iterator__ (O(n)):

  ```cpp
  for (auto it = mySet.begin(); it != mySet.end(); ++it) {
      // Access the element as *it
  }
  ```

- __Using Range-based For Loop__ (O(n)):

  ```cpp
  for (const auto& elem : mySet) {
      // Access the element directly as elem
  }
  ```

## Other Common Operations

- __Clear Set__ (O(n)):

  ```cpp
  mySet.clear(); // Removes all elements from the set
  ```
