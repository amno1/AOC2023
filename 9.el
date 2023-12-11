;;; 9.el --- AOC2023 Day 9 -*- lexical-binding: t; -*-

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

(defun line-to-list ()
  (let ((line))
    (while (< (point) (line-end-position))
      (push (read (current-buffer)) line))
    (nreverse line)))

(defun diff (list)
  (let (d)
    (while (cdr list) (push (- (cadr list) (pop list)) d))
    d))

(defun zerosp (list)
  (catch 'zeros
    (dolist (elt list) (unless (= 0 elt) (throw 'zeros nil)))
    (throw 'zeros t)))

(defun diff-list (list)
  (let ((end (car (last list)))
        (beg (first list))
        (d (diff list)))
    (if (zerosp d)
        (cons beg end)
      (let ((c (diff-list (nreverse d))))
        (cons
         (- beg (car c))
         (+ end (cdr c)))))))

(defun aoc-2023-9 ()
  (interactive)
  (let ((p1 0) (p2 0))
    (while (not (eobp))
      (let ((tmp (diff-list (line-to-list))))
        (cl-incf p1 (cdr tmp))
        (cl-incf p2 (car tmp)))
      (forward-line))
    (message "Part I: %s, Part II: %s" p1 p2)))

;;; 9.el ends here
