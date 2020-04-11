#!/usr/bin/env python3
import socket
import sys
import threading
import time
import re
from functions.worker import worker
from env_variables import SERVER_IP
from env_variables import SERVER_PORT
from env_variables import cisco_username
from env_variables import cisco_password
from functions.logging import myLogger



log = myLogger("pythong_logger")

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_address = (SERVER_IP, SERVER_PORT)
log.info("SERVER: Server starting up on {} TCP port {}".format(server_address[0],server_address[1]))
print('INFO: Server starting up on {} TCP port {}'.format(server_address[0],server_address[1]))
sock.bind(server_address)
sock.listen(1)

def main():
    while True:
        # Wait for a connection
        log.info("SERVER: Server is waiting for a connection")
        print('INFO: Server is waiting for a connection')
        connection, client_address = sock.accept()
        log.info("SERVER: Connection from {}".format(client_address))
        print('INFO: Connection from', client_address)
        # Receive the data in small chunks and retransmit it
        while True:
            time.sleep(1)
            data = connection.recv(1024)
    
            if data:
                data = str(data)
                log.info("SERVER: {}".format(data))
                print("INFO", data)

                if "Configured from" in data and "admin" not in data:
                    
                    ip_addr =  re.findall(r"\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b ",data)
                    if len(ip_addr) >= 1:
                        # Regular IP on the Syslog
                        for ip in ip_addr:
                            log.info("SERVER: Creating Worker for the ip: {}".format(ip))
                            print("INFO: Creating Worker for the ip: {}".format(ip))
                            log_worker = threading.Thread(target=worker, args=(ip,cisco_username,cisco_password))
                            log.info("SERVER: Launching worker to perform config diff: {}".format(ip))
                            print("INFO: Launching worker to perform config diff: {}".format(ip))
                            log_worker.start()

            else:
                connection.close()
                break

if __name__ == "__main__":
    main()