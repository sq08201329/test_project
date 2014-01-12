import socket,sys
port =70
host=sys.argv[0]

filename=sys.argv[1]

s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((host,port))

s.sendall(filename+"\r\n")

while 1:
    buf=s.recv(2048)
    if not len(buf):
        break
    sys.stdout.write(buf)
