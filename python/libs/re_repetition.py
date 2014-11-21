import re


def test_patterns(text, patterns=[]):
    for pattern, desc in patterns:
        print('Pattern %r (%s)\n' % (pattern, desc))
        print('    %r' % text)
        for match in re.finditer(pattern, text):
            s = match.start()
            e = match.end()
            substr = text[s:e]
            #n_backslashes = text[:s].count('\\')
            #prefix = '.' * (s + n_backslashes)
            prefix = '.' * (s)
            print('    %s%r' % (prefix, substr))
        print
    return

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
    test_patterns(r'\d+ \D+ \s+', [(r'\\.\+', 'escape code'),])
