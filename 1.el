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
             (let ((digit
                    (pcase in
                      ("one" "1") ("two"   "2") ("three" "3") ("four"  "4") ("five"  "5")
                      ("six" "6") ("seven" "7") ("eight" "8") ("nine"  "9") (_ in))))
               digit))
           (doit (rgx)
             (let ((digits nil) (acc 0))
               (goto-char (point-min))
               (while (re-search-forward rgx (line-end-position) t)
                 (push (match-to-digit (match-string 0)) digits)
                 (goto-char (line-end-position))
                 (re-search-backward rgx (line-beginning-position))
                 (push (match-to-digit (match-string 0)) digits)
                 (cl-incf acc (string-to-number (apply #'concat (nreverse digits))))
                 (setq digits nil)
                 (forward-line))
               acc)))
        (message "Part I: %s, Part II: %s" (doit "[0-9]") (doit wrgx))))))

;;; 1.el ends here
