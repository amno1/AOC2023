;;; 2.el --- AOC2023 Day 2 -*- lexical-binding: t; -*-

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

(defun aoc-2023-2 ()
  (interactive)
  (let ((p1 0) (p2 0) n c i)
    (with-temp-buffer
      (insert-file-contents-literally "/home/arthur/repos/AOC2023/2")
      (goto-char (point-min))
      (while (search-forward "game" nil t)
        (re-search-forward "[0-9]+")
        (setq i (string-to-number (match-string 0)))
        (let ((r 0) (g 0) (b 0))
          (while (re-search-forward "[0-9]+" (line-end-position) t)
            (setq n (string-to-number (match-string 0)) c (read (current-buffer)))
            (cond
             ((> n 14)
              (setq i 0))
             ((> n 13)
              (when (or (equal c 'red) (equal c 'green))
                (setq i 0)))
             ((> n 12)
              (when (equal c 'red)
                (setq i 0))))
            (pcase c
              ('red   (when (> n r) (setq r n)))
              ('green (when (> n g) (setq g n)))
              ('blue  (when (> n b) (setq b n)))))
          (setq n (* r g b)))
        (cl-incf p1 i)
        (cl-incf p2 n)))
    (message "Part I: %s, Part II: %s" p1 p2)))

;;; 2.el ends here
