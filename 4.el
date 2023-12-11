;;; 4.el --- AOC2023 Day 4 -*- lexical-binding: t; -*-

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

;;

;;; Code:

(defun aoc-2023-4 ()
  (let ((p1 0) (cards (make-vector (count-lines 1 (point-max)) 1)) card)
    (while (re-search-forward "\\([0-9]+\\):" nil t)
      (let ((card (string-to-number (match-string 1))) w h i n )
        (while (not (looking-at-p " |")) (push (read (current-buffer)) w))
        (while (< (point) (line-end-position)) (push  (read (current-buffer)) h))
        (setq i (length (cl-nintersection w h)))
        (when (> i 0) (cl-incf p1 (expt 2 (1- i))))
        (dotimes (c i) (cl-incf (aref cards (+ card c)) (aref cards (1- card))))))
    (message "Part I: %s, Part II: %s" p1 (cl-reduce #'+ cards))))

;;; 4.el ends here
