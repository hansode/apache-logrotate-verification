apache logrotate verification
=============================

System Requirements
-------------------

+ [Vagrant](http://www.vagrantup.com/downloads.html)
+ [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

Getting Started
---------------

```
$ vagrant up
```

Log Rotate Tests
================

| node   | service httpd <command> |
|:-------|:------------------------|
| node01 | reload                  |
| node02 | graceful                |

Scenario Testing
----------------

1. grow access_log
2. keep connection in bacground
3. force logrotate
4. list log files
5. kill bacground process

Run tests
---------

```
$ time ./run-tests.sh
```

```
Mon Mar 31 18:02:50 JST 2014
=== node01 ===
... 1 GET /cgi-bin/env.cgi
... 2 GET /cgi-bin/env.cgi
... 3 GET /cgi-bin/env.cgi
  PID TTY          TIME CMD
11400 pts/0    00:00:00 curl
Mon Mar 31 18:02:52 JST 2014
... sleep:300
logrotate ....
/var/log/httpd/*log {
   #weekly
    rotate 5
    missingok
    compress
    delaycompress
    sharedscripts
    postrotate
        /sbin/service httpd reload > /dev/null 2>/dev/null || true
    endscript
}
curl: (18) transfer closed with outstanding read data remaining
total 48
drwx------ 2 root root 4096 Mar 31 18:02 .
drwxr-xr-x 6 root root 4096 Mar 31 16:15 ..
-rw-r--r-- 1 root root  576 Mar 31 18:02 access_log.1
-rw-r--r-- 1 root root  183 Mar 31 18:02 access_log.2.gz
-rw-r--r-- 1 root root  183 Mar 31 18:02 access_log.3.gz
-rw-r--r-- 1 root root  183 Mar 31 18:01 access_log.4.gz
-rw-r--r-- 1 root root  184 Mar 31 18:00 access_log.5.gz
-rw-r--r-- 1 root root  245 Mar 31 18:02 error_log.1
-rw-r--r-- 1 root root  272 Mar 31 18:02 error_log.2.gz
-rw-r--r-- 1 root root  272 Mar 31 18:02 error_log.3.gz
-rw-r--r-- 1 root root  275 Mar 31 18:01 error_log.4.gz
-rw-r--r-- 1 root root  271 Mar 31 18:00 error_log.5.gz
kill 11400
/vagrant/logrotate-test.sh: line 48: kill: (11400) - No such process
=> OK
Connection to 127.0.0.1 closed.
=== node02 ===
... 1 GET /cgi-bin/env.cgi
... 2 GET /cgi-bin/env.cgi
... 3 GET /cgi-bin/env.cgi
  PID TTY          TIME CMD
 4269 pts/0    00:00:00 curl
Mon Mar 31 18:03:00 JST 2014
... sleep:300
logrotate ....
/var/log/httpd/*log {
   #weekly
    rotate 5
    missingok
    compress
    delaycompress
    sharedscripts
    postrotate
        /sbin/service httpd graceful > /dev/null 2>/dev/null || true
    endscript
}
total 56
drwx------ 2 root root 4096 Mar 31 18:03 .
drwxr-xr-x 6 root root 4096 Mar 31 17:30 ..
-rw-r--r-- 1 root root 1089 Mar 31 18:03 access_log
-rw-r--r-- 1 root root 2512 Mar 31 18:03 access_log.1
-rw-r--r-- 1 root root  276 Mar 31 18:03 access_log.2.gz
-rw-r--r-- 1 root root  276 Mar 31 18:02 access_log.3.gz
-rw-r--r-- 1 root root  278 Mar 31 18:01 access_log.4.gz
-rw-r--r-- 1 root root  274 Mar 31 18:00 access_log.5.gz
-rw-r--r-- 1 root root  245 Mar 31 18:03 error_log
-rw-r--r-- 1 root root  432 Mar 31 18:03 error_log.1
-rw-r--r-- 1 root root  268 Mar 31 18:03 error_log.2.gz
-rw-r--r-- 1 root root  268 Mar 31 18:02 error_log.3.gz
-rw-r--r-- 1 root root  272 Mar 31 18:01 error_log.4.gz
-rw-r--r-- 1 root root  268 Mar 31 18:00 error_log.5.gz
kill 4269
=> OK
Connection to 127.0.0.1 closed.
All test passed!!!
```

License
-------

[Beerware](http://en.wikipedia.org/wiki/Beerware) license.

If we meet some day, and you think this stuff is worth it, you can buy me a beer in return.
