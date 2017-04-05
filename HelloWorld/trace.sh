#!/bin/sh
lttng create demo_session -o ./out
lttng enable-event -u -a
lttng add-context -u -t vpid -t vtid -t procname -t ip
lttng start
LD_PRELOAD=liblttng-ust-cyg-profile.so:liblttng-ust-dl.so deployer -s deployment.xml
lttng stop
lttng destroy
babeltrace ./out/ > trace_data.txt