import os
import re
import subprocess

from bottle import *

@route('/')
@route('/home')
def home():
  return template('home')

@route('/css/<filename>')
@route('/js/<filename>')
@route('/fonts/<filename>')
def file(filename):
  return static_file(request.path, root=os.getcwd())

@route('/services')
def services():
  # get service data from systemctl
  text = subprocess.check_output(['cat', 'systemctl-data.txt'])
  lines = text.splitlines()
  # the service data ends with an empty line
  end_index = lines.index('')
  lines = lines[0:end_index]
  # separate the lines by whitespace
  col_count = len(re.split(' +', lines[0]))
  table = [re.split(' +', s, col_count - 1) for s in lines]
  # reorder the fields
  table = [(name, unit, load, act, sub) for [unit, load, act, sub, name] in table]
  # render
  return template('services', table=table)

run(host='localhost', port=8080, debug=True, reloader=True)
