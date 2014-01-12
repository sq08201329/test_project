#include <stdio.h>

int add(int a,int b)
{
	return a+b;
}
/*
int myadd()
{
	int a,b;
	return add(a,b);
}
*/

//step 1.
#include "Python.h"
static PyObject *sunqi_myadd(PyObject *self, PyObject *args)
{
	int a,b;
	if(!PyArg_ParseTuple(args, "ii", &a, &b))
		return NULL;
	return (PyObject *)Py_BuildValue("i", add(a,b));
}
//step 2.
static PyMethodDef sunqiMethods[] = {
	{"add", sunqi_myadd, METH_VARARGS},{NULL,NULL},};
//step 3.
void initsunqi() {
	Py_InitModule("sunqi", sunqiMethods);
}
//step 4.
//compile
//setup.py
/*
from distutils.core import setup, Extension

MOD='sunqi'
setup(name=MOD, ext_modules=[Extension(MOD, sources=['sunqi.c'])])
*/
//step 5.
//python setup.py destdir
//python setup.py /usr/local/python2.5/lib/python2.5/
