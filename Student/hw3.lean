/-!
# Homework #3

Near final DRAFT. 

## Overview and Rules

The purpose of this homework is to strengthen your
understanding of function composition and of enumerated
and product data types. 

The collaboration rule for this homework is that
you may *not* collaborate. You can ask friends and
colleagues to help you understand material in the
class notes, but you may not discuss any aspect
of this homework itself with anyone other than one
of the instructors or TAs. Why? Because *you* need
to learn this material to pass the exam to come.
-/

/-!
## Problem #1

Define a function of the following polymorphic type:
{α β γ : Type} → (β → γ) → (α → β) → (α → γ). Call it
*funkom*. After the implicit type arguments it should
take two function arguments and return a function as
a result. 
-/

-- Answer below
def funkom {α β γ : Type}: (β → γ) → (α → β) → (α → γ)
| f, g => (fun (a: α) => f (g a))



/-! 
## Problem #2

Define a function of the following polymorphic type:
{α β : Type} → (a : α) → (b : β) → α × β. Call it mkop.
-/

-- Answer below
def mkop {α β : Type} (a : α) (b : β) : α × β :=
(a, b)



/-! 
## Problem #3

Define a function of the following polymorphic type:
{α β : Type} → α × β → α. Call it op_left.
-/

-- Answer below

def op_left {α β : Type} : α × β → α 
| (a, _) => a




/-! 
## Problem #4

Define a function of the following polymorphic type:
{α β : Type} → α × β → β. Call it op_right.
-/

-- Answer below
def op_right {α β : Type} : α × β → β 
| (_, b) => b

/-! 
## Problem #5

Define a data type called *Day*, the values of which
are the names of the seven days of the week: *sunday,
monday,* etc. 

Some days are work days and some days are play
days. Define a data type, *kind*, with two values,
*work* and *play*.

Now define a function, *day2kind*, that takes a *day*
as an argument and returns the *kind* of day it is as
a result. Specify *day2kind* so that weekdays (monday
through friday) are *work* days and weekend days are
*play* days.

Next, define a data type, *reward*, with two values,
*money* and *health*.

Now define a function, *kind2reward*, from *kind* to 
*reward* where *reward work* is *money* and *reward play* 
is *health*.

Finally, use your *funkom* function to produce a new
function that takes a day and returns the corresponding
reward. Call it *day2reward*.

Include test cases using #reduce to show that the reward
from each weekday is *money* and the reward from a weekend
day is *health*.
-/
-- Definition of Day data type
inductive Day : Type 
| monday : Day
| tuesday : Day
| wednesday : Day
| thursday : Day
| friday : Day
| saturday : Day
| sunday : Day

open Day

-- Definiition of the kind data type
inductive Kind : Type
| work : Kind
| play : Kind

open Kind
-- Definition of day2kind function
def day2kind (d : Day) : Kind :=
match d with 
| monday    => Kind.work
| tuesday   => Kind.work
| wednesday => Kind.work
| thursday  => Kind.work
| friday    => Kind.work
| _             => Kind.play

-- Definition of the reward data type 
inductive Reward : Type
| money : Reward
| health : Reward

open Reward 
-- Definition of the kind2reward function
def kind2reward: Kind → Reward
| work => money
| play => health

-- Definition of the day2reward function
def day2reward := funkom kind2reward day2kind

-- Test cases
#reduce day2reward monday        -- Should output: money
#reduce day2reward tuesday       -- Should output: money
#reduce day2reward wednesday     -- Should output: money
#reduce day2reward thursday      -- Should output: money
#reduce day2reward friday        -- Should output: money
#reduce day2reward saturday      -- Should output: health
#reduce day2reward sunday        -- Should output: health



/-!

## Problem #6

### A. 
Consider the outputs of the following #check commands. 
-/

#check Nat × Nat × Nat
#check Nat × (Nat × Nat)
#check (Nat × Nat) × Nat

/-!
Is × left associative or right associative? Briefly explain
how you reached your answer.

Answer here: It is right associative as the first 2 #check lines 
have the expected type unlike the 3rd #check line. Without writing 
the grouping, lean computes the right most pair first. 

### B.
Define a function, *triple*, of the following type:
{ α β γ : Type } → α → β → γ → (α × β × γ)  
-/

-- Here:
def triple {α β γ : Type} (a : α) (b : β) (c : γ) : α × β × γ :=
  (a, b, c)


/-!
### C.
Define three functions, call them *first*, *second*, 
and *third*, each of which takes any such triple as
an argument and that returns, respectively, its first,
second, or third elements.
-/

-- Here:
def first {α β γ : Type} : α × β × γ → α
| (a, _, _) => a

def second {α β γ : Type} : α × β × γ → β
| (_, b, _) => b

def third {α β γ : Type} : α × β × γ → γ
| (_, _, c) => c


/-!
### D.
Write three test cases using #eval to show that when 
you apply each of these "elimination" functions to a
triple (that you can make up) it returns the correct
element of that triple.  
-/

-- Here:
-- Define a sample triple
def sampleTriple : Nat × String × Bool :=
  (54, "Hello", true)

-- Test cases
#eval first sampleTriple   -- Should output: 54
#eval second sampleTriple  -- Should output: "Hello"
#eval third sampleTriple   -- Should output: true

/-!
### E.
Use #check to check the type of a term. that you make 
up, of type (Nat × String) × Bool. The challenge here
is to write a term of that type. 
-/

def exampleTerm : (Nat × String) × Bool :=
  ((54, "Hello"), true)

#check exampleTerm




