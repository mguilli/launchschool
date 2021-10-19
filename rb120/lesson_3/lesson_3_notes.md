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

Instance variables are scoped at the object level.
Instance variables can be references in instance methods, even when initialized outside the instance method
Instance variable can be referenced in instance methods, even when not passed to the instance method
Referencing an instance variable that has not been initialized will return nil (instead of NameError with local var)

Class variables are scoped at the class level
All objects of a class share one copy of the class variable
Instance methods can access class variables
Class methods can access class variables, regardless of where it is initialized

Constant variables have lexical scope
