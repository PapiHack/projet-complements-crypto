from dotenv import dotenv_values
from models import SMS

env = dotenv_values('./.env')

def get_env(var_name: str) -> str:
    return env[var_name]

def get_request_data(infos: SMS):
    return {
        'outboundSMSMessageRequest': {
            'address': 'tel:+{}'.format(infos.phone_number),
            'senderAddress': 'tel:+{}'.format(get_env('DEV_PHONE_NUMBER')),
            'outboundSMSTextMessage': {
                'message': '{}'.format(infos.message)
            }
        }
    }