# import socket module
from socket import *

# CREATING A TCP SERVER SOCKET
serverSocket = socket(AF_INET, SOCK_STREAM)

# Prepare a sever socket
# Fill in start

# assign a port number
serverPort = 6789

# bind the socket to the server address and server port
serverSocket.bind(('', serverPort))

# listen to at most 1 connection at a time
serverSocket.listen(1)

# Fill in end

# server should be up and running and listening
while True:
    # Establish the connection
    print('Ready to serve...')
    connectionSocket, addr = serverSocket.accept()  # Fill in start	#Fill in end
    try:
        message = connectionSocket.recv(1024)  # Fill in start	#Fill in end
        filename = message.split()[1]
        f = open(filename[1:])

        outputdata = f.readlines()  # Fill in start	#Fill in end
        print(outputdata)

        # Send one HTTP header line into socket
        # Fill in start
        connectionSocket.send(b"HTTP/1.1 200 OK\r\n\r\n")
        # Fill in end

        # Send the content of the requested file to the client
        for i in range(0, len(outputdata)):
            connectionSocket.send(outputdata[i].encode())
        connectionSocket.send(b"\r\n")

        # close the client  connection socket
        connectionSocket.close()

    except IOError:
        # Send response message for file not found
        # Fill in start
        connectionSocket.send(b"HTTP/1.1 404 NOT FOUND\r\n\r\n")
        connectionSocket.send(b"<html><head></head><body><h1>404 Not Found</h1></body></html>\r\n")
        # Fill in end

        # Close client socket #Fill in start
        connectionSocket.close()
        # Fill in end
serverSocket.close()
sys.exit()  # Terminate the program after sending the corresponding data
