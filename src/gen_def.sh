#!/bin/bash

timestamp=$(date +%Y/%m/%d-%H:%M:%S)
printf "// This is generated automatically on ${timestamp}\n"
printf "// Check the # of bits for state registers !!!\n"
printf "// Check the # of bits for flag registers !!!\n\n"

STATES=("S_RST"             \
        "S_IDLE"            \
        "S_G"               \
        "S_Y"               \
        "S_R"               \
)

FLAGS=("F_IDLE"             \
       "F_1"                \
       "F_2"                \
       "F_3"                \
       "F_4"                \
       "F_5"                \
       "F_6"                \
       "F_FINISH"           \
)
def_pattern="%-30s \t %-3s\n"

# Generate macro
printf "\`ifndef __FLAG_DEF__\n"
printf "\`define __FLAG_DEF__\n"

# Generate flags
len=${#FLAGS[@]}
printf "\n// There're ${len} flags in this design\n"
for((idx=0; idx<${len}; idx++))
do
  printf "$def_pattern" "\`define ${FLAGS[$idx]}" "${idx}"
done

# Generate flag width
printf "$def_pattern" "\`define FLAG_W" "`expr ${idx}`"

# Generate FSM states
len=${#STATES[@]}
printf "\n// There're ${len} states in this design\n"
for((idx=0; idx<${len}; idx++))
do
  printf "$def_pattern" "\`define ${STATES[$idx]}" "${idx}"
done

# Generate FSM init vector
printf "$def_pattern" "\`define STATE_INIT" "${len}'b0"
printf "$def_pattern" "\`define STATE_W"    "${len}"

# Generate other macro
printf "\n// Macro from template\n"
printf "$def_pattern" "\`define BUF_SIZE"             "8'd66"
printf "$def_pattern" "\`define READ_MEM_DELAY"       "2'd2"

printf "$def_pattern" "\`define EMPTY_ADDR"           "{12{1'b0}}"
printf "$def_pattern" "\`define EMPTY_DATA"           "{20{1'b0}}"

printf "$def_pattern" "\`define LOCAL_IDX_W"          "16"
printf "$def_pattern" "\`define DATA_W"               "20"

printf "\n// Self-defined macro\n"
printf "$def_pattern" "\`define COUNTER_W"            "15"

# Generate end macro
printf "\n\`endif\n"
