TARGET_EXEC ?= exe

BUILD_DIR ?= ./obj
SRC_DIRS ?= $(shell find . -type d -name src)

SRCS := $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c -or -name *.s)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

LDFLAGS := 

CC := clang
CPPFLAGS ?= -std=c11 -MMD -MP -O0 -g3 -Wall -Weverything -pedantic 
# CC := tcc
# CPPFLAGS ?= $(INC_FLAGS) -Wall -Wpedantic 
# CC := gcc
# CPPFLAGS ?= $(INC_FLAGS) -std=gnu11 -MMD -MP -O0 -pg -Wall -Wpedantic 

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# assembly
$(BUILD_DIR)/%.s.o: %.s
	$(MKDIR_P) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# c++ source
$(BUILD_DIR)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@


.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

-include $(DEPS)

MKDIR_P ?= mkdir -p
