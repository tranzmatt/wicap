AKEFLAGS += --no-print-directory

PREFIX ?= /usr
SBINDIR ?= $(PREFIX)/sbin
MANDIR ?= $(PREFIX)/share/man
PKG_CONFIG ?= pkg-config

MKDIR ?= mkdir -p
INSTALL ?= install
CC ?= "gcc"

CFLAGS ?= -MMD -O2 -g
CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common

LIBS += -lpcap

OBJS += ./radiotap.o

-include $(OBJS:%.o=%.d)

all: wicap offline_wicap

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

wicap: wicap.o $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)

offline_wicap: offline_wicap.o $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)

clean:
	rm -f *.o wicap offline_wicap

.PHONY : clean
