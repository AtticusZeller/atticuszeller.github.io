# Map

## Initialization

- __Empty Map__:

  ```cpp
  std::map<int, std::string> myMap;

      std::unordered_map<int, std::string> myMap = {
      {1, "one"},
      {2, "two"},
      {3, "three"}

  };
  ```

## Insert Elements

- __Insert Single Element__:

  ```cpp
  myMap[1] = "one";  // Insert key-value pair
  // or
  myMap.insert(std::make_pair(1, "one"));  // Insert key-value pair

  myMap.emplace(1, "one"); // create key-value pair directly
  ```

## Access Elements

- __Access Value by Key__:

  ```cpp
  std::string value = myMap[1];  // Access value by key, returns std::string
  ```

- __Find Element__:

  ```cpp
  auto it = myMap.find(1);  // Returns iterator to the element if key exists, otherwise returns myMap.end()
  ```

## Removing Elements

- __Remove Element by Key__:

  ```cpp
  myMap.erase(1);  // Removes element with key 1, returns number of elements removed (size_t)
  ```

## Query Attributes

- __Get Map Size__:

  ```cpp
  size_t size = myMap.size();  // Returns the number of elements in the map (size_t)
  ```

- __Check if Map is Empty__:

  ```cpp
  bool isEmpty = myMap.empty();  // Returns true if the map is empty, otherwise false (bool)
  ```

## Iterating through Map

- __Using Iterator__:

  ```cpp
  for (auto it = myMap.begin(); it != myMap.end(); ++it) {
      // it->first: key
      // it->second: value
  }
  ```

- __Using Range-based For Loop__:

  ```cpp
  for (const auto& [key, value] : myMap) {
      // key: key
      // value: value
  }
  ```

## Other Common Operations

- __Clear Map__:

  ```cpp
  myMap.clear();  // Removes all elements from the map
  ```
