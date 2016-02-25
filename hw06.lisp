
#| CS 2800 Homework 6 - Spring 2016

Zach Walsh - walsh.z
Sacheverel Eldrid - eldrid.s

This homework is done in groups. The groups are normally the same
ones as in Assignment #5.  Changes can be made on request.
However, all such requests must be made two days before the
assignment is due, and all the students involved must agree to
the changes.

Question 1: Applying a substitution.

Below you are given a set of ACL2 terms and substitutions. Recall
that a substitution is a list of 2-element lists, where the first
element of each list is a variable and the second an
expression. Also, variables can appear only once as a left
element of a pair in any substitution. For example, the
substitution ((y (cons a b)) (x m)) maps y to (cons a b) and x to
m. For each term/substitution pair below, show what you get when
you apply the substitution to the term (i.e., when you
instantiate the term using the given substitution). 

a. (app x y)
   ((x (list nil)) (y (rev x)))

   (app (list nil) (rev x))
   
b. (in 'y x)
   ((x (cons a nil)) (y (cons nil b)))

   (in 'y (cons a nil))

c. (/ (- x (* y (len z))) (+ (len w) 12))
   ((x (* a b)) (y (- a b)) (z '(9 3 1)))

   (/ (- (* a b) (* (- a b) (len '(9 3 1)))) (+ (len w) 12))

d. (cons (sort (app x y)) x)
   ((x (list y)) (y (rev a)) (z (app b c)))

   (cons (sort (app (list y) (rev a))) (list y))

e. (or (endp x) (natlistp (app x (app y x))))
   ((x ()) (y (rest (rest a))) )

   (or (endp ()) (natlistp (app () (app (rest (rest a)) ()))))

f. (x (+ (- (len x) (len y)) (len z)) z (len (app 'z (app x y))))
   ((x '(a b)) (y nil) (z '(5 4 3 2)))

   ('(a b) (+ (- (len '(a b)) (len nil)) (len '(5 4 3 2))) '(5 4 3 2) (len (app 'z 
   (app '(a b) nil))))


Question 2: Finding a substitution, if it exists.  For each pair
of ACL2 terms, give a substitution that instantiates the first to
the second. If no substitution exists write "None".

a. (app a b)
   (app (sort x) (list x y)) 

 ((a (sort x)) (b (list x y)))

b. (app a (sort a))
   (app b (rev b))

 ((a b) ((sort a) (rev b)))
 ; there is no problem with this substitution because it happens simultaneously

c. (app (sort a) (rev b))
   (app (sort (cons a (list (first b)))) (rev (cons (+ (len (rest b)) a) nil)))

 ((a (cons a (list (first b)))) (b (cons (+ (len (rest b)) a) nil)))
 ; now, a represents a number and b represents a non-empty list.
 ; before, both were lists.

d. (app x y)
   (ap 2 3)

   none - you cannot replace function calls with an instantiation in ACL2s

e. (app x (app y (app z nil)))
   (app p (app (list 1 2) (app (list 3 4) ())))

 ((x p) (y (list 1 2)) (z (list 3 4)))

f. (/ a (+ (/ 1 b) (/ 1 c)))
   (/ (/ 1 (+ (/ 1 b) (/ 1 c))) (+ (/ 1 a) (/ 1 b)))

 ((a (/ 1 (+ (/ 1 b) (/ 1 c)))) (b a) (c b))

g. (app (list 1 2 a) (list 3 (list b) (list a)))
   (app (list 1 2 3) (list 3 (list (list 4 5)) (list 3)))

 ((a 3) (b (list 4 5)))

h. (cons x (app (list y z) w))
   (cons (- (pow 3 4) w) (app (list (- (pow 3 4) w)) (sort (list 3))))

 none - the first argument to app is a list with two elements, but 
 in the second expression, the first argument to app is a list of one
 element. There is no substitution that can accomplish this.


Questions 3 to 6 ask for equational proofs about ACL2
programs. In each question you will be given one or more function
definitions. The definitional axioms and contract theorems for
these functions can be used in the proof. All of the proofs you
are asked to do are trivial for ACL2s. You can use ACL2s to check
the conjectures you come up with, but you are not required to do
so. 

Here are some notes about equational proofs:

1. The context. Remember to use propositional logic to rewrite
the context so that it has as many hypotheses as possible.  See
the lecture notes for details [1]. Label the facts in your
context with C1, C2, ... as in the lecture notes.

2. The derived context. Draw a line after the context and add
anything interesting that can be derived from the context.  Use
the same labeling scheme as was used in the context. Each derived
fact needs a justification. Again, look at the lecture notes for
more information.

3. Use the proof format shown in class and in the lecture notes,
which requires that you justify each step [1].

4. When using an axiom, theorem or lemma, show the name of the
axiom, theorem or lemma, and then show the instantiation you are
using.

5. When using the definitional axiom of a function, the
justification should say "Def function name".  When using the
contract axiom of a function, the justification should say
"Contract function name".

6. Arithmetic facts such as commutativity of addition can be
used. The name for such facts is "arithmetic".

7. You can refer to the axioms for cons, consp, first and rest as
the "cons axioms". The axioms for if are named "if axioms" Any
propositional reasoning used can be justified by "propositional
reasoning", except that we will often use "MP" for modus
ponens. 

8. For this homework, you can only use theorems we explicitly
tell you you can use. You can use a preceding theorem even if you
have not succeeded in proving it. You can, of course, use the
definitional axiom and contract theorem for any function used or
defined in this homework. You can use any theorem we mention in
a *previous* problem. For example, for problem 7 you can use a
theorem mentioned in problem 5, but not the other way around.

Here is an example of an equational proof.

The definitions of listp and endp are in the lecture notes on
page 10 [2]:

(defunc listp (l)
  :input-contract t
  :output-contract (booleanp (listp l))
  (if (consp l)
      (listp (rest l))
    (equal l ())))

(defunc endp (l)
  :input-contract (listp l)
  :output-contract (booleanp  (endp l))
  (not (consp l)))

We also use this definition:

(defunc len2 (x)
  :input-contract (listp x)
  :output-contract (natp (len2 x))
  (if (endp x)
      0
    (+ 1 (len2 (rest x)))))

The definitional axiom for len2 is:

(implies (listp x)
         (equal (len2 x)
                (if (endp x)
                    0
                  (+ 1 (len2 (rest x))))))

The contract theorem for len2 is:

(implies (listp x)
         (natp (len2 x)))

Prove the following:

(implies (and (listp l)
              (not (endp l)))
         (>= (len2 l) 1))

Everything up to this point is given to you.  You must supply the
proof. Here is what it should look like:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Context:

C1. (listp l)
C2. (not (endp l))
------------------
C3. (listp (rest l))    {C1, C2, Def listp}

Proof:

  (len2 l)
=   { Def len2, instantiating ((x l)), if axioms, C2 }
  (len2 (rest l)) + 1
>=  { Contract len2, instantiating ((x l)), C3, arithmetic }
  0 + 1
=   { Arithmetic }
  1

QED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Notice that in a proof you may use infix notation for
arithmetic. In the proof above, we wrote
(len2 (rest l)) + 1 rather than (+ (len2 (rest l)) 1).

Also, notice that if you expand a function definition that
contains an if and you can determine whether the test is true or
false, then you can in one step show the true/false branch of the
if (but note the reason why in the hint justifying your move). 
You can do the same thing with a nested if or a cond.

Question 3 :

This question uses the this function from [3]:|#

(defunc a (m n)
  :input-contract (and (natp m) (natp n))
  :output-contract (natp (a m n))
  (cond ((equal m 0) (+ n 1))
        ((equal n 0) (a (- m 1) 1))
        (t (a (- m 1) (a m (- n 1))))))

;;a. Prove the following using equational reasoning:

(test? (implies (natp n)
         (equal (a 0 n) (+ 1 n))))

#|
C1: (natp n)

(a 0 n)
=  { Def a, instantiating ((x 1)), if axioms }
  (+ 1 n)
(equal (+ 1 n) (+ 1 n))
   { Identity property }
|#

;;b. Prove the following using equational reasoning:

(test? (implies (and (natp n)
              (equal n 0))
         (equal (a 1 n) (+ 2 n))))
#|
C1: (natp n)
C2: (equal n 0)

(a 1 n)
= {definition of a, instantiation, C2}
(cond ((equal 1 0) (+ 0 1))
      ((equal 0 0) (a (- 1 1) 1))
      (t (a (- 1 1) (a 1 (- 0 1)))))
= {if axioms, arithmatic}
(a 0 1)
= {definition of a, instantiation, if axioms, arithmatic}
2
= {arithmatic, C2}
(equal (2) (2))
|#


;;c. Prove the following using equational reasoning:

(test? (implies (and (natp n)
              (not (equal n 0))
              (implies (natp (- n 1)))
                       (equal (a 1 (- n 1)) (+ 2 (- n 1))))
         (equal (a 1 n) (+ 2 n))))

#|
C1: (natp n)
C2: (not equal n 0)
C3: (natp (- n 1))
C4: (equal (a 1 (- n 1)) (+ 2 (- n 1)))
------------------
C5: (> n 0) {C1, C2}

(equal (a 1 n) (+ 2 n))
= {definition of a, instantiation, if axioms, arithmatic}
(equal (a (0 (a 1 (- n 1)))) (+ 2 n))
= {c4}
(equal (a 0 (+ 2 (- n 1))) (+ 2 n))
= {definition of a, instantiation, if axioms}
(equal (+ 1 (+ 2 (- n 1))) (+ 2 n))
= {arithmatic
(equal (+ 2 n) (+ 2 n))
= {equal definition, instantiation}
t


|#

#|
d. Fill in the ...'s below so that the resulting formula is a
theorem.

The first ... is the what you get from contract completion. See
the lecture notes if you need a reminder of what contract
completion is. Contract completion should not include any
unnecessary terms.

For the second ..., you cannot use the function "a" in your
answer, e.g., you cannot simply replace ... by "(a 2 n)". The
... has to be replace by an arithmetic expression, i.e., an
expression involving arithmetic functions we have already
seen(such as +, -, *, and /).

Note that you do not have to prove anything.


Question 4 :

a. Perform contract completion on the formula below.

(implies (and (listp l)
              (consp l))
         (equal (len2 (rest l)) (- (len2 l) 1)))



b. Prove the the formula from 4a using equational reasoning:

Context. 

C1. (listp l)
C2. (consp l)
-------------
C3. (listp (rest l))             {C1, C2, def listp}
C4. (not (endp l))               {C1, C2, def endp}

(- (len2 l) 1)

= (- (+ 1 (len2 (rest l))) 1)    {def len2, instantiating ((x l)), def endp, C4, if axioms}

= (len2 (rest l))                {arithmetic}

(equal (len2 (rest l)) (len2 (rest l)))

= true {propositional logic}

c. Perform contract completion on the formula below, where app is
the append function defined in your lecture notes.

(implies (listp y)
         (equal (len2 (app (list x) y))
                (len2 (app y (list x)))))
                
#|Question 5 :

We use the following function definition:
|#

(defunc app2 (x y)
  :input-contract (and (listp x) (listp y))
  :output-contract (listp (app2 x y))
  (if (endp x)
    y
    (cons (first x) (app2 (rest x) y))))

#|In addition to the definitional axioms and contract theorems 
for the function definitions above, you may also use this
theorem, which is also easily proven by ACL2s:

Length theorem for app2:
|#
(test? (implies (and (listp x) (listp y))
         (equal (len2 (app2 x y))
                (+ (len2 x) (len2 y)))))


;;a. Perform contract completion on the formula below.

(test? (implies (listp x)
         (equal (app2 nil x) x)))


;;b. Prove the formula from 5a using equational reasoning.

#|
C1: (listp x)

(equal (app2 nil x) x)
= {app2 definition, instantiation, if axioms}
(equal x x)
= {equal definition, instantiation}
t
|#

;;c. Perform contract completion on the formula below.

(test? (implies (listp x)
         (implies (endp x)
                  (equal (app2 x nil) x))))

;;d. Prove the formula from 5c using equational reasoning.

#|
C1: (listp x)
C2: (endp x)
---------
C3: x = nil {C1, C2}

(equal (app2 x nil) x)
= {definition of app2, instantiation, if axioms}
(equal nil x)
= {definition of equal, instantiation, C3}
t
|#

;;e. Perform contract completion on the formula below.

(test? (implies (listp x)
         (implies (and (not (endp x))
                       (implies (listp (rest x))
                                (equal (app2 (rest x) nil) (rest x))))
                  (equal (app2 x nil) x))))

;;f. Prove the formula from 5e using equational reasoning.

#|
C1: (listp x)
C2: (not (endp x))
C3: (listp (rest x))
C4: (equal (app2 (rest x) nil) (rest x))

(equal (app2 x nil) x)
= {definition of app2, instantiation, if axioms}
(equal (cons (first x) (app2 (rest x) nil)) x)
= {C4}
(equal (cons (first x) (rest x)) x)
= {definition of cons, instantiation}
(equal x x)
= {definition of equal, instantiation, if axioms}
t
|#

;;g. Perform contract completion on the formula below.

(test? (implies (and (listp x)
              (listp y)
              (listp w)
              (listp z))
         (equal (len2 (app2 (app2 x y) (app2 w z)))
                (len2 (app2 z (app2 w (app2 y x)))))))

;;h. Prove the formula from 5g using equational reasoning.

#|
C1: (listp x)
C2: (listp y)
C3: (listp w)
C4: (listp z)

(equal (len2 (app2 (app2 x y) (app2 w z)))
       (len2 (app2 z (app2 w (app2 y x)))))
= {length theorem for app2, instantiation}
(equal (+ (len2 (app2 x y)) (len2 (app2 w z)))
       (+ (len2 z) (len2 (app2 w (app2 y x)))))
= {length theorem for app2, instantiation}
(equal (+ (+ (len2 x) (len2 y)) (+ (len2 w) (len2 z)))
       (+ (len2 z) (+ (len2 w) (+ (len2 y) (len2 x)))))
= {associative property of addition}
(equal (+ (+ (len2 x) (len2 y)) (+ (len2 w) (len2 z)))
       (+ (+ (len2 x) (len2 y)) (+ (len2 w) (len2 z))))
= {definition of equal, instatiation, if axioms}
t
|#


Question 6 : 

We use the following function definition:

(defunc rev2 (x)
  :input-contract (listp x) 
  :output-contract (listp (rev2 x))
  (if (endp x)
      nil
    (app2 (rev2 (rest x)) (list (first x)))))

a. Perform contract completion on the formula below.

(implies (listp l)
         (implies (endp l)
              (equal (len2 (rev2 l))
                 (len2 l))))

b. Prove the formula from 6a using equational reasoning.

(implies (and (listp l)
              (endp l))
         (equal (len2 (rev2 l))
                (len2 l))) {via extraction}

Context:

C1. (listp l)
C2. (endp l)
-------------
C3. (equal l nil)   {C1, C2, def endp}

LHS: 
(len2 (rev2 l)) 
= (len2 nil)        {C3, def rev2, if axioms}
= (len2 l)          {C3}

(equal (len2 l) (len2 l))
= true {PL}
                

c. Perform contract completion on the formula below.

(implies (listp l)
         (implies (and (not (endp l))
                       (implies (listp (rest l))
                                (equal (len2 (rev2 (rest l)))
                                       (len2 (rest l)))))
                  (equal (len2 (rev2 l))
                         (len2 l))))

d. Prove the formula from 6c using equational reasoning.
(implies
(implies (and (listp l) (not (endp l)))
         (implies (listp (rest l))
                                (equal (len2 (rev2 (rest l)))
                                       (len2 (rest l)))))
         (equal (len2 (rev2 l))
                         (len2 l)))

Context:

C1. (listp l)
C2. (not (endp l))
------------------
C3. (listp (rest l)) {C1, C2, def listp}
C4. (equal (len2 (rev2 (rest l)))
           (len2 (rest l)))    {C3, MP}
           
           
 now, we simplify to:
 (implies
     (and (listp l) (not (endp l)) (listp (rest l)) (equal (len2 (rev2 (rest l)))
                                                           (len2 (rest l))))
     (equal (len2 (rev2 l))
            (len2 l)))
            
LHS:
(len2 (rev2 l))
= (len2 (app2 (rev2 (rest l)) (list (first l))))       {def rev2, if axioms, C2}
= (+ (len2 (rev2 (rest l))) (len2 (list (first l))))   {length theorem for append}
= (+ (len2 (rev2 (rest l))) (+ 1 (len2 nil)))          {def len2, def endp, if axioms, first-rest axioms}
= (+ (len2 (rev2 (rest l))) (+ 1 0))                   {def len2, endp, if axioms}
= (+ 1 (len2 (rev2 (rest l))))                         {arithmetic, commutative property of addition}
= (+ 1 (len2 (rest l)))                                {C4}
= (len2 (cons (first l) (rest l)))                     {def len2, if axioms, def endp}
= (len2 l)                                             {first-rest axioms}

(equal (len2 l) (len2 l))
= true {PL}


Question 7:

Consider the following  definitions:

(defunc add-second (a l)
  :input-contract (listp l)
  :output-contract (listp (add-second a l))
  (if (endp l)
      nil
    (cons (list (first l) a)
          (add-second a (rest l)))))

(defunc prod (x y)
  :input-contract (and (listp x) (listp y))
  :output-contract (listp (prod x y))
  (if (endp y)
      nil
    (app2 (add-second (first y) x) 
          (prod x (rest y)))))


7a. Prove the following:

(implies (and (listp x)
              (listp y))
         (and (implies (endp y)
                       (equal (len2 (prod x y))
                              (* (len2 x) (len2 y))))
              (implies (and (not (endp y))
                            (implies (and (listp x)
                                          (listp (rest y)))
                                     (equal (len2 (prod x (rest y)))
                                            (* (len2 x) (len2 (rest y))))))
                       (equal (len2 (prod x y))
                              (* (len2 x) (len2 y))))))

You can assume that the following is a theorem:

add-second thm:
(implies (listp l)
         (equal (len2 (add-second a l))
                (len2 l)))

Hint: Break up the proof into two parts and carefully construct
the context. 

This expression is equivalent to:

(and (implies (and (listp x) (listp y) (endp y))
              (equal (len2 (prod x y))
                     (* (len2 x) (len2 y))))
     (implies (and (listp x) 
                   (listp y) 
                   (not (endp y))
                   (implies (and (listp x) (listp (rest y)))
                            (equal (len2 (prod x (rest y)))
                                   (* (len2 x) (len2 (rest y))))))
              (equal (len2 (prod x y))
                     (* (len2 x) (len2 y)))))
                     
This proof can be thought of in two parts: the first and second implies in the large and.

Part 1: 
(implies (and (listp x) (listp y) (endp y))
         (equal (len2 (prod x y))
                (* (len2 x) (len2 y))))
                
Context:

C1. (listp x)
C2. (listp y)
C3. (endp y)
-------------
C4. (equal y nil) {def endp, C3}

LHS: 
(len2 (prod x y))
= (len2 nil)                {def prod, C4, if axioms}
= 0                         {def len2, if axioms}
= (* (len2 x) 0)            {arithmetic, zero prop. of mult}
= (* (len2 x) (len2 y))     {def len2, C4, if axioms}

(equal (* (len2 x) (len2 y)))
       (* (len2 x) (len2 y)))
= true {PL}


Part 2:

(implies (and (listp x) 
              (listp y) 
              (not (endp y))
              (implies (and (listp x) (listp (rest y)))
                       (equal (len2 (prod x (rest y)))
                              (* (len2 x) (len2 (rest y))))))
          (equal (len2 (prod x y))
                 (* (len2 x) (len2 y)))))
                     
Context:

C1. (listp x)
C2. (listp y)
C3. (not (endp y))
C4. (implies (and (listp x) (listp (rest y)))
             (equal (len2 (prod x (rest y)))
                    (* (len2 x) (len2 (rest y)))))
----------------------------------------------------
C5. (listp (rest y)) {def listp, C2, C3}
C6. (equal (len2 (prod x (rest y)))
           (* (len2 x) (len2 (rest y)))) {C1, C4, C5, MP}
           
LHS: 
(len2 (prod x y))

= (len2 (app2 (add-second (first y) x)
              (prod x (rest y))))                  {def prod, C3, if axioms}
= (+ (len2 (add-second (first y) x))
     (len2 (prod x (rest y))))                     {length theorem for app2}
= (+ (len2 x)
     (len2 (prod x (rest y))))                     {add-second thm}
= (+ (len2 x)
     (* (len2 x) (len2 (rest y))))                 {C6}
= (* (len2 x) (+ 1 (len2 (rest y))))               {arithmetic}
= (* (len2 x) (len2 (cons (first y) (rest y))))    {def len2, if axioms, def endp}
= (* (len2 x) (len2 y))                            {cons axioms}

(equal (* (len2 x) (len2 y))
       (* (len2 x) (len2 y)))
= true {PL}



Combining parts one and two:

(and true true)
= true {PL}

QED


7b. Perform contract completion on the formula below.

(implies (and (listp x) (listp y))
         (equal (len2 (prod x (cons z y)))
                (len2 (app2 (prod y x) (prod (list y) x)))))

7c. Prove the formula from 7b using equational reasoning.

You can assume that the following is a theorem:

prod-len2 theorem:
(implies (and (listp a) (listp b))
         (equal (len2 (prod a b)) (* (len2 a) (len2 b))))

Context:
C1. (listp x)
C2. (listp y)

LHS:
(len2 (prod x (cons z y)))
= (* (len2 x) (len2 (cons z y)))                          {prod-len2 thm}
= (* (len2 x) (+ 1 (len2 y)))                             {def len2, def endp, if axioms}
= (+ (len2 x) (* (len2 x) (len2 y)))                      {arithmetic - distributive property}
= (+ (* 1 (len2 x)) (* (len2 y) (len2 x)))                {arithmetic - commut. add., mult. ident.}
= (+ (* (len2 (list y)) (len2 x)) (* (len2 y) (len2 x)))  {def len2, if axioms, def endp}
= (+ (len2 (prod (list y) x)) (len2 (prod y x)))          {prod-len2 thm}
= (+ (len2 (prod y x)) (len2 (prod (list y) x)))          {arithmetic - commut. add.}
= (app2 (prod y x) (prod (list y) x))                     {length thm for app2}

(equal (app2 (prod y x) (prod (list y) x))
       (app2 (prod y x) (prod (list y) x)))
= true                                                    {PL}
         




[1] http://www.ccs.neu.edu/home/pete/courses/Logic-and-Computation/2016-Spring/rapeq.pdf

[2]  

[2] Raphael M. Robinson, "Recursion and Double Recursion". 
Bulletin of the American Mathematical Society 54 (10):
987–93. doi:10.1090/S0002-9904-1948-09121-2. 1948. |#