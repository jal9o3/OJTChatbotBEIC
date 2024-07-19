import socket

domain_name = "google.com"

ip_address = socket.gethostbyname(domain_name)

print(f"IP: {ip_address}")