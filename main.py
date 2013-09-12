import os
from bottle import *

@route('/')
@route('/home')
def home():
  return template('home')

@route('/css/<filename>')
def file(filename):
  return static_file(request.path, root=os.getcwd())

run(host='localhost', port=8080, debug=True, reloader=True)
