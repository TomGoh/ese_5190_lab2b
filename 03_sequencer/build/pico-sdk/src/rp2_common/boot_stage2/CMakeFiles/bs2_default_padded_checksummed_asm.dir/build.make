# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/Cellar/cmake/3.24.3/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/Cellar/cmake/3.24.3/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build

# Utility rule file for bs2_default_padded_checksummed_asm.

# Include any custom commands dependencies for this target.
include pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/compiler_depend.make

# Include the progress variables for this target.
include pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/progress.make

pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm: pico-sdk/src/rp2_common/boot_stage2/bs2_default_padded_checksummed.S

pico-sdk/src/rp2_common/boot_stage2/bs2_default_padded_checksummed.S: pico-sdk/src/rp2_common/boot_stage2/bs2_default.bin
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating bs2_default_padded_checksummed.S"
	cd /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/pico-sdk/src/rp2_common/boot_stage2 && /usr/bin/python3 /Users/haozewu/Documents/pico/pico-sdk/src/rp2_common/boot_stage2/pad_checksum -s 0xffffffff /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/pico-sdk/src/rp2_common/boot_stage2/bs2_default.bin /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/pico-sdk/src/rp2_common/boot_stage2/bs2_default_padded_checksummed.S

pico-sdk/src/rp2_common/boot_stage2/bs2_default.bin: pico-sdk/src/rp2_common/boot_stage2/bs2_default.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating bs2_default.bin"
	cd /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/pico-sdk/src/rp2_common/boot_stage2 && /opt/homebrew/bin/arm-none-eabi-objcopy -Obinary /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/pico-sdk/src/rp2_common/boot_stage2/bs2_default.elf /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/pico-sdk/src/rp2_common/boot_stage2/bs2_default.bin

bs2_default_padded_checksummed_asm: pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm
bs2_default_padded_checksummed_asm: pico-sdk/src/rp2_common/boot_stage2/bs2_default.bin
bs2_default_padded_checksummed_asm: pico-sdk/src/rp2_common/boot_stage2/bs2_default_padded_checksummed.S
bs2_default_padded_checksummed_asm: pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/build.make
.PHONY : bs2_default_padded_checksummed_asm

# Rule to build all files generated by this target.
pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/build: bs2_default_padded_checksummed_asm
.PHONY : pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/build

pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/clean:
	cd /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/pico-sdk/src/rp2_common/boot_stage2 && $(CMAKE_COMMAND) -P CMakeFiles/bs2_default_padded_checksummed_asm.dir/cmake_clean.cmake
.PHONY : pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/clean

pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/depend:
	cd /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer /Users/haozewu/Documents/pico/pico-sdk/src/rp2_common/boot_stage2 /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/pico-sdk/src/rp2_common/boot_stage2 /Users/haozewu/Documents/GitHub/ese_5190_lab2b/03_sequencer/build/pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default_padded_checksummed_asm.dir/depend

