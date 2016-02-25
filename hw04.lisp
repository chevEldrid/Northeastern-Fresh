; **************** BEGIN INITIALIZATION FOR ACL2s B MODE ****************** ;
; (Nothing to see here!  Your actual file is after this initialization code);

#|
Pete Manolios
Fri Jan 27 09:39:00 EST 2012
----------------------------

Made changes for spring 2012.


Pete Manolios
Thu Jan 27 18:53:33 EST 2011
----------------------------

The Beginner level is the next level after Bare Bones level.

|#

; Put CCG book first in order, since it seems this results in faster loading of this mode.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading the CCG book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "ccg/ccg" :uncertified-okp nil :dir :acl2s-modes :ttags ((:ccg)) :load-compiled-file nil);v4.0 change

;Common base theory for all modes.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s base theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "base-theory" :dir :acl2s-modes)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "custom" :dir :acl2s-modes :uncertified-okp nil :ttags :all)

;Settings common to all ACL2s modes
(acl2s-common-settings)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading trace-star and evalable-ld-printing books.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "trace-star" :uncertified-okp nil :dir :acl2s-modes :ttags ((:acl2s-interaction)) :load-compiled-file nil)
(include-book "hacking/evalable-ld-printing" :uncertified-okp nil :dir :system :ttags ((:evalable-ld-printing)) :load-compiled-file nil)

;theory for beginner mode
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s beginner theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "beginner-theory" :dir :acl2s-modes :ttags :all)


#+acl2s-startup (er-progn (assign fmt-error-msg "Problem setting up ACL2s Beginner mode.") (value :invisible))
;Settings specific to ACL2s Beginner mode.
(acl2s-beginner-settings)

; why why why why 
(acl2::xdoc acl2s::defunc) ; almost 3 seconds

(cw "~@0Beginner mode loaded.~%~@1"
    #+acl2s-startup "${NoMoReSnIp}$~%" #-acl2s-startup ""
    #+acl2s-startup "${SnIpMeHeRe}$~%" #-acl2s-startup "")


(acl2::in-package "ACL2S B")

; ***************** END INITIALIZATION FOR ACL2s B MODE ******************* ;
;$ACL2s-SMode$;Beginner
#|

CS 2800 Homework 4 - Spring 2016

This homework is done in groups. The groups are normally the same ones as in 
Assignment #3.  Changes can be made on request.  However, all such requests
must be made two days before the assignment is due, and all the students 
involved must agree to the changes.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw04.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. If you comment out any pre-existing text in this
  file, then give a brief explanation, such as "The test failed".

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. If a test fails, comment it out but give a brief
  explanation such as "The test failed". Comments should also be used for
  any English text that you may add. This file already contains many
  comments, so you can see what the syntax is.

- when done, save your file and submit it as hw04.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.

Instructions for programming problems:

For each function definition, you must provide both contracts and a body.

As in hw03, you will be programming some functions.  If one or more check=
tests are provided, then you must add more check= tests.  Your check= tests
are in addition to the check= tests provided.  Make sure you produce
sufficiently many new check= test cases.  This means: cover at least the
possible scenarios according to the data definitions of the involved
types. For example, a function taking two lists should have at least 4
additional check= tests: all combinations of each list being empty and
non-empty. Each datatype should have at least 2 additional check= tests.

Beyond that, the number of tests should reflect the difficulty of the
function. For very simple ones, the above coverage of the data definition
cases may be sufficient. For complex functions with numerical output, you
want to test whether it produces the correct output on a reasonable
number if inputs.

If the function asks for a test? or a thm, then follow the instructions
for that function.  No check= tests are required for such functions.

IMPORTANT NOTICE ABOUT YOUR TEST CASES

It is a violation of academic integrity to publish or discuss your test
cases.  These are part of the solution to your assignment.  Copying or
allowing one to copy your test cases is therefore unacceptable.  Please
be careful to prevent your solutions from being seen by other students.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Propositional Logic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

We use the following ASCII character combinations to represent the Boolean
connectives:

  NOT     ~

  AND     /\
  OR      \/

  IMPLIES =>

  EQUIV   =
  XOR     <>

The binding powers of these functions are listed from highest to lowest
in the above table. Within one group (no blank line), the binding powers
are equal. This is the same as in class.

|#

#|

Construct the truth table for the following Boolean formulas. Use
alphabetical order for the variables in the formula, and create columns
for all variables occurring in the formula AND for all intermediate
subexpressions. For example, if your formula is

(p => q) \/ r

your table should have 5 columns: for p, q, r, p => q, and (p => q) \/ r .

Then decide whether the formula is satisfiable, unsatisfiable, valid, or
falsifiable (several of these predicates will hold!).

1. p /\ q <> q \/ p => ~p

...

2. p <> ~q \/ (q => r) /\ ~p \/ r

Hint: your table should have 10 columns (including those for p,q,r).

...

3. (p => q) /\ ~r /\ ~(q \/ ~p)

...

4. p /\ q = q \/ p => ~p

...

|#

#|

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Problem solving using propositional logic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

5. Sudoku is a popular puzzle.  Binary Sudoku is a variation on Sudoku.
Consider this variation on Binary Sudoku.  It is played on a 4x4 grid.
Each entry in the grid is either 0 or 1.  Some of the entries in the grid
may be filled in at the start.  You must fill in the rest so that every
row and column has an equal number of 0s and 1s, and also so that each of
the four 2x2 subgrids have an equal number of 0s and 1s.

Formalize this puzzle as a satisfiability problem.

(a) Define propositional variables for each entry in the puzzle.

  Each entry in the grid is denoted by its position, like so:
  
  ++--+--++--+--++
  ||00|01||02|03||
  ++--+--++--+--++
  ||10|11||12|13||
  ++--+--++--+--++
  ||20|21||22|23||
  ++--+--++--+--++
  ||30|31||32|33||
  ++--+--++--+--++
  
  Each entry has two corresponding boolean variables, a and b, denoted
  by the number associated with the entry, as in a00 and b20, etc.
  a is true if the entry is a zero, and b is true if the entry is a one.
  
  So for the following grid:
  
  ++--+--++--+--++
  ||0 |1 ||0 |1 ||
  ++--+--++--+--++
  ||1 |0 ||1 |0 ||
  ++--+--++--+--++
  ||0 |1 ||0 |1 ||
  ++--+--++--+--++
  ||1 |0 ||1 |0 ||
  ++--+--++--+--++
  
  a00 would be true, a10 would be false, and b10 would be true.

(b) Using these variables, specify the constraints as a propositional
formula.  For the moment assume that none of the entries has been filled.

 Since only a or b can be true for any cell: 
 
 for each i and j, (aij xor bij) is true.

 Since there must be two 1s and two 0s in each row, column and subgrid:
 
  we can xor together all b's for that group, which would only yield
  true if the number of 1s is odd. Then, we can take the not of this,
  ensuring an even number of 1s. Then, we can and this together with 
  the not of the ands of all of these b's (to ensure that not all are 
  ones) and the or of all of these b's (to ensure that at least one is
  a one). The only possible solution that yields true for this would
  be a solution where exactly two of the variables are true. What this
  looks like:
  
  ~(b00 xor b01 xor b02 xor b03) /\ ~(b00 /\ b01 /\ b02 /\ b03) /\
   (b00 \/ b01 \/ b02 \/ b03)
   
   The formula for the whole puzzle involves creating such an expression
   for each subgroup (row, column, and subgrid) and anding them all 
   together, along with the constraint listed above (aij xor bij).
   
   (a00 xor b00) /\ (a01 xor b01) /\ (a02 xor b02) /\ (a03 xor b03) /\
   (a10 xor b10) /\ (a11 xor b11) /\ (a12 xor b12) /\ (a13 xor b13) /\
   (a20 xor b20) /\ (a21 xor b21) /\ (a22 xor b22) /\ (a23 xor b23) /\
   (a30 xor b30) /\ (a31 xor b31) /\ (a32 xor b32) /\ (a33 xor b33) /\
   
   (~(b00 xor b01 xor b02 xor b03) /\ ~(b00 /\ b01 /\ b02 /\ b03) /\      row 0
   (b00 \/ b01 \/ b02 \/ b03)) /\ 
   (~(b10 xor b11 xor b12 xor b13) /\ ~(b10 /\ b11 /\ b12 /\ b13) /\      row 1
   (b10 \/ b11 \/ b12 \/ b13)) /\ 
   (~(b20 xor b21 xor b22 xor b23) /\ ~(b20 /\ b21 /\ b22 /\ b23) /\      row 2
   (b20 \/ b21 \/ b22 \/ b23)) /\ 
   (~(b30 xor b31 xor b32 xor b33) /\ ~(b30 /\ b31 /\ b32 /\ b33) /\      row 3
   (b30 \/ b31 \/ b32 \/ b33)) /\ 
   (~(b00 xor b10 xor b20 xor b30) /\ ~(b00 /\ b10 /\ b20 /\ b30) /\      col 0
   (b00 \/ b10 \/ b20 \/ b30)) /\ 
   (~(b01 xor b11 xor b21 xor b31) /\ ~(b01 /\ b11 /\ b21 /\ b31) /\      col 1
   (b01 \/ b11 \/ b21 \/ b31)) /\ 
   (~(b02 xor b12 xor b22 xor b32) /\ ~(b02 /\ b12 /\ b22 /\ b32) /\      col 2
   (b02 \/ b12 \/ b22 \/ b32)) /\ 
   (~(b03 xor b13 xor b23 xor b33) /\ ~(b03 /\ b13 /\ b23 /\ b33) /\      col 3
   (b03 \/ b13 \/ b23 \/ b33)) /\ 
   (~(b00 xor b01 xor b10 xor b11) /\ ~(b00 /\ b01 /\ b10 /\ b11) /\      subgrid 00
   (b00 \/ b01 \/ b10 \/ b11)) /\ 
   (~(b02 xor b03 xor b12 xor b13) /\ ~(b02 /\ b03 /\ b12 /\ b13) /\      subgrid 01
   (b02 \/ b03 \/ b12 \/ b13)) /\ 
   (~(b20 xor b21 xor b30 xor b31) /\ ~(b20 /\ b21 /\ b30 /\ b31) /\      subgrid 10
   (b20 \/ b21 \/ b30 \/ b31)) /\ 
   (~(b22 xor b23 xor b32 xor b33) /\ ~(b22 /\ b23 /\ b32 /\ b33) /\      subgrid 11
   (b22 \/ b23 \/ b32 \/ b33)) 


(c) Show that the formula you have found in (b) is satisfiable. 

   This formula is satisfied by the example above, with the grid:
  
   ++--+--++--+--++
   ||0 |1 ||0 |1 ||
   ++--+--++--+--++
   ||1 |0 ||1 |0 ||
   ++--+--++--+--++
   ||0 |1 ||0 |1 ||
   ++--+--++--+--++
   ||1 |0 ||1 |0 ||
   ++--+--++--+--++
   
   The formula would be (subbing in for appropriate 
   variables):
   
   (t xor f) /\ (f xor t) /\ (t xor f) /\ (f xor t) /\
   (f xor t) /\ (t xor f) /\ (f xor t) /\ (t xor f) /\
   (t xor f) /\ (f xor t) /\ (t xor f) /\ (f xor t) /\
   (f xor t) /\ (t xor f) /\ (f xor t) /\ (t xor f) /\
   
   (~(f xor t xor f xor t) /\ ~(f /\ t /\ f /\ t) /\      
   (f \/ t \/ f \/ t)) /\ 
   (~(t xor f xor t xor f) /\ ~(t /\ f /\ t /\ f) /\     
   (t \/ f \/ t \/ f)) /\ 
   (~(f xor t xor f xor t) /\ ~(f /\ t /\ f /\ t) /\     
   (f \/ t \/ f \/ t)) /\ 
   (~(t xor f xor t xor f) /\ ~(t /\ f /\ t /\ f) /\    
   (t \/ f \/ t \/ f)) /\ 
   (~(f xor t xor f xor t) /\ ~(f /\ t /\ f /\ t) /\     
   (f \/ t \/ f \/ t)) /\ 
   (~(t xor f xor t xor f) /\ ~(t /\ f /\ t /\ f) /\   
   (t \/ f \/ t \/ f)) /\ 
   (~(f xor t xor f xor t) /\ ~(f /\ t /\ f /\ t) /\    
   (f \/ t \/ f \/ t)) /\ 
   (~(t xor f xor t xor f) /\ ~(t /\ f /\ t /\ f) /\     
   (t \/ f \/ t \/ f)) /\ 
   (~(f xor t xor f xor t) /\ ~(f /\ t /\ f /\ t) /\     
   (f \/ t \/ f \/ t)) /\ 
   (~(f xor t xor t xor f) /\ ~(f /\ t /\ t /\ f) /\      
   (f \/ t \/ t \/ f)) /\ 
   (~(f xor t xor t xor f) /\ ~(f /\ t /\ t /\ f) /\     
   (f \/ t \/ t \/ f)) /\ 
   (~(f xor t xor t xor f) /\ ~(f /\ t /\ t /\ f) /\      
   (f \/ t \/ t \/ f)) 
   
   
   Simplifying:
   
   t /\ t /\ t /\ t /\
   t /\ t /\ t /\ t /\
   t /\ t /\ t /\ t /\
   t /\ t /\ t /\ t /\
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   (~(f) /\ ~(f) /\ (t)) /\ 
   
   Simplifying: 
   
   t /\ t /\ t /\ t /\
   t /\ t /\ t /\ t /\
   t /\ t /\ t /\ t /\
   t /\ t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   t /\ t /\ t /\
   
   Simplifying: 
   t

   Since this example yields true, the overall expression is 
   satisfiable.
   
(d) Show how to specify the filled in entries by adding additional
constraints.

 Any filled-in entries would simply be represented by changing the 
 appropriate variables to t and f in the formula and simplifying, 
 as seen in part (c).

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Datatype Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; We already know how to define a list of nats:

(defdata natlist (listof nat))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Now define natlistlist to be a list of lists of nats:

(defdata natlistlist (listof natlist))

(check= (natlistlistp (list 1 2)) nil)
(check= (natlistlistp (list (list 1 2) (list 3 4))) t)

; Add some more checks.

(check= (natlistlistp (list nil (list 1) (list 1 2 3) nil (list 4 1 23))) t)
(check= (natlistlistp (list (list -1))) nil)
(check= (natlistlistp (list nil)) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; A vertex is a nonempty list of nats.

(defdata vertex (oneof (cons nat nil)
                       (cons nat vertex)))

(check= (vertexp (list 1)) t)

; Add some more checks.

(check= (vertexp (list)) nil)
(check= (vertexp (list 1 2 3)) t)
(check= (vertexp (list 1 2 3 -1)) nil)
(check= (vertexp nil) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; A graph is a list of vertexes.  A graph can be empty.

(defdata graph (listof vertex))

(check= (graphp (list (list 1) (list 2 3))) t)

; Add some more checks.

(check= (graphp nil) t)
(check= (graphp (list (list 1 2 3))) t)
(check= (graphp (list (list 1 2) (list -1))) nil)
(check= (graphp (list (list 1) (list 2) (list))) nil)
(check= (graphp (list (list 1) (list 2) (list 2 3))) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The next datatypes will be used to specify a JSON expression.  See
; http://www.json.org/ for the actual syntax.  We will be defining them
; in ACL2s.  Here is the specification:

; A JSONValue is a JSONArray, JSONMap, string, rational, boolean or 'null.
; A JSONArray is a list of JSONValues.
; A JSONPair is a pair consisting of a string and a JSONValue.
; A JSONMap is a list of JSONPairs.
; A JSONExpression is a JSONArray or JSONMap.

(defdata 
  (JSONValue (oneof JSONArray JSONMap String rational boolean 'null))
  (JSONArray (listof JSONValue))
  (JSONPair (list String JSONValue))
  (JSONMap (listof JSONPair))
  (JSONExpression (oneof JSONArray JSONMap)))

; Check some JSON expressions

(check= (JSONValuep "json") t)
(check= (JSONValuep 5/7) t)
(check= (JSONValuep 'null) t)
(check= (JSONValuep 'json) nil)
(check= (JSONArrayp (list (list 11 12) (list 21 22))) t)

; Add more checks, at least two for each JSON datatype.

(check= (JSONValuep (list "json" 5/7 'null)) t)
(check= (JSONValuep (list (list "json" 5/7) 5/7 (list "json"))) t)
(check= (JSONArrayp (list "json" 5/7 'null)) t)
(check= (JSONArrayp (list (list "json" 5/7) 5/7 (list "json"))) t)
(check= (JSONValuep (cons 1 2)) nil)
(check= (JSONArrayp 'null) nil)
(check= (JSONPairp (list "hi" 2)) t)
(check= (JSONPairp (list "hello" (list 1 2 2))) t)
(check= (JSONPairp (list 2 "hi")) nil)
(check= (JSONMapp (list (list "Hi" 1))) t)
(check= (JSONMapp nil) t)
(check= (JSONMapp (list (list "a" 1) (list "b" 2))) t)
(check= (JSONMapp (list 1 2 3)) nil)
(check= (JSONExpressionp (list 1 2 3)) t)
(check= (JSONExpressionp (list (list "a" 1))) t)
(check= (JSONExpressionp 1) nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PROGRAMMING: Lists of lists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; A list can itself contain lists, and these lists can contain other lists
; to any number of levels.  The listp function only checks whether one has
; a list at the top level.  It does not check any of its elements.  Develop
; a recognizer that checks whether every element of a list l or any list
; contained in l to any number of levels contains only atoms or lists.

; Define
; pure-listp: All -> Boolean
; (pure-listp l) is t iff l is a list of atoms or lists, each list that
; it contains is also a list of atoms or lists, and so on to any number
; of levels.

(defunc pure-listp (l)
  :input-contract ...
  :output-contract ...
  ...)

(check= (pure-listp nil) t)
(check= (pure-listp (cons 1 2)) nil)
(check= (pure-listp (list 1 2 (list 3 (list 4)))) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Count the number of times that e occurs in a pure list 
; to any number of levels.

; Define
; how-many: All x Purelist -> Nat
; (how-many e l) is the number of times that e occurs in a pure list
; either in the list itself, or in an list in the list, to any
; number of levels.

(defunc how-many (e l)
  :input-contract ...
  :output-contract ...
  ...)

(check= (how-many 2 (list 2 (list 1 2 (list 3 2)))) 3)
(check= (how-many 2 (list 2 (list (list 3 2) 1) 3)) 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Generalize the len function (i.e., the length of list) so that it can
; compute the sum of the lengths of a list of lists.

; Define
; llen: Natlistlist -> Nat
; (llen l) is the sum of the lengths of the lists in a list
; of lists of nats.

(defunc llen (l)
  :input-contract ...
  :output-contract ...
  ...)

(check= (llen (list (list 1 2))) 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; In hw02.lisp we selected part of a list.  We now want to split a list
; into pieces such that no piece has more than a specified number of
; elements of the original list.  We also want to pack as many elements in
; each piece as possible.

; Define
; split-list: Natlist x Pos -> Natlistlist
; (split-list l x) split-lists the list into a list of lists such that none of
; the lists in the output list has more than x elements, and such that
; the number of lists is as small as possible.  The argument x
; must be a positive integer (an integer greater than or equal to 1).

(defunc split-list (l x)
  :input-contract ...
  :output-contract ...
  ...)

(check= (split-list nil 2) nil)
(check= (split-list (list 1) 2) (list (list 1)))
(check= (split-list (list 1 2) 2) (list (list 1 2)))
(check= (split-list (list 1 2 3) 2) (list (list 1) (list 2 3)))

; As a further check of split-list, perform a test? that split-list does not
; change the number of elements of the list.  In other words, if l is a
; natlist, then the length of l is equal to the llen of the split-list of l
; into lists having at most x elements, where x is a positive integer.

(test? (implies ...))

; Try to prove a theorem about split-list, using thm.  The
; theorem is: if l is a natlist, then the length of l is equal to
; the llen of the split-list of l into lists having at most 2
; elements. If the thm fails, but you think it should succeed,
; you can use test? instead of thm.

(thm (implies ...))

; Try to prove the same theorem but with lists of at most n
; elements where n is a nat of your choosing that is greater than
; 2.  If the thm fails, but you think it should succeed, you can
; use test? instead of thm.

(thm (implies ...))
