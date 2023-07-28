import traceback
from socket import *
import sys

server_host = sys.argv[1]
server_port = int(sys.argv[2])
filename = sys.argv[3]

# concat the strings as host_port
host_port = f"{server_host}:{server_port}"

try:
    print("ready...")
    client_socket = socket(AF_INET, SOCK_STREAM)  # create a TCP socket
    client_socket.connect((server_host, server_port))  # connect to the server

    # Construct the HTTP header
    http_header = f"GET /{filename} HTTP/1.1\r\n" \
                  f"Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\n" \
                  f"Accept-Language: en-us\r\n" \
                  f"Host: {host_port}\r\n\r\n"

    client_socket.send(http_header.encode())  # encode http header and send it to server as bytes

    # get the response from the server with size of 1024 bytes
    response_message = client_socket.recv(1024)

    final = b""  # empty bytes object

    while response_message:
        final += response_message
        response_message = client_socket.recv(1024)

    # Print the response from the server
    print(final.decode())

except Exception:
    # print(f"Error: {e}")
    traceback.print_exc()

client_socket.close()
