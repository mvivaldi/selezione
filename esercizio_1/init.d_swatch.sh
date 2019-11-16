#! /bin/sh
#
# Swatch      This shell script takes care of starting and stopping
#             swatch.
#
# chkconfig: - 90 35
# description: The Simple WATCHer is an automated monitoring tool \
#              that is capable of alerting system administrators \
#              of anything that matches the patterns described \
#              in the configuration file, whilst constantly searching \
#              logfiles using perl.
#
# processname: swatch
# config: /etc/swatch/swtchrc

CHECK_LOG="/var/log/messages"
SWATCH_CONF="/etc/swatch/swatchrc"

SWATCH_BIN="/usr/bin/swatch"
SWATCH_LOG="/var/log/swatch"
SWATCH_SCRIPT="/var/run/swatch"

# Source function library.
if [ -f /etc/init.d/functions ] ; then
 . /etc/init.d/functions
elif [ -f /etc/rc.d/init.d/functions ] ; then
 . /etc/rc.d/init.d/functions
else
 exit 0
fi

# Check that swatch exists.
if [ ! -x ${SWATCH_BIN} ]; then
   echo "Swatch, ${SWATCH_BIN} not installed!"
   exit 0
fi

# Check that swatch configuration file exists.
if [ ! -f ${SWATCH_CONF} ]; then
   # Tell the user this has skipped
   echo "Swatch configuration file, ${SWATCH_CONF} does not exist."
   exit 0
fi

prog=swatch
RETVAL=0

pid_check() {
   SWATCH_PID=`pidof tail`
   [ $? -ne 0 ] && SWATCH_PID=""
}

start() {
   pid_check
   if [ "$SWATCH_PID" != "" ]; then
       echo "Warning: Swatch System already running!"
   else
       echo -n $"Starting $prog: "
       `daemon $SWATCH_BIN -c $SWATCH_CONF -t $CHECK_LOG --script-dir=$SWATCH_SCRIPT >> \
           $SWATCH_LOG &` && success || failure
       RETVAL=$?
           echo
   fi
   return $RETVAL
}

stop() {
   pid_check
   if [ "${SWATCH_PID}" == "" ]; then
       echo "Warning: Swatch System not running!"
   else
       echo -n $"Stopping $prog: "
       killproc tail
       RETVAL=$?
       echo
   fi
   return $RETVAL
}

# See how we were called.
case "$1" in
   start)
       start
       ;;
   stop)
       stop
       ;;
   restart)
       stop
       start
       RETVAL=$?
       ;;
   *)
       echo $"Usage: $0 {start|stop|restart}"
       exit 1
esac

exit $RETVAL