import requests
from urllib.parse import quote

def replace_forward_slashes(input_string):
    return input_string.replace('/', ' ')

query = "hello!:mfs// lmao"
# query = "hello!:mfs lmao"
# query = "hello there Everyone!"

query = replace_forward_slashes(query)
encoded_query = quote(query, safe='')
print("Encoded Query: " + encoded_query)

# response = requests.get('http://127.0.0.1:8000/query/' + encoded_query)
response = requests.get('http://0.0.0.0:8000/query/' + encoded_query)

if response.status_code == 200:
    data = response.json()
    print(data)
else:
    print(f'Error: {response.status_code}')