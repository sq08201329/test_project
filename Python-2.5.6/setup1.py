#!/usr/local/python2.5/bin python
from distutils.core import setup, Extension

MOD='sunqi'
setup(name=MOD, ext_modules=[Extension(MOD, sources=['Modules/sunqi.c'])])
