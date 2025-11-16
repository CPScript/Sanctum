CC = gcc
CFLAGS = -Wall -Wextra -O2 -D_GNU_SOURCE
LDFLAGS = -lssl -lcrypto -lsodium -lpthread
TARGET = sanctum
SRC = main.c

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

debug: CFLAGS += -g -O0 -DDEBUG
debug: $(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all debug clean
