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
  (let ((p1 0) (p2 0))
    (with-temp-buffer
      (insert-file-contents-literally "/home/arthur/repos/AOC2023/2")
      (while (search-forward "game" nil t)
        (re-search-forward "[0-9]+")
        (let ((r 0) (g 0) (b 0)
              (i (string-to-number (match-string 0))))
          (while (re-search-forward "[0-9]+" (line-end-position) t)
            (let ((n (string-to-number (match-string 0)))
                  (c (read (current-buffer))))
              (pcase c
                ('red   (and (> n 12) (setq i 0)))
                ('green (and (> n 13) (setq i 0)))
                ('blue  (and (> n 14) (setq i 0))))
              (pcase c
                ('red   (and (> n r) (setq r n)))
                ('green (and (> n g) (setq g n)))
                ('blue  (and (> n b) (setq b n))))))
          (setq p1 (+ p1 i) p2 (+ p2 (* r g b))))))
    (message "Part I: %s, Part II: %s" p1 p2)))

;;; 2.el ends here
