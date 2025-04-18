# Predefined constants
CC      = cc
TARGET  = file-rom-bin
SRC_DIR = src
OBJ_DIR = obj
CFLAGS  = $(shell pkg-config --cflags gtk+-2.0) \
          $(shell pkg-config --cflags gimp-2.0)
LFLAGS  = $(shell pkg-config --libs glib-2.0) \
          $(shell pkg-config --libs gtk+-2.0) \
          $(shell pkg-config --libs gimp-2.0) \
          $(shell pkg-config --libs gimpui-2.0)

# File definitions
SRC_FILES=$(wildcard $(SRC_DIR)/*.c)
OBJ_FILES=$(SRC_FILES:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

$(TARGET): $(OBJ_DIR) $(OBJ_FILES)
	$(CC) $(OBJ_FILES) -o $(TARGET) $(LFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(OBJ_DIR):
	test -d $(OBJ_DIR) || mkdir -p $(OBJ_DIR)

clean:
	rm -rf $(OBJ_DIR)
	rm $(TARGET)

install:
	mkdir -p ~/.config/GIMP/2.10/plug-ins
	cp $(TARGET) ~/.config/GIMP/2.10/plug-ins

uninstall:
	rm ~/.config/GIMP/2.10/plug-ins/$(TARGET)

.PHONY: clean install uninstall
