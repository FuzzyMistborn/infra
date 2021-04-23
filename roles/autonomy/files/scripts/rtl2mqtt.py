#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

import subprocess
import sys
import time
import paho.mqtt.client as mqtt
import os
import json
import re

from config import *

rtl_433_cmd = "/usr/local/bin/rtl_433 -C si -M newmodel -R 40 -R 41 -F json"

important_rtl_output_re = re.compile("^(Found|Tuned)")

# Define MQTT event callbacks
def on_connect(client, userdata, flags, rc):
    connect_statuses = {
        0: "Connected",
        1: "incorrect protocol version",
        2: "invalid client ID",
        3: "server unavailable",
        4: "bad username or password",
        5: "not authorised"
    }
    print("MQTT: " + connect_statuses.get(rc, "Unknown error"))

def on_disconnect(client, userdata, rc):
    if rc != 0:
        print("Unexpected disconnection")
    else:
        print("Disconnected")

def on_message(client, obj, msg):
    print(msg.topic + " " + str(msg.qos) + " " + str(msg.payload))

def on_publish(client, obj, mid):
    print("Pub: " + str(mid))

def on_subscribe(client, obj, mid, granted_qos):
    print("Subscribed: " + str(mid) + " " + str(granted_qos))

def on_log(client, obj, level, string):
    print(string)

# Setup MQTT connection
mqttc = mqtt.Client()

mqttc.on_connect = on_connect
mqttc.on_subscribe = on_subscribe
mqttc.on_disconnect = on_disconnect

if DEBUG:
    print("Debugging messages enabled")
    mqttc.on_log = on_log
    mqttc.on_message = on_message
    mqttc.on_publish = on_publish

if MQTT_PASS:
    print("Connecting with authentication")
    mqttc.username_pw_set(MQTT_USER, password=MQTT_PASS)
else:
    print("Connecting without authentication")

mqttc.connect(MQTT_HOST, MQTT_PORT, 60)
mqttc.loop_start()

# Start RTL433 listener
print("Starting RTL433")
rtl433_proc = subprocess.Popen(rtl_433_cmd.split(), stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)

while True:
    if rtl433_proc.poll() is not None:
        print("RTL433 exited with code " + str(rtl433_proc.poll()))
        sys.exit(rtl433_proc.poll())

    for line in iter(rtl433_proc.stdout.readline, '\n'):
        if DEBUG:
            print("RTL: " + line)
        elif important_rtl_output_re.match(line):
            print(line)

        if rtl433_proc.poll() is not None:
            print("RTL433 exited with code " + str(rtl433_proc.poll()))
            sys.exit(rtl433_proc.poll())

        if "time" in line:
            mqttc.publish(MQTT_TOPIC, payload=line, qos=MQTT_QOS, retain=True)
            json_dict = json.loads(line)
            for item in json_dict:
                value = json_dict[item]
                if item == "model":
                    subtopic = value
                if item == "id":
                    subtopic += "/" + str(value)

            for item in json_dict:
                value = json_dict[item]
                if not "model" in item:
                    mqttc.publish(MQTT_TOPIC+"/"+subtopic+"/"+item, payload=value, qos=MQTT_QOS, retain=True)
