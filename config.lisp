;;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: LLTHW; Base: 10 -*-
;;;; file: config.lisp

;;;; Copyright (c) 2012--2015 "the Phoeron" Colin J.E. Lupton <//thephoeron.com>
;;;; See LICENSE for additional information.

(in-package :llthw)

;; Project Directory and Sub-Directory variables

(defparameter *default-dir*
  (pathname (directory-namestring #.(or *compile-file-truename*
                                        *load-truename*))))
(defparameter *static-dir* (merge-pathnames "static/" *default-dir*))
(defparameter *the-book-dir* (merge-pathnames "book/" *default-dir*))
(defparameter *res-dir* (merge-pathnames "resources/" *default-dir*))
(defparameter *ref-dir* (merge-pathnames "reference/" *default-dir*))

;; list of book files, may be deprecated

(defparameter *book-files* (directory (merge-pathnames "*.md" *the-book-dir*)))

;; Define hunchentoot log files

(defparameter *acc-log* (merge-pathnames "log/access.log" *default-dir*))
(defparameter *msg-log* (merge-pathnames "log/message.log" *default-dir*))

;; Sanity check, ensure subdirectories have been created

(ensure-directories-exist *acc-log*)

;; LLTHW Acceptor

(defparameter *acc* nil)

;; Dispatch Table -- only need easy handlers

(setf hunchentoot:*dispatch-table*
  (list 'hunchentoot:dispatch-easy-handlers))

;; Library settings

(setf ;; for utf-8
      hunchentoot:*default-content-type* "text/html; charset=utf-8"
      ;; for debug ; hunchentoot:*catch-errors-p* t
      (cl-who:html-mode) :html5
      ps:*js-string-delimiter* #\"
      3bmd:*smart-quotes* t
      3bmd-code-blocks:*code-blocks* t
      3bmd-definition-lists:*definition-lists* t
      3bmd-tables:*tables* t
      3bmd-code-blocks:*code-blocks-default-colorize* :common-lisp)

;; Server Information

(defun server-type ()
  "Hunchentoot")

(defun server-version ()
  hunchentoot::*hunchentoot-version*)

;; EOF
