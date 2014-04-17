require 'require-yaml'
CurrentCost = require('currentcost');
Collectd = require 'collectdout'

config = require './config.yml'
# console.log config

currentcost = new CurrentCost.CurrentCost config.currentcost.usb
#console.log currentcost
client = new Collectd config.collectd.interval, config.collectd.host, config.collectd.port

sensors = {}
for probe, values of config.probes
  sensors[probe] = name: values.name, \
  temperature: 0.0, \
  power: 0.0, \
  plugin: client.plugin 'current_cost', values.name

currentcost.on 'incremental', (data) ->
  sensors[data.sensor].temperature = data.tmpr
  sensors[data.sensor].power = data.ch1.watts
  #console.log "received temperature %d, power %d for probe %s", sensors[data.sensor].temperature, sensors[data.sensor].power, data.sensor

currentcost.on 'history', (data) ->
  
start = currentcost.begin()

currentcost.on 'error', (data) ->
  console.log 'Error!'
  console.log data

setInterval () ->
  for sensor_id, values of sensors
    values.plugin.setGauge 'temperature', 'temperature', values.temperature
    values.plugin.setGauge 'power', 'power', values.power
    console.log "sent temperature %d, power %d for probe %s", values.temperature, values.power, sensor_id
, config.collectd.interval
