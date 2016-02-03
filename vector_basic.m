function vector = vector_basic(text)
%This function converts a text string into a vector. The vector is a sorted list of
%integers (hash values).

delimiter = ‘ \f\n\r\t\v,.?!’’’”_-:;()’;
sliced_text = strsplit(text, delimiter);
sliced_text = lower(sliced_text);
vector = hashstr(sliced_text);
vector = sort(vector);

end