CURRENT	= $(shell uname -r)
TARGET	= asix
OBJS		= asix.o
MDIR		= drivers/net/usb

ifneq (,$(findstring 2.6.14,$(CURRENT)))
MDIR = drivers/usb/net
endif

ifneq (,$(findstring 2.6.15,$(CURRENT)))
MDIR = drivers/usb/net
endif

ifneq (,$(findstring 2.6.16,$(CURRENT)))
MDIR = drivers/usb/net
endif

ifneq (,$(findstring 2.6.17,$(CURRENT)))
MDIR = drivers/usb/net
endif

ifneq (,$(findstring 2.6.18,$(CURRENT)))
MDIR = drivers/usb/net
endif

ifneq (,$(findstring 2.6.19,$(CURRENT)))
MDIR = drivers/usb/net
endif

ifneq (,$(findstring 2.6.20,$(CURRENT)))
MDIR = drivers/usb/net
endif

ifneq (,$(findstring 2.6.21,$(CURRENT)))
MDIR = drivers/usb/net
endif

EXTRA_CFLAGS = -DEXPORT_SYMTAB
KDIR = /lib/modules/$(CURRENT)/build
PWD = $(shell pwd)
DEST = /lib/modules/$(CURRENT)/kernel/$(MDIR)

obj-m      := $(TARGET).o

default:
	make -C $(KDIR) SUBDIRS=$(PWD) modules

$(TARGET).o: $(OBJS)
	$(LD) $(LD_RFLAG) -r -o $@ $(OBJS)

install:
	su -c "cp -v $(TARGET).ko $(DEST) && /sbin/depmod -a"

clean:
	-rm -f *.o *.ko .*.cmd .*.flags *.mod.c

-include $(KDIR)/Rules.make
