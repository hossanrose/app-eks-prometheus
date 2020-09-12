from flask import Flask, render_template
from markupsafe import escape
from prometheus_flask_exporter import PrometheusMetrics
import time

app = Flask(__name__)
metrics = PrometheusMetrics(app)

@app.route('/')
def main():
    return 'OK'

@app.route('/hello')
def hello_world():
    return 'Hello world | Time: %s' % escape(time.strftime('%B, %d %Y %H:%M:%S'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
