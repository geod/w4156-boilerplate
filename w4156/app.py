import boto3
from flask import Flask
app = Flask(__name__)


# dynamodb = boto3.resource(
#     'dynamodb',
#     endpoint_url='http://localhost:8000',
#     region_name='dummy_region',
#     aws_access_key_id='dummy_access_key',
#     aws_secret_access_key='dummy_secret_key',
#     verify=False)


@app.route('/')
def hello_world():
    return 'Hello, World (lets see how long a change takes)!'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)
