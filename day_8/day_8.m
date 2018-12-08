clear; clc; close all;
clear global; 

Input = load('day_8_input.txt');

global NodeIndex;
NodeIndex = 1;
global MetaData;

InputIndex = 1;
[InputIndex, NodeValue] = read_node(Input, InputIndex);

sum(cell2mat(MetaData))

NodeValue

