### What is the *method lookup path* and how is it important?

#### My answer

The method lookup path is an objects family tree of inheritance.
It traces back the parent superclasses that the object subclasses from, as well as modules that have been mixed in.
In Ruby, the method lookup path is used when calling a method.
Starting with the calling object, the method lookup path is traversed backwards until the method is found.
If a corresponding method is not found in the calling object's class or one of its ancestors, a NoMethodError is raised.

#### LS answer

The method lookup path is the order in which Ruby will traverse the class hierarchy to look for methods to invoke.
For example, say you have a Bulldog object called bud and you call: bud.swim.
Ruby will first look for a method called swim in the Bulldog class, then traverse up the chain of super-classes;
it will invoke the first method called swim and stop its traversal.
