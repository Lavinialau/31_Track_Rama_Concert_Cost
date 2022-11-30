
# create a scheduled task -----------------

# call library
library(taskscheduleR)


# copy and paste this scheduling code to this path first
path <- "C:\\Users\\Public\\Rama_New_Concert_Cost\\1_code"     # update!!


# delete old task
taskscheduler_delete("Rama_Track_Concert_Cost")


# init task
taskscheduler_create(
  taskname = "Rama_Track_Concert_Cost",
  rscript = file.path(path, "2_email_track_cost.R"),
  schedule = "DAILY",
  days = c("MON", "TUE", "WED", "THU", "FRI"),
  starttime = "08:45",                                    # update!!
  startdate = "2022-09-21"
)
