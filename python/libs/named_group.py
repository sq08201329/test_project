import re

text = 'This is some text abct -- with punctuation.'
print(text)
print

for pattern in [r'^(?P<first_word>\w+)',
                r'(?P<last_word>\w+)\S*$',
                r'(?P<t_word>\bt\w+)\W+(?P<other_word>\w+)',
                r'(?P<end_with_t>\w+t)\b',
                ]:

    regex = re.compile(pattern)
    match = regex.search(text)
    print('matching "%s"' % pattern)
    print('  ', match.groups())
    print('  ', match.groupdict())
    print
