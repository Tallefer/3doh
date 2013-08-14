TARGET=3doemu
CC = g++
DEBUG =
SDL_CFLAGS := $(shell sdl-config --cflags)
SDL_LDFLAGS := $(shell sdl-config --libs)
CFLAGS =-msse3 -mfpmath=sse -march=native -ftree-vectorize -flto -Ofast -ffast-math -fomit-frame-pointer -funsafe-loop-optimizations -funsafe-math-optimizations -ffinite-math-only -fno-trapping-math -frounding-math -fsingle-precision-constant -Wall $(SDL_CFLAGS) -I./ -I./freedo -I./freedo/filters
OCFLAGS =  -g -O3 -ffast-math -Wall $(SDL_CFLAGS) -I./ -I./freedo -I./freedo/filters -fno-omit-frame-pointer
LFLAGS = -Wall $(DEBUG)
LIBS = $(SDL_LDFLAGS) -lm  -lGL -lGLU -L/usr/lib/gcc/i486-linux-gnu/4.7 -L/usr/lib -lstdc++ 

OBJS = freedo/arm.o \
freedo/DiagPort.o\
freedo/quarz.o\
freedo/Clio.o \
freedo/frame.o \
freedo/Madam.o \
freedo/vdlp.o \
freedo/_3do_sys.o \
freedo/bitop.o \
freedo/DSP.o \
freedo/Iso.o \
freedo/SPORT.o \
freedo/XBUS.o \
freedo/filters/hq2x.o \
freedo/filters/hq3x.o \
freedo/filters/hq4x.o \
freedo/filters/hqx_init.o \
video.o \
sound.o \
cdrom.o \
input.o \
main.o

all: $(TARGET)

rm-elf:
	-rm -f $(TARGET) $(OBJS)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET) $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f freedo/*.o $(TARGET)