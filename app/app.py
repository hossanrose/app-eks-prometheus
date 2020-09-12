from flask import Flask, render_template
from markupsafe import escape
import time

app = Flask(__name__)

@app.route('/hello')
def hello_world():
    return 'Hello world | Time: %s' % escape(time.strftime('%B, %d %Y %H:%M:%S'))
if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=80)
