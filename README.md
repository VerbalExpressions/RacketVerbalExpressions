VerbalExpressions For Racket v0.1
=================================

## Racket Regular Expressions made easy

1. VerbalExpressions is  Racket module that helps to construct difficult regular expressions. It is a port of VerbalExpressions.js located at https://github.com/VerbalExpressions/JSVerbalExpressions

1. Documentation for Racket regexp are here:

   + Reference: http://docs.racket-lang.org/reference/regexp.html
   
   + Guide: http://docs.racket-lang.org/guide/regexp.html
   

Arbitrary design decisions:

1. To work with strings despite Perlism 34 [http://www.cs.yale.edu/quotes.html]

1. Use camelCase to match original library

1. Return strings. This allows for extension to PERL syntax more easily in the future.

1. Rename the VerbalExpression 'or to 'OR for expediency.

1. Implement `beginCapture`, `OR`, `matchCase`, `withAnyCase`, as a higher node in the VerbalExpression tree [see example below]. These are macros and allow nesting. `endCapture` is also a macro to allow it to work inside `let` if needed [it isn't currently].


## Other Implementations
You can see an up to date list of all ports in the [organization](https://github.com/VerbalExpressions). 

## Examples
Here's a couple of simple examples to give an idea of how VerbalExpressions works:

### Testing if we have a valid URL

	#lang racket
	(require "verbal-expressions.rkt")
	;; Create an example of how to test for correctly formed URLs
	;; Note that idiomatic Verbal Expressions uses camelCase -
	;; or at least that's what I have decided.
	(define TESTER 
		(beginCapture
		(startOfLine)
		(then "http")
		(maybe "s")
		(then "://")
		(maybe "www.")
		(anythingBut" ")
		(endOfLine)
		(endCapture)))

	;; Create an example URL
	(define TEST-ME "https://www.google.com")

	;; check the validity using
	;; built-in regexp functions
	(if (regexp-match? TESTER TEST-ME)
		"Valid URL"
		"Invalid URL: Do you need a call to  (wheelchair...)")

### Replacing strings

	;; Create a test string
	> (define REPLACE-ME "Replace bird with a duck")

	;; Create an expression that seeks for word "bird"
	> (define BIRD
		(beginCapture
		(find "bird")
		(endCapture)))

	> ;; Execute the expression like a normal regexp object
	> (regexp-replace BIRD REPLACE-ME "duck")
	"Replace duck with a duck"
	
### Example of OR 
	;; Other Macros similarly nested
	>  (beginCapture
		(matchCase
		(find "ab"))
		(endCapture)
		(OR
		(beginCapture
			(matchCase
			(find "C"))
			(endCapture))))
	>(pregexp (regex)) ;; (regex) returns the string
	#px"((?-i:(?:ab)))|((?-i:(?:C)))"
	> (regexp-match* (pregexp (regex)) "ac ab")
	'("ab")
	
## Conversion to pregexp objects

Use (pregexp (regex)) to produce a PERL style syntax object [#prx*string*]
   
## Other implementations  
You can view all implementations on [VerbalExpressions.github.io](http://VerbalExpressions.github.io)





