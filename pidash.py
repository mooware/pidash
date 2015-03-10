import os, subprocess
from datetime import datetime
from bottle import *

def make_service_table(data):
  import re
  lines = data.splitlines()
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
  return (rows, header)

def make_journal_table(data):
  import json
  lines = data.splitlines()
  lines.reverse()
  # every line is a json doc
  docs = [json.loads(s) for s in lines]
  # reorder the fields
  rows = [make_journal_row(d) for d in docs]
  return rows

def make_service_row(array):
  (unit, load, act, sub, name) = array
  is_failed = (act == 'failed')
  is_running = (sub not in ['exited', 'dead', 'failed'])
  return (is_failed, is_running, name, unit, act, sub)

def make_journal_row(json):
  prio = int(json.get('PRIORITY', 0))
  ts = get_journal_timestamp(json)
  app = get_journal_application(json)
  msg = json.get('MESSAGE', '-- no message --')
  return (prio, ts, app, msg)

def get_journal_timestamp(json):
  ts = int(json.get('__REALTIME_TIMESTAMP', 0))
  return str(datetime.fromtimestamp(ts / 1000000.0))

def get_journal_application(json):
  return json.get('SYSLOG_IDENTIFIER') or json.get('_COMM')

def get_service_data():
  return subprocess.check_output(['systemctl', 'list-units', '--type=service', '--no-pager', '--all', '--full'])

def get_journal_data(lines=None):
  cmd = ['sudo', '-n', 'journalctl', '--this-boot', '--no-pager', '--output=json']
  if lines:
    cmd.append('--lines={:}'.format(int(lines)))
  return subprocess.check_output(cmd)

def get_uptime_data():
  return subprocess.check_output(['uptime'])

def run_system_command(command):
  subprocess.check_call(['sudo', '-n', 'systemctl', command])

def run_service_command(service, command):
  subprocess.check_call(['sudo', '-n', 'systemctl', command, service])

@route('/css/<filename>')
@route('/js/<filename>')
@route('/fonts/<filename>')
def file(filename):
  return static_file(request.path, root=os.getcwd())

@route('/')
def home():
  uptime = get_uptime_data()
  return template('home', uptime=uptime, host=request.urlparts.hostname)

@post('/command')
def system_command():
  command = request.forms.get('command').lower()
  run_system_command(command)
  redirect('/')

@route('/services')
def services():
  data = get_service_data()
  (rows, header) = make_service_table(data)
  return template('services', header=header, rows=rows)

@post('/services/command')
def service_command():
  unit = request.forms.get('unit')
  command = request.forms.get('command').lower()
  run_service_command(unit, command)
  redirect('/services')

@route('/journal')
def journal():
  DEFAULT_LINES = 1000
  lines = int(request.query.get('lines', DEFAULT_LINES))
  show_all = bool(request.query.get('all'))
  # get journal data from journalctl
  data = get_journal_data(lines if not show_all else 0)
  rows = make_journal_table(data)
  return template('journal', rows=rows)

if __name__ == '__main__':
  run(host='0.0.0.0', port=8080, quiet=True)
