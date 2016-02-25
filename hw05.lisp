#|

CS 2800 Homework 5 - Spring 2015

This homework is done in groups. The groups are normally the same ones as in 
Assignment #4.  Changes can be made on request.  However, all such requests
must be made two days before the assignment is due, and all the students 
involved must agree to the changes.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw05.lisp

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

- when done, save your file and submit it as hw05.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.

Instructions for programming problems:

For each function definition, you must provide both contracts and a body.
You may define helper functions. For such functions, you must provide 
contracts and tests the same as any other function.

This assignment must pass all contracts and terminate. You should avoid
the :program command in the file you submit, although you can, of course,
use it while developing your programs and you can use :program if ACL2s
fails to accept your function definition, but you think your definition
is correct.

As in hw04, you will be programming some functions.  If one or more check=
tests are provided, then you must add more check= or test? tests.  Your 
check=/ test? tests are in addition to the check= tests provided.  Make 
sure you produce sufficiently many new test cases.  This means: 
cover at least the possible scenarios according to the data definitions 
of the involved types. For example, a function taking two lists should 
have at least 4 additional check= tests: all combinations of each list 
being empty and non-empty. Each datatype should have at least 2 additional 
tests.

Beyond that, the number of tests should reflect the difficulty of the
function. For very simple ones, the above coverage of the data definition
cases may be sufficient. For complex functions with numerical output, you
want to test whether it produces the correct output on a reasonable
number of inputs.

If the function asks for a test? or a thm, then follow the instructions
for that function.  If ACL2s fails to prove a thm form, but you think that 
it is actually valid, you can replace the thm with a test? and add a comment
explaining what you did.

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
are equal, and operators are applied from left to right (i.e., left
associative). This is the same as in hw04.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Simplification of formulas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

There are many ways to
represent a formula. For example: 

p \/ (p => q)) 

is equivalent to 

true 

Another example:

((~p) \/ (~q))

is equivalent to

~p \/ ~q

By removing 6 parentheses we simplified the formula, but we 
can simplify it further as follows

p => ~q

We now have 2 connectives instead of 3.

For each of the following, try to find the simplest equivalent
formula. By simplest, we mean the one with the least number of
connectives and parentheses. You can use any unary or binary
connective shown above in the propositional logic section.

(A) ~(p <> q <> r)

...

(B) p => (~q \/ r \/ ((q => r) /\ p))

...

(C) ~(r => ~q) \/ ~(p => r)

...

(D) ~((p => q) /\ ~r)

...

(E)  p => p => p

...

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Characterization of formulas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

For each of the following formulas, determine if they are valid,
satisfiable, unsatisfiable, or falsifiable. These labels can
overlap (e.g. formulas can be both satisfiable and valid), so
keep that in mind and indicate all characterizations that
apply. In fact, exactly two characterizations always
apply. (Think about why that is the case.) Provide proofs of your
characterizations, using a truth table or simplification
argument (for valid or unsatisfiable formulas) or by exhibiting
assignments that show satisfiability or falsifiability.

(A) q => (q => p) <> false

...

(B) p <> p => ~p /\ q \/ ~p

...

(C) ~(~r /\ (p <> ~p) <> r /\ q \/ r)

...

(D) p => q => r => p

...

(E) ~(p <> ~q \/ q)

...

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Computing Homework Grades
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; We will be producing lists of nats so we will need the natlist type:

(defdata natlist (listof nat))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Rounding is halfway between the ceiling and floor functions.

; Define:
; round: {x:Rational | x >= 0} -> Nat
; (round x) for a nonnegative rational x is the nat that is closest to x.
; If x is exactly between two nats, then use the larger nat.

(defunc round (x)
  :input-contract (and (rationalp x) (>= x 0))
  :output-contract (natp (round x))
  (cond ((< x 1/2) 0)
        ((< x 3/2) 1)
        (t (+ (round (- x 1)) 1))))

(check= (round 1/2) 1)
(check= (round 24/49) 0)
(check= (round (+ 85 1/2)) 86)

; Prove that (round x) is no more than 1/2 larger than x and
; cannot be less than 1/2 smaller than x.

(thm ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The average is a common operation for combining a collection of values.

; Define:
; average: Natlist -> Rational
; (average l) is the average (mean) of the list l of nats.  If the list
; is empty, then the average is 0.

(defunc average (l)
  :input-contract ...
  :output-contract ...
  ...)

(check= (average (list 80 90 100)) 90)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The bubble3 function from the solution to hw03 is correct, but it does
; not pass contract testing because first and rest are applied to the
; variable b even though it is never tested for nil. Modify the solution so
; that it tests b appropriately.

; Define:
; bubble: Natlist -> Natlist
; (bubble l) rearranges the list l by recursively swapping the initial
; pair of elements if they are out of order.

(defunc bubble (l)
  :input-contract ...
  :output-contract ...
  ...)

(check= (bubble (list 5 4 3 1 2)) (list 1 5 4 3 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The sort function can now be defined using bubble as in the solution
; to hw03.

; Define:
; bubble-repeated: Nat x Natlist -> Natlist
; (bubble-repeated n l) applies bubble n times to the list l.

(defunc bubble-repeated (n l)
  :input-contract (and (natp n) (natlistp l))
  :output-contract (natlistp (bubble-repeated n l))
  (if (equal n 0)
    l
    (bubble-repeated (- n 1) (bubble l))))

(check= (bubble-repeated 2 (list 5 4 3 1 2)) (list 1 2 5 4 3))

; Define:
; sort: Natlist -> Natlist
; (sort l) sorts the list l in ascending order

(defunc sort (l)
  :input-contract (natlistp l)
  :output-contract (natlistp (sort l))
  (if (< (len l) 2)
    l
    (bubble-repeated (- (len l) 1) l)))

(check= (sort (list 5 4 3 1 2)) (list 1 2 3 4 5))

; Test that sort does not change the length of the list.

(test? ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; To select the largest values from a list, the list should be sorted and
; then the last values should be selected.  Modify the select-after
; function from hw02 so that it selects a specified number of nats, rather
; than the list of nats after a given position.

; Define
; select-last: Natlist x Nat -> Natlist
; (select-last l n) is the sublist of elements of l containing the last n
; elements of l.  If n is greater than or equal to the length of the list then
; return the entire list.

(defunc select-last (l n)
  :input-contract (and (natlistp l) (natp n))
  :output-contract (natlistp (select-last l n))
  (cond ((endp l) ())
        ((>= n (len l)) l)
        (t (select-last (rest l) n))))

(check= (select-last (list 1 2 3 4) 2) (list 3 4))

; Prove that select-last produces a list with no more than n elements.

(thm ...)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; We will be developing programs for storing and averaging assignment, quiz
; and exam grades. The first step is to define appropriate datatypes.
; First define a datatype for the kinds of grades in the spreadsheet.

(defdata grade-type ...)

(check= (grade-typep 'exam) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The quizzes have a section, but other grades are not by section.  Define
; a datatype that allows one to specify one of the sections to be S1, S3,
; S4, S5, or not to have a section.

(defdata section ...)

(check= (sectionp 'S1) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The grades of each type are numbered, starting from 1. For example, hw02
; is the assignment grade with number 2. Define a record type that
; specifies a student id, a grade type, a grade number for the type, a
; section, and a score.  The student ids are positive nats.  The scores
; are nats. The field names should be id, type, number, sect and score. 
; Define this record type:

(defdata grade-rec ...)

(check= (grade-rec-number (grade-rec 101 'assignment 5 nil 85)) 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Finally, the spreadsheet of all grades in the course is a set of grade
; records. Implement this using a list:

(defdata grade-spreadsheet ...)

(check= (grade-spreadsheetp (list (grade-rec 101 'assignment 5 nil 85))) t)
(check= (grade-recp (first (list (grade-rec 101 'assignment 5 nil 85)))) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; To avoid having to keep typing a long list of grade records, it is handy
; to define a global constant which can then be used for many check= tests.
; You should put all of the grades of your team in a spreadsheet. Use your
; group name for the name of this spreadsheet. Your spreadsheet should
; contain your actual grades, but do not use your actual NU ids as your
; student ids. Your check= tests should use your own spreadsheet.

(defconst *cs2800* (list (grade-rec 101 'assignment 5 nil 85)
                         (grade-rec 102 'quiz 1 'S1 6)
                         (grade-rec 102 'quiz 6 'S1 21)))

(check= (grade-rec-sect (first (rest *cs2800*))) 'S1)

(defconst ...)

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Now develop a function that extracts the list of all scores for one
; student, of one grade type in one section.

; Define:
; extract-scores: Grade-spreadsheet x Pos x Grade-type x Section -> Natlist
; (extract-scores ss id gt s) is the set of scores from the spreadsheet ss
; for the student with the given id whose grade type is gt and section is s.

(defunc extract-scores (ss id gt s)
  :input-contract ...
  :output-contract ...
  ...)

(check= (extract-scores *cs2800* 102 'quiz 'S1) (list 6 21))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The assignment grade for one student is obtained by extracting the top 10
; assignment scores for the student, and then averaging the scores.  You
; can use the sort function programmed in hw03. However, you should make
; sure that it passes contract and termination testing. The posted solution
; does not achieve this.

; Define:
; average-assignment-grade: Grade-spreadsheet x Pos x Pos -> Rational
; (average-assignment-grade ss id top) is the average of the top best
; assignments for the student with the given id in the spreadsheet ss.

(defunc average-assignment-grade (ss id top)
  :input-contract ...
  :output-contract ...
  ...)

(check= (average-assignment-grade *cs2800* 101 1) 85)

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The quiz grade for one student is obtained by dropping the first quiz,
; dropping 10% of the ones that are left, and then averaging what remains.
; If the number of quizzes is not divisible by 10, then round the number.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Define:
; average-quiz-grade: Grade-spreadsheet x Pos x Section -> Rational
; (average-quiz-grade ss id s) is the average grade of all quizzes taken
; by the student with given id in section s from the spreadsheet ss.
; Quiz number 1 is not used, and the lowest 10% of the remaining scores
; are dropped before computing the average.

(defunc average-quiz-grade (ss id s)
  :input-contract ...
  :output-contract ...
  ...)

(check= (average-quiz-grade *cs2800* 102 'S1) 21)

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
