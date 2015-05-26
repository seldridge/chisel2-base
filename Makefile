# Common configuration
DIR_SRC		= src
DIR_BUILD	= build

# Chisel/Scala configuration
SBT			?= sbt
# Unused sbt flags
_SBT_FLAGS		?= -Dsbt.log.noformat=true
SBT_FLAGS		?=
CHISEL_CONFIG_DOT       =
CHISEL_FLAGS		= --targetDir $(DIR_BUILD) \
	--test \
	--configDump \
	--compile \
	--debug \
	--vcd
CHISEL_FLAGS_CPP	= --backend c --genHarness --compile $(CHISEL_FLAGS)
CHISEL_FLAGS_V		= --backend v $(CHISEL_FLAGS)
CHISEL_FLAGS_DOT	= --backend dot $(CHISEL_FLAGS)

# Miscellaneous crap
COMMA    = ,

# Chisel Target Backends
EXECUTABLES	= Adder4 FullAdder
ALL_MODULES	= $(notdir $(wildcard $(DIR_SRC)/*.scala))
BACKEND_CPP	= $(EXECUTABLES:%=$(DIR_BUILD)/%$(CHISEL_CONFIG_DOT).cpp)
BACKEND_VERILOG = $(EXECUTABLES:%=$(DIR_BUILD)/%$(CHISEL_CONFIG_DOT).v)
BACKEND_DOT	= $(EXECUTABLES:%=$(DIR_BUILD)/%$(CHISEL_CONFIG_DOT).dot)

# C++ Backend Specific Targets
TESTS            = t_Adder4.cpp
TEST_EXECUTABLES = $(TESTS:%.cpp=$(DIR_BUILD)/%$(CHISEL_CONFIG_DOT))
OBJECTS          = $(BACKEND_CPP:%.cpp=%.o) $(TESTS:%.cpp=$(DIR_BUILD)/%.o)
VCDS             = $(TESTS:%.cpp=$(DIR_BUILD)/%.vcd)
STRIPPED         = $(EXECUTABLES:%=$(DIR_BUILD)/%-emulator-nomain.o)

vpath %.scala $(DIR_SRC)
vpath %.cpp $(DIR_SRC)
vpath %.cpp $(DIR_BUILD)

.PHONY: all clean cpp dot verilog vcd run

default: all

all: $(BACKEND_CPP)
# all: $(TEST_EXECUTABLES)

cpp: $(BACKEND_CPP)

dot: $(BACKEND_DOT)

verilog: $(BACKEND_VERILOG)

run: $(TEST_EXECUTABLES) Makefile
	$<

#------------------- Chisel Build Targets
$(DIR_BUILD)/%$(CHISEL_CONFIG_DOT).cpp: %.scala $(ALL_MODULES) Makefile
	set -e -o pipefail; \
	$(SBT) $(SBT_FLAGS) "run $(basename $(notdir $<)) $(CHISEL_FLAGS_CPP)" \
	| tee $@.out

$(DIR_BUILD)/%$(CHISEL_CONFIG_DOT).v: %.scala $(ALL_MODULES) Makefile
	set -e -o pipefail; \
	$(SBT) $(SBT_FLAGS) "run $(basename $(notdir $<)) $(CHISEL_FLAGS_V)" \
	| tee $@.out

$(DIR_BUILD)/%$(CHISEL_CONFIG_DOT).dot: %.scala $(ALL_MODULES) Makefile
	set -e -o pipefail; \
	$(SBT) $(SBT_FLAGS) "run $(basename $(notdir $<)) $(CHISEL_FLAGS_DOT)" \
	| tee $@.out

clean:
	rm -f $(DIR_BUILD)/*
	rm -rf target
