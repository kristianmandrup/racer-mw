# Family notify helper

Used to notify family pipes of value change up and down the family tree. Avoids circular notification!
At each step, they should calculate a new value if dependent on notifer pipe value and is "dirty".
Only dirty if changed!