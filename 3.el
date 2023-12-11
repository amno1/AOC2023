;;; 3.el --- AOC2023 Day 3 -*- lexical-binding: t; -*-

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

(defvar line-length nil)

(defun next-number ()
  (when (re-search-forward "[0-9]+" nil t)
    (match-string 0)))
(defun line-length () (- (line-end-position) (line-beginning-position)))
(defun line-above (match-length)
  (buffer-substring (- (point) match-length line-length 2)
                    (- (1+ (point)) line-length 1)))
(defun line-below (match-length)
  (buffer-substring (+ (- (point) match-length) line-length)
                    (+ 2 (point) line-length)))
(defun symbp (c) (and (/= c ?.) (/= c ?\n) (not (cl-digit-char-p c))))
(defun first-line-p () (<= (point) (1+ line-length)))
(defun last-line-p () (<=  (- (point-max) (line-end-position)) 1))
(defun leftp (match-length) (symbp (char-before (- (point) match-length))))
(defun rightp () (symbp (char-after (point))))
(defun abovep (match-length)
  (unless (first-line-p)
    (cl-find 't (cl-map 'vector #'symbp (line-above match-length)))))
(defun belowp (match-length)
  (unless (last-line-p)
    (cl-find 't (cl-map 'vector #'symbp (line-below match-length)))))
(defun attachedp (match-length)
  (or (leftp match-length) (rightp) (abovep match-length) (belowp match-length)))
(defun next-star () (search-forward "*" nil t))
(defun number-at-point ()
  (when-let ((word (thing-at-point 'word))) (string-to-number word)))

(defun attached-gears ()
  (let (numbers)
    (save-excursion
      (when-let (right (number-at-point)) (push right numbers))
      (forward-char -1)
      (when-let (left (number-at-point)) (push left numbers))
      (unless (first-line-p)
        (forward-char (- line-length))
        (when-let (top-left (number-at-point)) (push top-left numbers))
        (forward-char 1)
        (when-let (top-right (number-at-point)) (push top-right numbers))
        (forward-char line-length))
      (unless (last-line-p)
        (forward-char line-length)
        (when-let (down-right (number-at-point)) (push down-right numbers))
        (forward-char -1)
        (when-let (down-left (number-at-point)) (push down-left numbers))))
    (when (= 2 (length numbers))
      numbers)))

(defun aoc-2023-3 ()
  (interactive)
  (let ((p1 0) (p2 0)
        (match (next-number)))
    (setq line-length (line-length))
    (while match
      (when (attachedp (length match))
        (let ((n (string-to-number match)))
          (cl-incf p1 n)))
      (setq match (next-number)))
    (goto-char 0)
    (while (next-star)
      (when-let (gears (attached-gears))
        (cl-incf p2 (* (car gears) (cadr gears)))))
    (message "Part I: %s, Part II: %s" p1 p2)))

;;; 3.el ends here
