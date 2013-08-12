#lang racket
(require rackunit
         "../verbal-expressions.rkt")

(test-case
 "Abstract functions for extending the Regex"
 (check-equal? (begin (reset)
                      (next-pre "^")
                      (next-src ";;")
                      (next-suf "$")
                      (next-mod "i")
                      (endCapture))
               (string-append "^"";;""$""i"))
 
 (check-equal? (begin (reset)
                      (next-pre "^")
                      (next-src ";;")
                      (next-suf "$")(next-suf "$")
                      (next-mod "i")(next-mod "i")
                      (endCapture))
               (string-append "^"";;""$""i"))
 
 (check-equal? (begin (reset)
                      (next-pre "^")
                      (next-src ";;")
                      (next-suf "$")(next-suf "k")
                      (next-mod "i")(next-mod "k")
                      (endCapture))
               (string-append "^"";;""$k""ik")))

(test-case
 "Tests for: (anything)(something)(endOfLine)"
   (check-equal? (begin (reset)
                       (startOfLine)
                       (anything)(something)
                       (endOfLine)
                       (endCapture))
                (string-append "^" 
                               "(?:.*)" "(?:.+)"
                               "$")))

(test-case
 "Tests for: (annythingBut)"
  (check-equal? (begin(reset)
                      (anythingBut "abc")
                      (endCapture))
                (string-append "(?:[^"
                               "abc"
                               "]*)")))

(test-case
 "Test for (somethingBut ...)"
  (check-equal? (begin(reset)
                      (somethingBut "abc")
                      (endCapture))
                (string-append "(?:[^"
                               "abc"
                               "]+)")))

(test-case
 "Tests for: (lineBreak)(br)(tab)(word)"
  (check-equal? (begin (reset)
                       (lineBreak)(br)
                       (tab)(word)
                       (endCapture))
                (string-append "(?:(?:\\n)|(?:\\r\\n))"
                               "(?:(?:\\n)|(?:\\r\\n))"
                               "\\t" "\\w+")))

(test-case
 "Test for (anyOf...)"
  (check-equal? (begin (reset)
                       (anyOf "abc")
                       (endCapture))
                (string-append "["
                               "abc"
                               "]")))
