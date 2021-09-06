subroutine socket_setup(send_size,sendbuffer,recv_size,recvbuffer)
    use f90sockets, only : open_socket,writebuffer, readbuffer
    use, intrinsic :: iso_c_binding
    implicit none
    integer::socket
    integer::inet,port,recv_size,send_size
    character(len=1024) :: host
    real(8) :: sendbuffer(send_size),recvbuffer(recv_size)
    inet = 1
    host = "192.168.211.91"//achar(0)   ! server IP address
    port = 49152                        ! server port
    call open_socket(socket, inet, port, host)
    call writebuffer(socket, sendbuffer,send_size)
    call readbuffer(socket, recvbuffer,recv_size)
    write(*,*) recvbuffer
end subroutine
