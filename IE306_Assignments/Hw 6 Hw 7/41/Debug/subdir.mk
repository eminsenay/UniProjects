################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
$(ROOT)/doctor.cpp \
$(ROOT)/fel.cpp \
$(ROOT)/main.cpp \
$(ROOT)/myclasses.cpp \
$(ROOT)/patient.cpp 

OBJS += \
./doctor.o \
./fel.o \
./main.o \
./myclasses.o \
./patient.o 

DEPS += \
${addprefix ./, \
doctor.d \
fel.d \
main.d \
myclasses.d \
patient.d \
}


# Each subdirectory must supply rules for building sources it contributes
%.o: $(ROOT)/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	@echo g++ -O0 -g3 -Wall -c -fmessage-length=0 -o$@ $<
	@g++ -O0 -g3 -Wall -c -fmessage-length=0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	g++ -MM -MG -P -w -O0 -g3 -Wall -c -fmessage-length=0  $< >> $(@:%.o=%.d)
	@echo 'Finished building: $<'
	@echo ' '


