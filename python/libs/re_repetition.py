import re


def test_patterns(text, patterns=[]):
    for pattern, desc in patterns:
        print('Pattern %r (%s)\n' % (pattern, desc))
        print('    %r' % text)
        for match in re.finditer(pattern, text):
            s = match.start()
            e = match.end()
            substr = text[s:e]
            prefix = '.' * (s)
            #n_backslashes = text[:s].count('\\')
            #prefix = '.' * (s + n_backslashes)
            print('    %s%r%s ' % (prefix, substr, ' ' * (len(text) - e)))
            print(match.groups())
            if match.groupdict():
                print("%s%s" % ((' ' * len(text) - s), match.groupdict()))
        print
    return


def test_patterns2(text, patterns=[]):
    for pattern, desc in patterns:
        #print(pattern)
        #print(desc)
        regex = re.compile(pattern)
        match = regex.search(text)
        #print(match)
        print('Pattern %r (%s)\n' % (pattern, desc))
        try:
            print('  ', match.groups())
        except AttributeError:
            print('not matched')
            print
            continue
        print

if __name__ == '__main__':
    test_patterns('abbaaabbbbaaaaa', [('ab', "'a' followed by 'b'"), ])
    test_patterns('abbaabbba', [('ab*', "'a' followed by zero or more 'b'"),
                                ('ab+', "'a' followed by one or more 'b'"),
                                ('ab?', "'a' followed by zeor or one 'b'"),
                                ('ab{3}', "'a' followed by three 'b'"),
                                ('ab{2, 3}', "'a' followed by two or three 'b'")])
    test_patterns('abbaabbba', [('ab*?', "'a' followed by zero or more 'b'"),
                                ('ab+?', "'a' followed by one or more 'b'"),
                                ('ab??', "'a' followed by zeor or one 'b'"),
                                ('ab{3}?', "'a' followed by three 'b'"),
                                ('ab{2, 3}?', "'a' followed by two or three 'b'")])
    test_patterns('This is some text -- with punction.', [('[^-. ]+', 'sequences without -, ., or space')])
    test_patterns('A prime #1 example!', [(r'\d+', 'sequence of digits'),
                                          (r'\D+', 'sequence of nondigits'),
                                          (r'\s+', 'sequence of whitespace'),
                                          (r'\S+', 'sequence of nonwhitespace'),
                                          (r'\w+', 'sequence of alphanumeric characters'),
                                          (r'\W+', 'sequence of nonalphanumeric characters')])
    test_patterns(r'\d+ \D+ \s+', [(r'\\.\+', 'escape code'), ])
    test_patterns('This is some text -- with punction.', [(r'^\w+', 'word at start of string'),
                                                          (r'\A\w+', 'word at start of string'),
                                                          (r'\w+\S*$', 'word near end of string , skip punction'),
                                                          (r'\w+\S*\Z', 'word near end of string, skip punction'),
                                                          (r'\w*t\w*', 'word containing t'),
                                                          (r'\bt\w+', 'word start with t'),
                                                          (r'\w+t\b', 'word end with t'),
                                                          (r'\Bt\B', 't, not start or end of word'), ])
    test_patterns('abbaaabbbbaaaaa', [('a(ab)', "'a' followed by 'ab'"),
                                      ('a(a*b*)', "'a' followed by 0-n 'a' and 0-n 'b'"),
                                      ('a(ab)*', "'a' followed by 0-n 'ab'"),
                                      ('a(ab)+', "'a' followed by 1-n 'ab'"), ])
    test_patterns2('This is some text -- with punction.', [(r'^(\w+)', 'word at start of string'),
                                                           (r'(\w+)\S*$', 'word at end, with optional punction'),
                                                           (r'(\bt\b)\W+(\w)', 'word start with t , another word'),
                                                           (r'(\w+)\b', 'word ending with t')])
    test_patterns('abbaabbba', [(r'a((a*)(b*))', 'a followed by 0-n a and 0-n b'), ])
    test_patterns('abbaabbba', [(r'a((a+)|(b+))', 'capturing form'), (r'a((?:a+)|(?:b+))', 'noncapturing'), ])
