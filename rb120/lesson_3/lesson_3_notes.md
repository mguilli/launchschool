## TODO: Make Cards

## Equivalence

- `==` compares the value of two objects
  - Defined in the BasicObject class two test if two objects are the same object
  - Overridden in subclasses to test for value
- `equal?` compares both value and object id
- `===` tests if one object belongs to the group of another object
  - Used implicitly by case statements
- `eql?` tests if two objects have the same value and are of the same class
  - Used implicitly by `Hash` to test equality among its members

## Variable Scope

### Instance variables

Instance variables are scoped at the object level.
Instance variables can be references in instance methods, even when initialized outside the instance method
Instance variable can be referenced in instance methods, even when not passed to the instance method
Referencing an instance variable that has not been initialized will return nil (instead of NameError with local var)

### Class Variables

Class variables are scoped at the class level
All objects of a class share one copy of the class variable
Instance methods can access class variables
Class methods can access class variables, regardless of where it is initialized

***Subclasses share class variables with their superclass!!! 
When a subclass overwrites a class variable, it changes the value of the variable in the superclass as well*** 

### Constants

Constant variables have lexical scope
A constant initialized in a superclass is inherited by the subclass
Constants can be accessed by both class and instance methods
Constant resolution will look at the lexical scope first, and then traverse the inheritance hierarchy

## Exceptions

[Blog Post](https://launchschool.medium.com/getting-started-with-ruby-exceptions-d6318975b8d1) 

Exceptions such as `TypeError` are actually objects subclassed from the `Exception` class
Exceptions are *handled* once they are *raised* 

Most often, errors you would want to handle are descendents of the `StandardError` class
Handling all `StandardError` exceptions can mask critical errors and make debugging more difficult
It is important to be specific about which errors you want to handle
You never want to rescue the `Exception` class itself

The `ensure` clause in a rescue block runs whether or not an exception is raised (e.g. file closing)
If the code in an `ensure` clause raises an exception, it can mask exceptions raised earlier in execution

Exceptions can be manually raised with Kernel#raise
If you do not specify the exception type, Ruby will default to a `RuntimeError` exception
Custom exceptions can be created by subclassing from an existing error class (usually `StandardError`)
