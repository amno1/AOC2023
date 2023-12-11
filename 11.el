;;; 11.el --- AOC2023 Day 11 -*- lexical-binding: t; -*-

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

(defun rows ()
  (split-string (buffer-substring-no-properties (point-min) (point-max))))

(defun column (n matrix)
  (let (column)
    (dolist (row matrix)
      (push (aref row n) column))
    (concat (nreverse column))))

(defun columns (&optional rows)
  (let* ((lines (or rows (rows)))
         (line-length (length (car lines)))
         columns)
    (dotimes (i line-length)
      (push (column i lines) columns))
    (nreverse columns)))

(defun column-number () (- (point) (line-beginning-position)))

(defun emptyp (row-or-column)
  (catch 'done
    (dotimes (i (length row-or-column))
      (unless (= (aref row-or-column i) ?.) (throw 'done nil)))
    (throw 'done t)))

(defun empty-vectors (matrix)
  (let ((i 1) empty-rows)
    (dolist (row matrix)
      (when (emptyp row) (push i empty-rows))
      (cl-incf i))
    (nreverse empty-rows)))

(defun multiplier (row-or-col empty-vector)
  (let ((i 0))
    (dolist (e empty-vector) (when (< e row-or-col) (cl-incf i)))
    i))

(defun galaxy-positions (k)
  (save-excursion
    (let (positions
          (empty-rows (empty-vectors (rows)))
          (empty-cols (empty-vectors (columns))))
      (while (search-forward "#" nil t)
        (let* ((row (1+ (line-number-at-pos)))
               (col (1+ (column-number)))
               (mr (multiplier row empty-rows))
               (mc (multiplier col empty-cols)))
          (push (cons (+ row (* mr (1- k))) (+ col (* mc (1- k)))) positions)))
      (nreverse positions))))

(defun shortest-paths (k)
  (let ((positions (galaxy-positions k))
        paths)
    (while positions
      (let ((curr (pop positions)))
        (dolist (pos positions)
          (push (+ (abs (- (car pos) (car curr)))
                   (abs (- (cdr pos) (cdr curr))))
                paths))))
    (cl-reduce #'+ paths)))

(defun AOC-2023-11 ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents-literally "11")
    (message "Part I: %s Part II: %s" (shortest-paths 2) (shortest-paths 1000000))))

;;; 11.el ends here
