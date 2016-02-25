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



CS 2800 Homework 3 - Spring 2016

This homework is done in groups. The groups are normally the same ones as in 
Assignment #2.  Changes can be made on request.  However, all such requests
must be made two days before the assignment is due, and all the students 
involved must agree to the changes.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw03.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. Do not remove or comment out anything pre-existing.

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. Comments should also be used for any English
  text that you may add. This file already contains many comments, so you
  can see what the syntax is.

- when done, save your file and submit it as hw03.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.

Instructions for programming problems:

For each function definition, you must provide both contracts and a body.

As in hw02, you will be programming some functions, and you must ALWAYS
supply tests for these functions. Your tests are in addition to the
tests sometimes provided. Make sure you produce sufficiently many new test
cases. This means: cover at least the possible scenarios according to the
data definitions of the involved types. For example, a function taking two
lists should have at least 4 tests: all combinations of each list being
empty and non-empty.

Beyond that, the number of tests should reflect the difficulty of the
function. For very simple ones, the above coverage of the data definition
cases may be sufficient. For complex functions with numerical output, you
want to test whether it produces the correct output on a reasonable
number if inputs.

Use good judgment. For unreasonably few test cases we will deduct points.

We will be using both the check= and test? functions of ACL2s.

IMPORTANT NOTICE ABOUT YOUR TEST CASES

It is a violation of academic integrity to publish or discuss your test
cases.  These are part of the solution to your assignment.  Copying or
allowing one to copy your test cases is therefore unacceptable.  Please
be careful to prevent your solutions from being seen by other students.

|#

#|

We will simplify the interaction with ACL2s somewhat: instead of asking it
to formally *prove* the various conditions for admitting a function, we
will just require that they be *tested* on a reasonable number of inputs.
This is achieved using the following directive (do not remove it!):

|#

:program

#|

Notes:

1. Testing is cheaper but less powerful than proving. So, by turning off
proving and doing only testing, it is possible that the functions we are
defining cause runtime errors even if called on valid inputs. In the future
we will require functions complete with admission proofs, i.e. without the
above directive. For this homework, the functions are simple enough
that there is a good chance ACL2s's testing will catch any contract or
termination errors you may have.

2. The tests ACL2s runs test only the conditions for admitting the
function. They do not test for "functional correctness", i.e. does the
function do what it is supposed to do? ACL2s has no way of telling what
your function is supposed to do. That is what your own tests are for!

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Contract Fulfillment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

The following are functions that may or may not be correct.  For each function,
list all of the calls that this function makes.  For each call decide whether
the contract is satisfied or not.  If it is satisfied, then explain why.  If it
is not satisfied then explain why not.  In other words, show all of the body
contracts.  Do the same for the overall function contract.

For the first problem, we provide part of the answer to make it 
clear what we expect you to do.  

1. The following function supposedly computes the remainder after dividing
a nat by a nonzero nat.

(defunc rem (x y)
  :input-contract (and (natp x) (natp y) (not (equal y 0)))
  :output-contract (natp (rem x y))
  (if (< x y)
    0
    (+ 1 (rem (- x y) y))))

Body contracts:

(< x y) The input contract is satisfied because the input contract requires
rationals, and x and y are both nats.

(- x y) The input contract is satisfied because the input contract requires
rationals, and x and y are both nats.

(rem (- x y) y) The input contract is satisfied because the input contract requires
rationals, and (- x y) produces a rational number, and y is a nat

(+ 1 (rem (- x y) y)) The input contract is satisfied because the input contract requires
rationals, and the output-contract of (rem x y) confirms it outputs a nat, and 1 is a nat.

(if (< x y)
    0
    (+ 1 (rem (- x y) y)))) The input contract is satisfied because the input contract requires a boolean test and
                            two possible paths to follow based on the result of the boolean test, and (< x y) returns a boolean
                            and 0, and (+ 1 (rem (- x y) y))) are both valid expressions.

Function contract:
(defunc rem (x y)
  :input-contract (and (natp x) (natp y) (not (equal y 0)))
  :output-contract (natp (rem x y))                            The contract is satisfied because when given two nats where y is not equal to zero,
                                                               the body contracts together will always return nats where y is not equal to 0. 

...

2. The following function supposedly computes the floor function of a rational
number.  Check the body and function contracts for this function.

(defunc floor (x)
  :input-contract (and (rationalp x) (>= x 0))
  :output-contract (natp (floor x))
  (if (< x 1)
    0
    (- (floor (+ x 1)) 1)))

Body contracts:

(< x 1) The input contract is satisfied because the input contract requires
rationals, and x and 1 are both rational numbers.

(+ x 1) The input contract is satisfied because the input contract requires
rationals, and x and y are both rational numbers.

(floor (- x 1) 1) The input contract is satisfied because the input contract requires
rationals, and (- x 1) produces a rational number, and 1 is a nat

(- (floor (+ x 1) 1)) The input contract is satisfied because the input contract requires
rationals, and the output-contract of (floor x) confirms it outputs a nat, and 1 is a nat.

(if (< x y)
    0
    (+ 1 (rem (- x y) y)))) The input contract is satisfied because the input contract requires a boolean test and
                            two possible paths to follow based on the result of the boolean test, and (< x y) returns a boolean
                            and 0, and (- (floor (+ x 1) 1))) are both valid expressions.
Function contract:

(defunc floor (x)
  :input-contract (and (rationalp x) (>= x 0))
  :output-contract (natp (floor x))                   The contract is not satisfied because the function is an infinite loop. Since the recursive statement
                                                      adds one to the pre-existing x value, and the base case checks for when x reaches zero...it won't ever.


|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Testing Sorting Programs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The purpose of a sorting algorithm is to rearrange a list of elements
; in order.  To test whether a sorting algorithm is correct, one must show
; not only that the algorithm produces a list that is in order, one must
; also show that the algorithm rearranges the elements of the list,
; including making sure that any elements that occur more than once will
; have the same multiplicity.

; We begin by developing a function that determines whether a list is a
; rearrangement of another list.  This will require some helper functions.  
; The first one counts the number of occurrences of an element in a list.

; multiplicity-in: All x List -> Nat
; (multiplicity-in e l) is the number of occurrences of e in l.

(defunc multiplicity-in (e l)
  :input-contract (listp l)
  :output-contract (natp (multiplicity-in e l))
  (if (endp l)
    0
    (if (equal e (first l))
      (+ (multiplicity-in e (rest l)) 1)
      (multiplicity-in e (rest l)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define
; same-multiplicity: List x List x List -> Boolean
; (same-multiplicity l l1 l2) returns t iff every element of l occurs in l1
; and l2 the same number of times.

(defunc same-multiplicity (l l1 l2)
  :input-contract (and (listp l) (and (listp l1) (listp l2)))
  :output-contract (booleanp (same-multiplicity l l1 l2))
  (if (endp l)
    t
    (and (equal (multiplicity-in (first l) l1)
                (multiplicity-in (first l) l2))
         (same-multiplicity (rest l) l1 l2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define
; is-rearrangement: List x List -> Boolean
; (is-rearrangement l m) is t iff l and m are rearrangements of the same
; elements (including multiplicities).

(defunc is-rearrangement (l m)
  :input-contract (and (listp l) (listp m))
  :output-contract (booleanp (is-rearrangement l m))
  (and (same-multiplicity l l m)
       (same-multiplicity m l m)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; We will be sorting nats, so we need to define a list of nats:

(defdata natlist (listof nat))

; The main test for a sorting algorithm is to determine whether it produces a
; list that is in sorted order.  This next function tests whether a list is in
; sorted order.  This function compares adjacent pairs of elements and returns
; t if all adjacent pairs are in order and nil if not.

; is-ordered: Natlist -> Boolean
; (is-ordered l) is t iff the elements in l are in increasing order.

(defunc is-ordered (l)
  :input-contract (natlistp l)
  :output-contract (booleanp (is-ordered l))
  (if (or (endp l) (endp (rest l)))
    t
    (and (<= (first l) (first (rest l))) (is-ordered (rest l)))))

#| 

body contracts:

(endp l) The input contract is satisfied because the input contract requires
any, 1 can be classified as such.

(rest l) The input contract is satisfied because the input contract requires a non-empty 
list and l is of type list and previously checked if empty

(endp (rest l)) The input contract is satisfied because the input contract requires a non-empty
list and l is of type list and previously checked if empty

(or (endp l) (endp (rest l))) the input contract is satisfied because the input contract
requires two boolean values, the type endp resolves to

(first l) The input contract is satisfied because the input contract requires a non-empty
list and l is of type list and previously checked if empty

(<= (first l) (first (rest l))) the input contract is satisfied because the input contract 
requires two rational numbers and l is of type natlist

(and (<= (first l) (first (rest l))) (is-ordered (rest l))) the input contract is satisfied
because the input contract requires two boolean values and <= returns a boolean as does 
is-ordered

function contract:
(defunc is-ordered (l)
  :input-contract (natlistp l)
  :output-contract (booleanp (is-ordered l)) the contract is satisfied because the returned 
  value is the evaluation of and in the last line of the function which returns a boolean
  and has been proven to do as such.

|#

(check= (is-ordered (list 1 2 3 3 5)) t)
(check= (is-ordered (list 1 2 3 2 5)) nil)
(check= (is-ordered (list 1)) t)
(check= (is-ordered (list 2 1)) nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; We will be looking at several variations on a sorting algorithm called
; bubble-sort.  In bubble-sort, one examines the list for adjacent pairs
; of elements that are out of order, and swaps them.  While all bubble-sort
; algorithms swap out-of-order pairs of elements, the variations differ in
; how the out-of-order pairs are found and when they are swapped.  However,
; all variations must repeat the bubbling operation repeatedly until the
; the list is sorted.

; The first variation checks whether the first two nats in the list are out
; of order, and if they are, then it swaps them.  The function is then 
; applied recursively to the rest of the list (after the first two elements).

; bubble1: Natlist -> Natlist
; (bubble1 l) rearranges the list l by recursively swapping the initial
; pair of elements if they are out of order.

(defunc bubble1 (l)
  :input-contract (natlistp l)
  :output-contract (natlistp (bubble1 l))
  (if (or (endp l) (endp (rest l)))         ; The base cases
    l
    (let ( (f (first l))                    ; First element of the pair
           (s (first (rest l)))             ; Second element of the pair
           (b (bubble1 (rest (rest l)))) )  ; Recursively apply bubble1 to the rest
      (if (> f s)                           ; Should we swap?
        (cons s (cons f b))                 ; Yes, swap the pair
        (cons f (cons s b))))))             ; No, leave them alone

; First check whether bubble1 produces a rearrangement.  Rather than just
; checking a few cases, use test? to be thorough.

(test? (implies (natlistp l) (is-rearrangement (l (bubble1 l)))))

; Explain what happened.
; Given the parameter that l must be of type natlist, ACL2s went about trying every possible
; concoction it could think of trying to disprove that bubble1 creates a rearrangement of
; given list l.

; Now try some checks. As usual, add more checks.

(check= (bubble1 (list 4 3 2 1)) (list 3 4 1 2))
(check= (bubble1 (list 2 1)) (list 1 2))
(check= (bubble1 (list 7)) (list 7))
(check= (bubble1 (list 6 5 4 3 2)) (list 5 6 3 4 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; It appears that bubble1 is improving the order.  However, to determine
; whether bubble1 can actually be used to sort a list, we need to repeat
; bubble1 several times.

; bubble1-repeated: Nat x Natlist -> Natlist
; (bubble1-repeated n l) applies bubble1 n times to the list l.

(defunc bubble1-repeated (n l)
  :input-contract (and (natp n) (natlistp l))
  :output-contract (natlistp (bubble1-repeated n l))
  (if (equal n 0)
    l
    (bubble1-repeated (- n 1) (bubble1 l))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; We can now test whether bubble1 is sorting the list.  The number
; times we need to repeat a bubble operation is at least the length
; of the list, and possibly more.  Try using twice the length of
; the list to be thorough.  As usual, test both whether the list is
; being rearranged and whether the list is being sorted.

; Test for rearrangement
(test? (implies (and (natp n) (natlistp l) (equal n (* 2 (length l)))) 
                (is-rearrangement l (bubble1-repeated n l))))

; Test for sorting in order
(test? (implies (and (natp n) (natlistp l) (equal n (* 2 (length l))))
                (is-ordered (bubble1-repeated n l))))#|ACL2s-ToDo-Line|#


; Explain what happened.  Would increasing the number of repetitions help?
;The tests passed