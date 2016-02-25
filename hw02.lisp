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
CS 2800 Homework 2 - Spring 2016

This homework is done in groups. The rules are:

 * ALL group members must submit the homework file (this file)
 * the file submitted must be THE SAME for all group members (we use this
   to confirm that alleged group members agree to be members of that group)
 * you must list the names of ALL group members below.

Names of ALL group members: 
Zach Walsh
Sacheverel Eldrid

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw02.lisp

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

- when done, save your file and submit it as hw02.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.

Instructions for programming problems:

For each function definition, you must provide both contracts and a body.

You must also ALWAYS supply your own tests. This is in addition to the
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

We will use ACL2s' check= function for tests. This is a two-argument
function that rejects two inputs that do not evaluate equal. You can think
of check= roughly as defined like this:

(defunc check= (x y)
  :input-contract (equal x y)
  :output-contract (equal (check= x y) t)
  t)

That is, check= only accepts two inputs with equal value. For such inputs, t
(or "pass") is returned. For other inputs, you get an error. If any check=
test in your file does not pass, your file will be rejected.

|#

#|

Since this is our first programming exercise, we will simplify the
interaction with ACL2s somewhat: instead of asking it to formally *prove*
the various conditions for admitting a function, we will just require that
they be *tested* on a reasonable number of inputs. This is achieved using
the following directive (do not remove it!):

|#

:program

#|

Notes:

1. Testing is cheaper but less powerful than proving. So, by turning off
proving and doing only testing, it is possible that the functions we are
defining cause runtime errors even if called on valid inputs. In the future
we will require functions complete with admission proofs, i.e. without the
above directive. For this first homework, the functions are simple enough
that there is a good chance ACL2s's testing will catch any contract or
termination errors you may have.

2. The tests ACL2s runs test only the conditions for admitting the
function. They do not test for "functional correctness", i.e. does the
function do what it is supposed to do? ACL2s has no way of telling what
your function is supposed to do. That is what your own tests are for!

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; In the first four exercises, you are to write some programs for accessing
; a list as if it was an array.  The first program selects one element of the
; list, and the other programs select some ranges of elements from the list.

; Define
; select: List x Nat -> All

; (select l n) returns the nth element of the list l.  The first
; element is the 0th element (i.e., number elements starting at 0).  If
; n is too large for the list, return the empty list.

(defunc select (l n)
  :input-contract (and (listp l) (natp n))
  :output-contract t
  (if (endp l)
    nil
    (if (equal 0 n)
      (first l)
      (select (rest l) (- n 1)))))

(check= (select (list 0 1 2 3) 2) 2)
(check= (select (list "hello" 5 () -7/3) 5) ())
(check= (select (list "hello" 5 () -7/3) 0) "hello")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define
; select-before: List x Nat -> List

; (select-before l n) is the sublist of elements of l ending with the
; element in position n. If n is too large for the list, then return the
; entire list l.

(defunc select-before (l n)
  :input-contract (if (listp l) (natp n) nil)
  :output-contract (listp (select-before l n))
  (if (endp l)
    nil
    (if (equal 0 n)
      (list (first l))
      (cons (first l) (select-before (rest l) (- n 1))))))

(check= (select-before (list 0 1 2 3) 2) (list 0 1 2))
(check= (select-before (list "hello" 5 () -7/3) 1) (list "hello" 5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define
; select-after: List x Nat -> List

; (select-after l n) is the sublist of elements of l starting at the
; element in position n. If n is too large for the list, then return the
; empty list.

(defunc select-after (l n)
  :input-contract (and (listp l) (natp n))
  :output-contract (listp (select-after l n))
  (if (equal n 0)
    l
    (if (endp l)
      nil
      (select-after (rest l) (- n 1)))))

(check= (select-after (list 0 1 2 3) 2) (list 2 3))
(check= (select-after (list "hello" 5 () -7/3) 2) (list () -7/3))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define
; select-range: List x Nat x Nat -> List

; (select-range l m n) is the sublist of elements from position m to position
; n. Require that m be at most equal to n. If m is too large for the list, then
; the empty list is returned. If m is small enough, but n is beyond the end of
; the array, then return the list of elements starting at m and continuing to
; the end of the list.

(defunc select-range (l m n)
  :input-contract (if (and (natp m) (natp n))
                    (and (<= m n) (listp l))
                    nil)
  :output-contract (listp (select-range l m n))
  (select-before (select-after l m) (- n m)))

(check= (select-range (list 0 1 2 3) 1 2) (list 1 2))
(check= (select-range (list "hello" 5 () -7/3) 2 5) (list () -7/3))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define
; is-subsequence: List x List -> Boolean

; (is-subsequence l1 l2) returns t iff each element of l1 also occurs in l2
; in the same order, possibly with intervening elements of l2.

(defunc is-subsequence (l1 l2)
  :input-contract (and (listp l1) (listp l2))    
  :output-contract (booleanp (is-subsequence l1 l2))
  (if (and (consp l1) (consp l2))
   (if (equal (first l1) (first l2))
      (is-subsequence (rest l1) (rest l2))
      (if (equal l2 nil) nil (is-subsequence l1 (rest l2))))
   (equal l1 nil)))

(check= (is-subsequence (list 1 2) (list 1 3 2))   t)
(check= (is-subsequence (list 1 3) (list 3 1 1)) ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; The following data definitions define the types, "list of rational
; numbers" and "list of natural numbers". They automatically give rise to
; recognizers for these types, called rationallistp : All -> Boolean and
; natlistp : All -> Boolean, which you are free to use.

:logic
(defdata rationallist (listof rational))
(defdata natlist (listof nat))
:program

; Define
; helpAHirsh: Natlist x Nat -> NatList
(defunc helpAHirsh (l n)
    :input-contract (and (natlistp l) (natp n))
    :output-contract (natp (len (helpAHirsh l n)))
    (if (consp l)
        (if (>= (first l) n)
            (cons (first l) (helpAHirsh(rest l) (+ 1 n)))
            nil)
        nil))
(check= (helpAHirsh (list 5 3 2 1) 1) (list 5 3))
(check= (helpAHirsh (list 5 6 4 2) 1) (list 5 6 4))
(check= (helpAHirsh (list 0 2 7) 1) ())

; Define
; hirsh: Natlist -> Natlist

; (hirsh l) is the longest prefix (initial subsequence) of l 
; such that the element e in position i has the property that
; e >= i.  Positions start with 1.  For example,
; (hirsh (list 5 3 2 1)) is (list 5 3) because 5>=1, and 3>=2, 
; but the 2 is not >= 3.

; Hint: First define a function that specifies where to start
; the numbering (i.e., number the positions starting at n
; rather than at 1).

(defunc hirsh (l)
  :input-contract (natlistp l)
  :output-contract (natlistp (hirsh l))
    (helpAHirsh l 1))

(check= (hirsh (list 5 3 2 1)) (list 5 3))
(check= (hirsh (list 5 6 4 2)) (list 5 6 4))
(check= (hirsh (list 0 2 7)) ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define
; negate : Rationallist -> Rationallist

; (negate l) is the same as l but with all of the signs reversed.

(defunc negate (l)
  :input-contract (rationallistp l)
  :output-contract (rationallistp l)
  (if (endp l)
    nil
    (cons (unary-- (first l)) (negate (rest l)))))

(check= (negate (list 1 2 3 4)) (list -1 -2 -3 -4))

; Define
; power : Rational x Nat -> Rational

; (power x p) is x raised to the pth power. For example, x raised to the 3rd
; power is x * x * x.

(defunc power (x p)
  :input-contract (and (rationalp x) (natp p))
  :output-contract (rationalp (power x p))
  (if (equal p 0)
      1
      (if (equal p 1)
          x
      (* x (power x (- p 1))))))

(check= (power 0 0) 1)
(check= (power 5/3 2) 25/9)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define
; diff : Rationallist - {()} -> Rationallist

; (diff l) is the list of differences between successive elements of l,
; where l is a list with at least one element. If l has only one element,
; then the list of differences is empty.

(defunc diff (l)
  :input-contract (if (rationallistp l)
                    (not (endp l))
                    nil)
  :output-contract (rationallistp (diff l))
  (if (endp (rest l))
    nil
    (cons (- (first l) (first (rest l)))
          (diff (rest l)))))

(check= (diff (list 1 2 3 4)) (list -1 -1 -1))
(check= (diff (list 2 8 3)) (list -6 5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define
; sum-power : Rationallist - {()} x Nat -> Rational

; (sum-power l p) is the sum of the pth powers of the elements of l
(defunc sum-power (l p)
  :input-contract (and (natp p)
                       (rationallistp l))
  :output-contract (rationalp (sum-power l p))
  (if (endp l)
    0
    (+ (power (first l) p) (sum-power (rest l) p))))

(check= (sum-power (list -1 -1 -1) 1) -3)
; The 1th power of this is (list -1 -1 -1) since -1^1 = -1
; and the sum of the elements of this list is -3

(check= (sum-power (list -1 -1 -1) 2) 3)
; The 2th power of this is (list 1 1 1), since -1^2 = 1
; and the sum of the elements of this list is 3

(check= (sum-power (list 0 1 1) 2) 2)
; The 2th power of this is (list 0 1 1), since 0^2 = 0 and 1^2 = 1 
; The sum of the elements of this list is 2


; Define
; moment-diff : Rationallist - {()} x Nat -> Rational

; (moment-diff l p) is the sum of the pth powers of the successive
; differences between the elements of l.

(defunc moment-diff (l p)
  :input-contract (and (natp p)
                       (if (rationallistp l)
                         (not (endp l))
                         nil))
  :output-contract (rationalp (moment-diff l p))
  (sum-power (diff l) p))

(check= (moment-diff (list 1 2 3 4) 1) -3)
; Because the successive differences of the list is (list -1 -1 -1)
; and the 1th power of this is (list -1 -1 -1) since -1^1 = -1
; and the sum of the elements of this list is -3

(check= (moment-diff (list 1 2 3 4) 2) 3)
; Because the successive differences of the list is (list -1 -1 -1)
; and the 2th power of this is (list 1 1 1), since -1^2 = 1
; and the sum of the elements of this list is 3

(check= (moment-diff (list 5 5 4 3) 2) 2)
; Because the successive differences of the list is (list 0 1 1)
; The 2th power of this is (list 0 1 1), since 0^2 = 0 and 1^2 = 1 
; The sum of the elements of this list is 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;