% menatalla Hassan 900182848 - Nada Habib
% Comm II project phase 2 May, 2022

% clearing the work space
clc
clear 
close all

% reading the data from the text file
my_data = fileread('Project.txt');

% preparing a vector with the letters presented in the file
chars = unique(my_data)';
% getting the size of the vector - used for counting
data_size = size(my_data);
chars_size = size(chars);

% counting the number of occurances of each letter in the file
chars_count = zeros(chars_size);
for i=1:chars_size
   chars_count(i)=count(my_data,chars(i));
end

% getting the probablities of the occurance of each letter
chars_prob = chars_count/max(data_size);

% getting the entropy of the occurance of each letter
H = -chars_prob .* log2(chars_prob);

%converting the characters vector into a cell vector 
chars_cell = mat2cell(chars',1,ones(chars_size));

%using the Huffman built in functions to get the Huffman code and its
%average length 
[dict_Huff,avg_length] = huffmandict(chars_cell,chars_prob); 

%
%u={dict_Huff(:,2)};

% using the built in function to get the encoding of the file from the
% dictionary and the data vector
huff_encd = huffmanenco(my_data,dict_Huff);


%getting the size in case of Huffman encoding
total_length_Huff = 0;

for i=1:max(chars_size)
   total_length_Huff = total_length_Huff + (chars_count(i)*length(dict_Huff{i,2}));
end

%getting the size in the file generated using equal length codewords for each character

% we have chars_size of characters we need to encode
% this line gets the necessary number of bits to encode them
bits_needed = ceil(log2(max(chars_size)));
% the size of the file totally = bits needed for one character * number of
% characters in file
max(data_size)
total_length_equal =  max(data_size) * bits_needed;

% we can't use dec2bin because it gives some characters 6 bits and some 7
% bits so it's not totally equal

total_length_Huff
total_length_equal

percentage_of_reduction = (1-(total_length_Huff/total_length_equal))*100



% results:
% total length in Huffman encoding = 7255
% total length when equal number of bits for each character is used = 9756
% this proves the effeciency of the Huffan Encoding
% the pertentage of reduction in the size when using Huffman encoding is
% 25.6355%

 
%(2)Entropy and Efficiency
entropy=sum(H)
efficiencyHuff=entropy/avg_length
efficiencyEquallength=entropy/bits_needed


% comments on results of 2
% the entropy = 4.4430
% the effeciency of huffman encoding = 0.9958
% the effeciency of encoding with equal number of bits = 0.7405
% this proves that Huffman encoding is best in effeciency
