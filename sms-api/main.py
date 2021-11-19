from fastapi import FastAPI
from utils import get_env, get_request_data
import requests
from models import SMS
import json

app = FastAPI()

@app.get('/')
async def root():
    return {
        'status': 'Service is healthy !'
    }

@app.get('/api/v1')
async def index():
    return {
        'status': 'Welcome to SMS Sender API v1 !'
    }

async def get_access_token():
    url = '{}/oauth/v3/token'.format(get_env('ORANGE_API_ROOT_URL'))
    response = requests.post(
        url=url,
        headers={
            'Authorization': '{}'.format(get_env('ORANGE_AUTHORIZATION_HEADER')),
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
        },
        data={
            'grant_type': 'client_credentials',
        },
    )
    return response.json()['access_token']

@app.post('/api/v1/send-sms')
async def send_sms(sms_infos: SMS):
    token = await get_access_token()
    data = get_request_data(sms_infos)
    url = '{}/smsmessaging/v1/outbound/tel%3A%2B{}/requests'.format(get_env('ORANGE_API_ROOT_URL'), get_env('DEV_PHONE_NUMBER'))
    response = requests.post(
        url=url,
        data=json.dumps(data),
        headers={
            'Authorization': 'Bearer {}'.format(token),
            'Content-Type': 'application/json',
        },
    )
    if response.status_code == 201:
        return {
            'status': 'success',
            'message': 'SMS successfully sent !'
        }
    return {
        'status': 'error',
        'message': response.json()
    }