import requests
from urllib.parse import quote

def replace_forward_slashes(input_string):
    return input_string.replace('/', ' ')

# query = "hello!:mfs// lmao"
# query = "hello!:mfs lmao"
# query = "hello there Everyone!"
query = "Give me the references for the paper 'A Case Study of Understanding the Bonaparte Basin using Unstructured Data Analysis with Machine Learning Techniques'."

query = replace_forward_slashes(query)
encoded_query = quote(query, safe='')
print("Encoded Query: " + encoded_query)

response = requests.get(f'http://127.0.0.1:8000/query/{encoded_query}/2/')
# response = requests.get(f'http://0.0.0.0:8000/query/{encoded_query}/2/')

if response.status_code == 200:
    data = response.json()
    # print(data)
    for datum in data:
        print(datum.keys())
        print()
        print(datum)
        print()
else:
    print(f'Error: {response.status_code}')