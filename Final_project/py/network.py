from socket import socket
from local_ip import getLocalIP  

PORT = 2341
TRUSTED_IP = ['10.209.9.163', '127.0.0.1', 'localhost', '10.209.5.137', '192.168.43.245', '192.168.0.166']

server = None

def connect():
    global server
    server = socket()
    server.settimeout(1)
    server.bind(('', PORT))
    server.listen(1)
    local_ip = getLocalIP()
    print('My IP is one of these:', local_ip)
    print('port:', PORT)
    while True:
        try:
            s, addr = server.accept()
            break
        except:
            pass
    print('incoming connection from', addr)
    if addr[0] in TRUSTED_IP or addr[0] in local_ip:
        print('IP is trusted. ')
    else:
        op = 'big pink'
        while op not in 'yn':
            op = input('IP not in whitelist. Accept? y/n > ')
        if op != 'y':
            print("Aborted. Let's start over. ")
            try:
                s.close()
            except:
                pass
            server.close()
            return connect()
    print('Nice! ')
    return s
