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

# Produce verbose output by default.
VERBOSE = 1

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
CMAKE_COMMAND = C:/Xilinx/Vitis/2023.2/tps/win64/cmake-3.24.2/bin/cmake.exe

# The command to remove a file.
RM = C:/Xilinx/Vitis/2023.2/tps/win64/cmake-3.24.2/bin/cmake.exe -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp

# Include any dependencies generated for this target.
include libsrc/qspips/src/CMakeFiles/qspips.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include libsrc/qspips/src/CMakeFiles/qspips.dir/compiler_depend.make

# Include the progress variables for this target.
include libsrc/qspips/src/CMakeFiles/qspips.dir/progress.make

# Include the compile flags for this target's objects.
include libsrc/qspips/src/CMakeFiles/qspips.dir/flags.make

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/flags.make
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips.c.obj: C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips.c
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips.c.obj"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips.c.obj -MF CMakeFiles/qspips.dir/xqspips.c.obj.d -o CMakeFiles/qspips.dir/xqspips.c.obj -c C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips.c

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/qspips.dir/xqspips.c.i"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips.c > CMakeFiles/qspips.dir/xqspips.c.i

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/qspips.dir/xqspips.c.s"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips.c -o CMakeFiles/qspips.dir/xqspips.c.s

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_g.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/flags.make
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_g.c.obj: C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_g.c
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_g.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_g.c.obj"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_g.c.obj -MF CMakeFiles/qspips.dir/xqspips_g.c.obj.d -o CMakeFiles/qspips.dir/xqspips_g.c.obj -c C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_g.c

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_g.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/qspips.dir/xqspips_g.c.i"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_g.c > CMakeFiles/qspips.dir/xqspips_g.c.i

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_g.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/qspips.dir/xqspips_g.c.s"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_g.c -o CMakeFiles/qspips.dir/xqspips_g.c.s

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_hw.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/flags.make
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_hw.c.obj: C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_hw.c
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_hw.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_hw.c.obj"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_hw.c.obj -MF CMakeFiles/qspips.dir/xqspips_hw.c.obj.d -o CMakeFiles/qspips.dir/xqspips_hw.c.obj -c C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_hw.c

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_hw.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/qspips.dir/xqspips_hw.c.i"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_hw.c > CMakeFiles/qspips.dir/xqspips_hw.c.i

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_hw.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/qspips.dir/xqspips_hw.c.s"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_hw.c -o CMakeFiles/qspips.dir/xqspips_hw.c.s

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_options.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/flags.make
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_options.c.obj: C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_options.c
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_options.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_options.c.obj"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_options.c.obj -MF CMakeFiles/qspips.dir/xqspips_options.c.obj.d -o CMakeFiles/qspips.dir/xqspips_options.c.obj -c C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_options.c

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_options.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/qspips.dir/xqspips_options.c.i"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_options.c > CMakeFiles/qspips.dir/xqspips_options.c.i

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_options.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/qspips.dir/xqspips_options.c.s"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_options.c -o CMakeFiles/qspips.dir/xqspips_options.c.s

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_selftest.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/flags.make
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_selftest.c.obj: C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_selftest.c
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_selftest.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_selftest.c.obj"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_selftest.c.obj -MF CMakeFiles/qspips.dir/xqspips_selftest.c.obj.d -o CMakeFiles/qspips.dir/xqspips_selftest.c.obj -c C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_selftest.c

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_selftest.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/qspips.dir/xqspips_selftest.c.i"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_selftest.c > CMakeFiles/qspips.dir/xqspips_selftest.c.i

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_selftest.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/qspips.dir/xqspips_selftest.c.s"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_selftest.c -o CMakeFiles/qspips.dir/xqspips_selftest.c.s

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_sinit.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/flags.make
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_sinit.c.obj: C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_sinit.c
libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_sinit.c.obj: libsrc/qspips/src/CMakeFiles/qspips.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_sinit.c.obj"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_sinit.c.obj -MF CMakeFiles/qspips.dir/xqspips_sinit.c.obj.d -o CMakeFiles/qspips.dir/xqspips_sinit.c.obj -c C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_sinit.c

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_sinit.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/qspips.dir/xqspips_sinit.c.i"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_sinit.c > CMakeFiles/qspips.dir/xqspips_sinit.c.i

libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_sinit.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/qspips.dir/xqspips_sinit.c.s"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && C:/Xilinx/Vitis/2023.2/gnu/aarch32/nt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src/xqspips_sinit.c -o CMakeFiles/qspips.dir/xqspips_sinit.c.s

# Object files for target qspips
qspips_OBJECTS = \
"CMakeFiles/qspips.dir/xqspips.c.obj" \
"CMakeFiles/qspips.dir/xqspips_g.c.obj" \
"CMakeFiles/qspips.dir/xqspips_hw.c.obj" \
"CMakeFiles/qspips.dir/xqspips_options.c.obj" \
"CMakeFiles/qspips.dir/xqspips_selftest.c.obj" \
"CMakeFiles/qspips.dir/xqspips_sinit.c.obj"

# External object files for target qspips
qspips_EXTERNAL_OBJECTS =

libsrc/qspips/src/libqspips.a: libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips.c.obj
libsrc/qspips/src/libqspips.a: libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_g.c.obj
libsrc/qspips/src/libqspips.a: libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_hw.c.obj
libsrc/qspips/src/libqspips.a: libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_options.c.obj
libsrc/qspips/src/libqspips.a: libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_selftest.c.obj
libsrc/qspips/src/libqspips.a: libsrc/qspips/src/CMakeFiles/qspips.dir/xqspips_sinit.c.obj
libsrc/qspips/src/libqspips.a: libsrc/qspips/src/CMakeFiles/qspips.dir/build.make
libsrc/qspips/src/libqspips.a: libsrc/qspips/src/CMakeFiles/qspips.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Linking C static library libqspips.a"
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && $(CMAKE_COMMAND) -P CMakeFiles/qspips.dir/cmake_clean_target.cmake
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/qspips.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
libsrc/qspips/src/CMakeFiles/qspips.dir/build: libsrc/qspips/src/libqspips.a
.PHONY : libsrc/qspips/src/CMakeFiles/qspips.dir/build

libsrc/qspips/src/CMakeFiles/qspips.dir/clean:
	cd C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src && $(CMAKE_COMMAND) -P CMakeFiles/qspips.dir/cmake_clean.cmake
.PHONY : libsrc/qspips/src/CMakeFiles/qspips.dir/clean

libsrc/qspips/src/CMakeFiles/qspips.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/qspips/src C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src C:/Users/Eier/Vprojects/ws_poc/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/libsrc/build_configs/gen_bsp/libsrc/qspips/src/CMakeFiles/qspips.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : libsrc/qspips/src/CMakeFiles/qspips.dir/depend

