## Lecture 2 - Classes and Objects

BasicObject#== compares whether 2 objects are the same object
Cat.new == Cat.new renders false, because each instance is a unique object
Cat.new.name == Cat.new.name could return true if both cats have the same name, however.
This is because the String#== method is used when we compare strings

---

## Lecture 4 - Inheritance

### What is the *method lookup path* and how is it important?

#### My answer

The method lookup path is an objects family tree of inheritance.
It traces back the parent superclasses that the object subclasses from, as well as modules that have been mixed in.
In Ruby, the method lookup path is used when calling a method.
Starting with the calling object, the method lookup path is traversed backwards until the method is found.
If a corresponding method is not found in the calling object's class or one of its ancestors, a NoMethodError is raised.

---

## Lecture 6 - Polymorphism & Encapsulation

### Polymorphism

Polymorphism is when objects of different types can respond to the same message (method invocation)
The objects may respond in different ways to the message
But the client code doesn't care about the type of the object, only that it can respond to the message
When we don't care whay type of object is calling the method, we are using Polymorphism

#### Polymorphism through inheritance

Often polymorphism involves inheritance from a common superclass.
The public interface lets us work with different types in the same way, even though implementations can be different

```ruby
class Animal
  def move
  end
end

class Dog < Animal; end
class Bird < Animal; end

class Cat < Animal
  def move
    puts 'prowl'
  end
end

[Dog.new, Bird.new, Cat.new].each { |animal| animal.move }
```
Instead of providing a specific behavior for a method, we can acquire that behavior from the superclass
We can override the superclass method to provide specific implementation of an object's behavior

#### Polymorphism through duck typing

Duck Typing occurs when unrelated object types respond to the same method name
If an object quacks like a duck, then we can treat it as a duck
As long as the objects involved use the same method name and number or arguments, we can interact with them the same way

Duck typing is an informal way to classify or ascribe a type to objects

Just because two objects have a method with the same name and number of arguments doesnt mean polymorphism exists
Unless you are actually calling the method in a polymorphic way, there is no polymorphism
If there's no intention, there's no polymorphism

### Encapsulation

Encapsulation lets us only expose the methods and properties to which users of the object need need access
Method access control is used to expose these interfaces
Classes should have as few public interfaces as possible to protect data from undesired changes

---

## Lecture 8 - A Conceptual Model

> Classes don't define instance variables, they define attributes. 
> Instance variables do not exist prior to an object being created and a value being assigned to them.
> Yukihiro Matsumoto - *The Ruby Programming Language* 

## Lecture 9 - Collaborator Objects

Classes group common behaviors
Objects encapsulate state

Instance variables can be set to any object, even an object of a custom class
Objects stored as state in another object are 'collaborator objects'
Collaborator objects represent the connections between various actors in a program

Collaborator objects allow one to chop up a problem domain into cohesive pieces

### No Object is an Island - Blog Post

url: https://medium.com/launch-school/no-object-is-an-island-707e59ffedb4

Collaboration is a way of modeling relationships between different objects

A collaborative relationship is a relationship of association, not of inheritance

Association is a 'has-a' relationship. 
A library has books
A person has a pet

Collaboration happens when one object is added to the state of another object.
The collaborative relationship exists in the design (intention) of our code.

## Lecture 10 - Modules

In *single inheritance* a class can only sub-class from one superclass.
In *multiple inheritance* a class is allowed to directly inherit from multiple classes.

Ruby inheritance is singular
Ruby achieves mutliple inheritance by mixing in modules
