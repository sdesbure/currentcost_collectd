currentcost_collectd
====================


A node.js server which will grab information from currentcost receiver and send them to collectd

## Install

In order to make it work do the following (assuming that node.js is installed. Otherwise, install node.js first):

clone it:

```bash
$ git clone https://github.com/sdesbure/currentcost_collectd.git
```

go to the directory and install the needed packages (coffee-script is needed only if you want to hack it a little bit):

``` bash
$ cd rfxcom_collectd
$ npm install collectdout require-yaml coffee-script
$ git clone https://github.com/sdesbure/node-currentcost.git node_modules/currentcost
```

configure the yaml file accordingly. Here's the default file where you need at least to put the good id for the probes:

``` yaml
---
  collectd: # where your collectd server is
    host: "localhost"
    port: 25826
    interval: 10000 # in ms
  currentcost: # usb port where currentcost is connected.
    usb: "/dev/ttyUSB0"
  probes: # make the link between the sensor id with a human name
    0:
      name: "main"
    2:
      name: "pac"
```

Launch the script (the user must be able to open a serial port, he must be in the dialout group in debian for example):

``` bash
$ node currentcost_collectd.js
```

### Running as daemon

It depends on the distribution / OS used. In debian, change the script put in the helper folder (user and path at least, remember of the dialout group) and copy it into `/etc/init.d`. Change the name in order to have a shorter one.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Try to add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2013 Sylvain Desbureaux. See LICENSE for details.
