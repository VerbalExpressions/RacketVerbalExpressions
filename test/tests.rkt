#lang racket
(require rackunit
         "../verbal-expressions.rkt")

(test-case
 "Abstract functions for extending the Regex"
 (check-equal? (beginCapture
                      (next-pre "^")
                      (next-src ";;")
                      (next-suf "$")
                      (next-mod "i")
                      (endCapture))
               (string-append "^"";;""$""i"))
 
 (check-equal? (beginCapture
                      (next-pre "^")
                      (next-src ";;")
                      (next-suf "$")(next-suf "$")
                      (next-mod "i")(next-mod "i")
                      (endCapture))
               (string-append "^"";;""$""i"))
 
 (check-equal? (beginCapture
                      (next-pre "^")
                      (next-src ";;")
                      (next-suf "$")(next-suf "k")
                      (next-mod "i")(next-mod "k")
                      (endCapture))
               (string-append "^"";;""$k""ik")))

(test-case
 "Tests for: (anything)(something)(endOfLine)"
   (check-equal? (beginCapture
                       (startOfLine)
                       (anything)(something)
                       (endOfLine)
                       (endCapture))
                (string-append "^" 
                               "(?:.*)" "(?:.+)"
                               "$")))

(test-case
 "Tests for: (annythingBut)"
  (check-equal? (beginCapture
                      (anythingBut "abc")
                      (endCapture))
                (string-append "(?:[^"
                               "abc"
                               "]*)")))

(test-case
 "Test for (somethingBut ...)"
  (check-equal? (beginCapture
                      (somethingBut "abc")
                      (endCapture))
                (string-append "(?:[^"
                               "abc"
                               "]+)")))

(test-case
 "Tests for: (lineBreak)(br)(tab)(word)"
  (check-equal? (beginCapture
                       (lineBreak)(br)
                       (tab)(word)
                       (endCapture))
                (string-append "(?:(?:\\n)|(?:\\r\\n))"
                               "(?:(?:\\n)|(?:\\r\\n))"
                               "\\t" "\\w+")))

(test-case
 "Test for (anyOf...)"
  (check-equal? (beginCapture
                       (anyOf "abc")
                       (endCapture))
                (string-append "["
                               "abc"
                               "]")))
