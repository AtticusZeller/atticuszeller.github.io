# unordered_set

- std::unordered_set is an associative container that contains a set of unique objects. Search, insertion, and removal operations have average constant-time complexity.

## Initialization

- __Empty Unordered Set__:

  ```cpp
  std::unordered_set<int> myUnorderedSet;
  ```

## Insert Elements

- __Insert Single Element__ (Average case O(1)):

  ```cpp
  myUnorderedSet.insert(10); // Insert an element
  ```

- __Emplace Element__ (Average case O(1)):

  ```cpp
  myUnorderedSet.emplace(10); // Construct and insert element
  ```

## Access Elements

- __Find Element__ (Average case O(1)):

  ```cpp
  auto it = myUnorderedSet.find(10);
  // Returns iterator to the element if found, otherwise returns myUnorderedSet.end()
  ```

## Removing Elements

- __Remove Element by Value__ (Average case O(1)):

  ```cpp
  myUnorderedSet.erase(10); // Erases element with value 10
  ```

## Query Attributes

- __Get Unordered Set Size__ (O(1)):

  ```cpp
  size_t size = myUnorderedSet.size(); // Returns the number of elements
  ```

- __Check if Unordered Set is Empty__ (O(1)):

  ```cpp
  bool isEmpty = myUnorderedSet.empty(); // Returns true if unordered set is empty, otherwise false
  ```

## Iterating through Unordered Set

- __Using Iterator__ (O(n)):

  ```cpp
  for (auto it = myUnorderedSet.begin(); it != myUnorderedSet.end(); ++it) {
      // Access the element as *it
  }
  ```

- __Using Range-based For Loop__ (O(n)):

  ```cpp
  for (const auto& elem : myUnorderedSet) {
      // Access the element directly as elem
  }
  ```

## Other Common Operations

- __Clear Unordered Set__ (O(n)):

  ```cpp
  myUnorderedSet.clear(); // Removes all elements from the unordered set
  ```
