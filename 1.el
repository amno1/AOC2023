;;; 1.el --- AOC2023 Day 1 -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Arthur Miller
;; Author:  Arthur Miller <arthur.miller@live.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;  _ 

;;; Code:

(defun aoc-2023-1 ()
  (interactive)
  (let ((wrgx "[0-9]\\|one\\|two\\|three\\|four\\|five\\|six\\|seven\\|eight\\|nine"))
    (with-temp-buffer
      (insert-file-contents-literally "/home/arthur/repos/AOC2023/1")
      (cl-labels
          ((match-to-digit (in)
             (string-to-number
              (pcase in
                ("one" "1") ("two"   "2") ("three" "3") ("four"  "4") ("five"  "5")
                ("six" "6") ("seven" "7") ("eight" "8") ("nine"  "9") (_ in))))
           (doit (rgx)
             (let ((digits nil) (acc 0))
               (goto-char (point-min))
               (while (re-search-forward rgx (line-end-position) t)
                 (cl-incf acc (* 10 (match-to-digit (match-string 0))))
                 (goto-char (line-end-position))
                 (re-search-backward rgx (line-beginning-position))
                 (cl-incf acc (match-to-digit (match-string 0)))
                 (forward-line))
               acc)))
        (message "Part I: %s, Part II: %s" (doit "[0-9]") (doit wrgx))))))

(setq num-list (mapcar (lambda (e) `(,(int-to-string e) . ,e)) (number-sequence 1 9)))
(setq spelled-list '(("one" . 1) ("two" . 2) ("three" . 3) ("four" . 4) ("five" . 5) ("six" . 6) ("seven" . 7) ("eight" . 8) ("nine" . 9)))

(defun doit (vextr)
  (with-temp-buffer
    (insert-file-contents "1")
    (let ((res 0))
      (while (not (eobp))
        (let* ((l (thing-at-point 'line))
               (digits (mapcan (lambda (i) (funcall vextr (substring l i))) (number-sequence 0 (length l)))))
          (setq res (+ res (* (car digits) 10) (car (last digits))))
          (forward-line 1)))
      (message "%d" res))))

(defun extr (alist)
  `(lambda (l) (cond ,@(mapcar (lambda (e) `((string-prefix-p ,(car e) l) (list ,(cdr e)))) alist))))

(doit (extr num-list))
(doit (extr (append spelled-list num-list)))

(catch 'some-value
  (while t
    (if (= (% (random 100) 13) 0)
        (throw 'some-value "You are lucky!")
      (message "%s" (if (oddp i) "Unlucky!" "Still unlucky ...")))))


;;; 1.el ends here
