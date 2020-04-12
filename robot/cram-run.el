(load-file "robot/robot.el")
(load-file "org-drill.el")

;; setup
(copy "basic-run.org" "cram-run-copy.org")

;; normal run
(find "cram-run-copy.org")
(org-drill)
(set-buffer-modified-p nil)
(kill-buffer)
(robot-check-cards-seen 3)

;; cram run with all cards reviewed less than `org-drill-cram-hours`
;; ago, so we expect no new cards to be seen
(find "cram-run-copy.org")
(org-drill-cram)
(robot-check-cards-seen 3)

;; cram run that should include all cards, so we expect seen cards to
;; double
(setq org-drill-cram-hours 0)
(org-drill-cram)
(robot-check-cards-seen-and-die 6)
