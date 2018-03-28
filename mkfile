STRIP     = strip
TARGET1   = testc
TARGET2   = testcc
CC        = gcc -g
CCC       = g++ -g
C_SRC     = $(wildcard *.c)
C_OBJ     = $(patsubst %.c, %.o, $(C_SRC))
CC_SRC   = $(wildcard *.cc)
CC_OBJ   = $(patsubst %.cc, %.o, $(CPP_SRC))

INCL      = 
CFLAGS    = -O2 -Wall -Werror
CCFLAGS  = -c -O2 -Wall
LDIR      = 
LIBS      = 

.PHONY:clean

all: $(TARGET1) $(TARGET2)

$(TARGET1):$(C_OBJ)
	$(CC) $(C_OBJ) -o $@ $(LDIR) $(LIBS)
	$(STRIP) $(TARGET1)
	
$(TARGET2):$(CPP_OBJ)
	$(CXX) $(CC_OBJ) -o $@ $(LDIR) $(LIBS)
	$(STRIP) $(TARGET2)
	
%.o:%.c
	$(CC) $(INCL) $(CFLAGS) $< -o $@
%.d:%.cc
	$(CCC) $(INCL) -MM $(CCFLAGS) $< > $@
%.o:%.cc
	$(CCC) $(INCL) $(CCFLAGS) $< -o $@

clean:
	rm -f $(C_OBJ) $(CC_OBJ) $(TARGET1) $(TARGET2)
