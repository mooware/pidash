import os
import re
import json
import subprocess
from datetime import datetime
from bottle import *

def make_service_row(array):
  (unit, load, act, sub, name) = array
  is_failed = (act == 'failed')
  is_running = (sub != 'exited')
  return (is_failed, is_running, name, unit, act, sub)

def make_journal_row(json):
  prio = json['PRIORITY']
  ts = get_journal_timestamp(json)
  app = get_journal_application(json)
  msg = json['MESSAGE']
  return (prio, ts, app, msg)

def get_journal_timestamp(json):
  ts = int(json['__REALTIME_TIMESTAMP'])
  return str(datetime.fromtimestamp(ts / 1000000.0))

def get_journal_application(json):
  return json.get('SYSLOG_IDENTIFIER') or json.get('_COMM')

@route('/css/<filename>')
@route('/js/<filename>')
@route('/fonts/<filename>')
def file(filename):
  return static_file(request.path, root=os.getcwd())

@route('/')
@route('/home')
def home():
  return template('home')

@route('/services')
def services():
  # get service data from systemctl
  # systemctl list-units
  text = subprocess.check_output(['cat', 'systemctl-data.txt'])
  lines = text.splitlines()
  # the service data ends with an empty line
  end_index = lines.index('')
  lines = lines[0:end_index]
  # separate the lines by whitespace
  table = [re.split(' +', s, 4) for s in lines]
  # reorder the fields
  table = [make_service_row(t) for t in table]
  # render
  header = table[0][2:]
  rows = table[1:]
  return template('services', header=header, rows=rows)

@route('/services/command')
def service_command():
  unit = request.forms.get('unit')
  #command = ('start' if request.forms.get('command') = 'start' else 'stop')
  return (unit, command)

@route('/journal')
def journal():
  # get service data from systemctl
  # journalctl --this-boot --output=json
  text = subprocess.check_output(['cat', 'journal.json'])
  lines = text.splitlines()
  # every line is a json doc
  data = [json.loads(s) for s in lines]
  # reorder the fields
  rows = [make_journal_row(d) for d in data]
  # render
  return template('journal', rows=rows)
