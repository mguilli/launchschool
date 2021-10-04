## Object Oriented Programming with Ruby

Author: Launch School Open Bookshelf

#### Definitions

**Encapsulation**
Hiding the state of an object to prevent unintentional access
Example: private object methods can only be access from by the object itself

**Polymorphism**
The ability for different data types to respond to a common interface (method invocation).
Example: Using a Speak module, both Cat and Dog objects could be made to respond to a `speak` method invocation

**Inheritance** 
*Subclasses* can inherit behaviors of a *superclass* 

**Mixin** 
including a module in a class to make its behaviors available to the class's objects

**Module** 
A special version of a class that only shares behaviors, but not state. An object cannot be created from a Module
A collection of behaviors usable in other classes via mixins
Also used as a namespace

**Instantiation** 
The process of creating a new object or instance from a class
We instantiate an object named `sparky` from the `GoodDog` class
The `new` method is called on a class to instantiate a new object of that class

**Override**
Forcing different behavior from an existing method in a superclass by redefining it in a subclass

**DRY**
Don't Repeat Yourself. A directive to reduce code duplication where possible in a codebase

**Namespacing** is grouping related classes inside a module

**interface** is an objects public methods: how other objects can interact with this object

### The Object Model

#### What are objects?

In Ruby, methods, blocks, and variables are among the few things that are not objects.
If classes are molds, objects are what are produced from those molds.

#### Modules

A module is a collection of behaviors, whereas a class also stores state.
Modules are made available to a class by using the `include` method invocation
including a module is like copy-pasting its methods into a class

```
module Speak
  def speak
    puts 'hello'
  end
end

class Human
  include Speak
end

class Dog
  include Speak
end

Human.new.speak # => 'hello'
Dog.new.speak   # => 'hello'
```

#### Method Lookup

`ancestors` can be used to find a method's lookup path

---

### Classes and Objects - Part 1

**States** track attributes for individual objects
Instance variables are scoped at the object level and keep track of state
Instance variables exist as long as the object instance exists
Instance variables tie data to objects
Every object's state is unique
instance variables are prefixed with the `@` symbol (ex: `@name`, `@date`)

**Behaviors** are what objects are capable of doing
Instance methods provide an object's behaviors.
Instance methods are defined in a class and available to objects (instances) of that class.
All objects of the same class have the same behaviors, though they contain different states

**constructor** is a subroutine called to create an object.
The `initialize` method is the ruby constructor
The `initialize` method is called each time a new object is created.

**Accessor methods** are ruby idioms that shortcut manually writing getter and setter instance methods 
Setter methods always return the value that is passed in as an argument.
Explicit return values are ignored for setter methods
Accessor methods take symbols as arguments (ex: `attr_reader :name, :date, :balance`)

It is preferrable to call a getter method (if defined) rather than referencing the instance variable directly
It is easier to mask data in the getter method, than to format the return value of the getter method where it is called

Explicit `self` must be used to access setter methods within a class definition.
`self.name = 'bob'` rather than `name = 'bob'`
Without explicit `self`, ruby interprets `name = 'bob'` as creating a new local variable `name`

---

### Classes and Objects - Part 2

**Class methods** are methods we can call directly on the class without creating an object 
Class methods are prepended with the `self` keyword
Class methods are where we put general functionality that doesn't deal with individual object's state

**Class variables** are variables used to track a class-level detail the does not pertain to individual objects
Created using two @@ symbols
Can be accessed from within an instance method

**Constants** can be created in class definitions for data that does not change between objects

#### The to_s method

The `to_s` method is build into every class in Ruby
`puts` method calls `to_s` for any argument that is not an array
`to_s` is called automatically during string interpolation

The `p` method is different, as it calls the `inspect` method on the object
`p sparky` is equivalent to `puts sparky.inspect`

`to_s` can be overridden to customize string output for objects
`inspect` should not be overridden, as it is used for debugging

#### `self`

What `self` references changes based on the scope it is used in
Is a way of being explicit about what code is referencing and what our intentions are as far as behavior.

1. inside of an instance method, `self` references the instance (object) that called the method - the *calling object* 
2. outside an instance method, `self` references the class, and is used to define class methods

For the following class and object: `sparky = GoodDog.new`,

1. Calling `self.name` inside in instance method is the same as calling `sparky.name` on the object
2. Calling `self.name` outside an instance method is the same as calling `GoodDog.name` on the class

### Inheritance

Inheritance is a way to extract common behaviors from classes and move them to a common superclass

#### Class Inheritance

The `<` symbol is used to signify that a class inherits from it's superclass
`class Dog < Animal`

You can **override** a superclass's method by defining a method with the same name in the subclass.
Override works because Ruby starts searching for a method in the Object's class first before moving up the lookup path 
Inheritance is useful to keep remove duplication and keep code **DRY** (Don't Repeat Yourself)

#### super

When super is called from within a method, Ruby searches the lookup path for a method with the same name

`super` automatically forwards argument passed to the method to the superclass
`super(x,y)` called with specific arguments will send only the specified arguments to the superclass
`super()` called with empty parentheses will forward no arguments to the superclass


  ```ruby
  def speak(greet, introduce, describe)
    super # is the same as super(greet, introduce, describe)
  end
  ```
#### Mixing in Modules

Modules allow us to mix in common behaviors across different classes.

#### Inheritance vs Modules

Types of inheritance
  - **Class inheritance**
    - where one class inherits the behaviors of the superclass
    - the result is a specialized type of the superclass
  - **interface inheritance**
    - where one class inherits the behaviors of the mixed in module
    - the result is *not* a specialized type of the module, it merely gains behaviors

When to use a class vs a module
  - You can only inherit from on superclass
  - You can have multiple module mixins
  - Class is the choice for an 'is-a' relationship. A cat is an animal. A pilot is a human.
  - Module is the choice for a 'has-a'('can') relationship. A cat can purr. A pilot can fly.
  - You cannot create an object from a Module (no instantiation ability)
  - Modules are used for namespacing (grouping common methods together)

#### Method Lookup Path

The general lookup path for any object is `[(object itself), Object, Kernel, BasicObject]`
Modules are included in the lookup path in reverse order (i.e. the last included module first)
Modules included in a superclass are included in the lookup path of subclasses

#### More modules

**Namespacing** is grouping related classes inside a module
Advantages of namespacing:
  - Makes it easier to recognize related classes
  - Reduces chance of name collision with similarly names classes

To namespace classes:

```ruby
module Mammal
  class Dog
    def speak; end
  end

  class Cat; end
end
```
To access namespaced classes:

```ruby
buddy = Mammal::Dog.new
buddy.speak
kitty = Mammal::Cat.new
```

Module methods are methods housed in a container
Useful for grouping methods that seem out of place elsewhere in code

To define a container for methods:

```ruby
module Mammal
  def some_method; end
end
```

This way, methods can be called directly from the module: `value = Mammal.some_method` or `Mammal::some_method`

#### Private, Protected, and Public

Method Access Control is restricting access to methods defined in a class
Method Access Control is implemented through the use of access modifiers
Ruby access modifiers are `public`, `private`, and `protected`
Methods are public by default

Public methods comprise and object's interface
Private methods are only available from other methods in the class
Private methods can not be accessed by instances of the class, only the class itself
Protected methods behave like public methods from inside the class
Protected methods behave like private methods from outside the class
Protected methods can be called by other instances of the same class

Before Ruby 2.7, cannot use explicit self for private methods inside the class.

#### Accidental method overriding

Every class you create inherently subclasses from the `Object` class
Methods defined in the `Object` class are available in all classes
The `Object` class provides general functionality through its methods
Overriding a method in the `Object` class can have devastating effects in code
The one safe `Object` method that can be overridden is the `to_s` method

