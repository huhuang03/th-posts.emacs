;;; th-posts.el --- posts util

;; Copyright (C) 2011 Free Software Foundation, Inc.

;; Author: th <huhuagn03@gmail.com>
;; Version: 0.1
;; Package-Requires: (())
;; Keywords: posts, blogs
;; URL: https://github.com/huhuang03/th-posts.emacs


;;; Commentary:

;; This package provider some useful function to write a blog post.

;;; Code:
;;;###autoload
(define-minor-mode th-posts-mode
  ())

(defun _th-posts-ensure-folder (filename)
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir t)))))

(defun th-posts-hello ()
  "Just a test."
  (interactive)
  (message "hello in th-posts"))

;; how to format code?
  (defun th-posts-new-post (post-name)
    (interactive "s请输入博客文件名称：")
    (th-posts-new-post-or-draft post-name "posts"))

  ;; 新建草稿
  (defun th-posts-new-draft (post-name)
    (interactive "s请输入草稿文件名称：")
    (th-posts-new-post-or-draft post-name "drafts"))

;; We have some job to do.
;; First is creat the folder.
  (defun th-posts-new-post-or-draft (post-name folder)
    "New a post or draft by FOLDER, and the name is POST-NAME."
    (let* ((time (format-time-string "%Y-%m-%d"))
           (slug (replace-regexp-in-string " +" "-" post-name))
          (post-path (concat (th-folder-to-src "posts")
                                  "/" slug ".org")))
      (message post-path)
      (if (file-exists-p post-path)
        (progn
      (message "博客已经存在了")
      (find-file post-path))
      (progn
        (setq to-write (format "#+BEGIN_COMMENT\n.. title: %s\n.. slug: %s\n.. date: %s\n.. tags:
.. category:
.. link:
.. description:
.. type: text
#+END_COMMENT

TODO
"
          post-name
          slug
          time))
        (_th-posts-ensure-folder post-path)
        (write-region to-write nil post-path)
        (find-file post-path)
        (end-of-line 1000)))
      ))

(provide 'th-posts-mode)
;;; th-posts.el ends here
