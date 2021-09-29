## Lecture 2

BasicObject#== compares whether 2 objects are the same object
Cat.new == Cat.new renders false, because each instance is a unique object
Cat.new.name == Cat.new.name could return true if both cats have the same name, however.
This is because the String#== method is used when we compare strings
