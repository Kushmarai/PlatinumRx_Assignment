# 2) You are given a string, remove all the duplicates and print the unique string.
# Use loop in the python.

def remove_duplicates(input_string):
    result = ""
    for char in input_string:
        if char not in result:
            result = result + char
    return result

# Test cases
print(remove_duplicates("python programming"))   # progamin
print(remove_duplicates("aabbcc"))        # abc
print(remove_duplicates("data analyst"))  # dat nlyse