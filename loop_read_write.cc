
int loop_write(int fd,void *buffer,int length)
{
int bytes_left;
int written_bytes;
char *ptr;

ptr=buffer;
bytes_left=length;
while(bytes_left>0)
{
        
       written_bytes=write(fd,ptr,bytes_left);
         if(written_bytes<=0)
         {       
                 if(errno==EINTR)
                         written_bytes=0;
                 else             
                         return(-1);
         }
         bytes_left-=written_bytes;
         ptr+=written_bytes;     
}
return(0);
}

int loop_read(int fd,void *buffer,int length)
{
int bytes_left;
int bytes_read;
char *ptr;
  
bytes_left=length;
while(bytes_left>0)
{
    bytes_read=read(fd,ptr,bytes_read);
    if(bytes_read<0)
    {
      if(errno==EINTR)
         bytes_read=0;
      else
         return(-1);
    }
    else if(bytes_read==0)
        break;
     bytes_left-=bytes_read;
     ptr+=bytes_read;
}
return(length-bytes_left);
}
