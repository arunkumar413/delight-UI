## Delight UI 

A library project for delightful and elite user and developer experience to develop native applications using the Swift language.


###  Tech Stack
1) Swift language ( https://www.swift.org/ )
2) Simple DirectMedia Layer ( https://libsdl.org/ ) for mouse, keyboard events, window creation, text rendering
3) Yoga layout ( https://www.yogalayout.dev/ ) for laying out the Views and Nodes


### What's working now?

1) Yoga layout 
2) Styles (width, height, flexDirection, alignItems,justifyContet,backgroundColor )
3) Custom bitmap text rendering


### Plan

To add tailwind like style classes to the components 

Current: 

```swift
button.style.justifyContent = .center
button.style.alignItems = .center
button.backgroundColor = Color.green

```

Below proposed addition will reduce the number of lines to just 1 in most cases

```swift
button.styles=["bg-blue-500","justify-center","items-center"]
```



## Installation/development steps:

// To do