import numpy as np
import socket

def read_state(socket, dest, buf):
    blen = dest.itemsize * dest.size
    if (blen > len(buf)):
        buf.resize(blen,refcheck=False)
    bpos = 0
    while bpos < blen:
        timeout = False
        # post-2.5 version: slightly more compact for modern python versions
        try:
            bpart = 1
            bpart = socket.recv_into(buf[bpos:], blen - bpos)
        except socket.timeout:
            print(" @SOCKET:   Timeout in status recvall, trying again!")
            timeout = True
            pass
        bpos += bpart
    if np.isscalar(dest):
        return np.fromstring(buf[0:blen], dest.dtype)[0]
    else:
        return np.fromstring(buf[0:blen], dest.dtype).reshape(dest.shape, order='F')

def recv_socket(recv_size):
    port=49152
    host="192.168.211.91"
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serversocket.bind((host, port))
    serversocket.listen(1)
    clientsocket, _ = serversocket.accept()
    recv_buffer = np.ones(recv_size,dtype=np.float64)
    buf = np.zeros(0,np.byte)
    recv_buffer = read_state(clientsocket, recv_buffer, buf)
    return recv_buffer








