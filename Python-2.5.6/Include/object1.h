# 1 "object.h"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "object.h"
# 103 "object.h"
typedef struct _object {
 Py_ssize_t ob_refcnt; struct _typeobject *ob_type;
} PyObject;

typedef struct {
 Py_ssize_t ob_refcnt; struct _typeobject *ob_type; Py_ssize_t ob_size;
} PyVarObject;
# 127 "object.h"
typedef PyObject * (*unaryfunc)(PyObject *);
typedef PyObject * (*binaryfunc)(PyObject *, PyObject *);
typedef PyObject * (*ternaryfunc)(PyObject *, PyObject *, PyObject *);
typedef int (*inquiry)(PyObject *);
typedef Py_ssize_t (*lenfunc)(PyObject *);
typedef int (*coercion)(PyObject **, PyObject **);
typedef PyObject *(*intargfunc)(PyObject *, int) Py_DEPRECATED(2.5);
typedef PyObject *(*intintargfunc)(PyObject *, int, int) Py_DEPRECATED(2.5);
typedef PyObject *(*ssizeargfunc)(PyObject *, Py_ssize_t);
typedef PyObject *(*ssizessizeargfunc)(PyObject *, Py_ssize_t, Py_ssize_t);
typedef int(*intobjargproc)(PyObject *, int, PyObject *);
typedef int(*intintobjargproc)(PyObject *, int, int, PyObject *);
typedef int(*ssizeobjargproc)(PyObject *, Py_ssize_t, PyObject *);
typedef int(*ssizessizeobjargproc)(PyObject *, Py_ssize_t, Py_ssize_t, PyObject *);
typedef int(*objobjargproc)(PyObject *, PyObject *, PyObject *);


typedef int (*getreadbufferproc)(PyObject *, int, void **);
typedef int (*getwritebufferproc)(PyObject *, int, void **);
typedef int (*getsegcountproc)(PyObject *, int *);
typedef int (*getcharbufferproc)(PyObject *, int, char **);

typedef Py_ssize_t (*readbufferproc)(PyObject *, Py_ssize_t, void **);
typedef Py_ssize_t (*writebufferproc)(PyObject *, Py_ssize_t, void **);
typedef Py_ssize_t (*segcountproc)(PyObject *, Py_ssize_t *);
typedef Py_ssize_t (*charbufferproc)(PyObject *, Py_ssize_t, char **);

typedef int (*objobjproc)(PyObject *, PyObject *);
typedef int (*visitproc)(PyObject *, void *);
typedef int (*traverseproc)(PyObject *, visitproc, void *);

typedef struct {
# 167 "object.h"
 binaryfunc nb_add;
 binaryfunc nb_subtract;
 binaryfunc nb_multiply;
 binaryfunc nb_divide;
 binaryfunc nb_remainder;
 binaryfunc nb_divmod;
 ternaryfunc nb_power;
 unaryfunc nb_negative;
 unaryfunc nb_positive;
 unaryfunc nb_absolute;
 inquiry nb_nonzero;
 unaryfunc nb_invert;
 binaryfunc nb_lshift;
 binaryfunc nb_rshift;
 binaryfunc nb_and;
 binaryfunc nb_xor;
 binaryfunc nb_or;
 coercion nb_coerce;
 unaryfunc nb_int;
 unaryfunc nb_long;
 unaryfunc nb_float;
 unaryfunc nb_oct;
 unaryfunc nb_hex;

 binaryfunc nb_inplace_add;
 binaryfunc nb_inplace_subtract;
 binaryfunc nb_inplace_multiply;
 binaryfunc nb_inplace_divide;
 binaryfunc nb_inplace_remainder;
 ternaryfunc nb_inplace_power;
 binaryfunc nb_inplace_lshift;
 binaryfunc nb_inplace_rshift;
 binaryfunc nb_inplace_and;
 binaryfunc nb_inplace_xor;
 binaryfunc nb_inplace_or;



 binaryfunc nb_floor_divide;
 binaryfunc nb_true_divide;
 binaryfunc nb_inplace_floor_divide;
 binaryfunc nb_inplace_true_divide;


 unaryfunc nb_index;
} PyNumberMethods;

typedef struct {
 lenfunc sq_length;
 binaryfunc sq_concat;
 ssizeargfunc sq_repeat;
 ssizeargfunc sq_item;
 ssizessizeargfunc sq_slice;
 ssizeobjargproc sq_ass_item;
 ssizessizeobjargproc sq_ass_slice;
 objobjproc sq_contains;

 binaryfunc sq_inplace_concat;
 ssizeargfunc sq_inplace_repeat;
} PySequenceMethods;

typedef struct {
 lenfunc mp_length;
 binaryfunc mp_subscript;
 objobjargproc mp_ass_subscript;
} PyMappingMethods;

typedef struct {
 readbufferproc bf_getreadbuffer;
 writebufferproc bf_getwritebuffer;
 segcountproc bf_getsegcount;
 charbufferproc bf_getcharbuffer;
} PyBufferProcs;


typedef void (*freefunc)(void *);
typedef void (*destructor)(PyObject *);
typedef int (*printfunc)(PyObject *, FILE *, int);
typedef PyObject *(*getattrfunc)(PyObject *, char *);
typedef PyObject *(*getattrofunc)(PyObject *, PyObject *);
typedef int (*setattrfunc)(PyObject *, char *, PyObject *);
typedef int (*setattrofunc)(PyObject *, PyObject *, PyObject *);
typedef int (*cmpfunc)(PyObject *, PyObject *);
typedef PyObject *(*reprfunc)(PyObject *);
typedef long (*hashfunc)(PyObject *);
typedef PyObject *(*richcmpfunc) (PyObject *, PyObject *, int);
typedef PyObject *(*getiterfunc) (PyObject *);
typedef PyObject *(*iternextfunc) (PyObject *);
typedef PyObject *(*descrgetfunc) (PyObject *, PyObject *, PyObject *);
typedef int (*descrsetfunc) (PyObject *, PyObject *, PyObject *);
typedef int (*initproc)(PyObject *, PyObject *, PyObject *);
typedef PyObject *(*newfunc)(struct _typeobject *, PyObject *, PyObject *);
typedef PyObject *(*allocfunc)(struct _typeobject *, Py_ssize_t);

typedef struct _typeobject {
 Py_ssize_t ob_refcnt; struct _typeobject *ob_type; Py_ssize_t ob_size;
 const char *tp_name;
 Py_ssize_t tp_basicsize, tp_itemsize;



 destructor tp_dealloc;
 printfunc tp_print;
 getattrfunc tp_getattr;
 setattrfunc tp_setattr;
 cmpfunc tp_compare;
 reprfunc tp_repr;



 PyNumberMethods *tp_as_number;
 PySequenceMethods *tp_as_sequence;
 PyMappingMethods *tp_as_mapping;



 hashfunc tp_hash;
 ternaryfunc tp_call;
 reprfunc tp_str;
 getattrofunc tp_getattro;
 setattrofunc tp_setattro;


 PyBufferProcs *tp_as_buffer;


 long tp_flags;

 const char *tp_doc;



 traverseproc tp_traverse;


 inquiry tp_clear;



 richcmpfunc tp_richcompare;


 Py_ssize_t tp_weaklistoffset;



 getiterfunc tp_iter;
 iternextfunc tp_iternext;


 struct PyMethodDef *tp_methods;
 struct PyMemberDef *tp_members;
 struct PyGetSetDef *tp_getset;
 struct _typeobject *tp_base;
 PyObject *tp_dict;
 descrgetfunc tp_descr_get;
 descrsetfunc tp_descr_set;
 Py_ssize_t tp_dictoffset;
 initproc tp_init;
 allocfunc tp_alloc;
 newfunc tp_new;
 freefunc tp_free;
 inquiry tp_is_gc;
 PyObject *tp_bases;
 PyObject *tp_mro;
 PyObject *tp_cache;
 PyObject *tp_subclasses;
 PyObject *tp_weaklist;
 destructor tp_del;
# 345 "object.h"
} PyTypeObject;



typedef struct _heaptypeobject {


 PyTypeObject ht_type;
 PyNumberMethods as_number;
 PyMappingMethods as_mapping;
 PySequenceMethods as_sequence;




 PyBufferProcs as_buffer;
 PyObject *ht_name, *ht_slots;

} PyHeapTypeObject;







PyAPI_FUNC(int) PyType_IsSubtype(PyTypeObject *, PyTypeObject *);



PyAPI_DATA(PyTypeObject) PyType_Type;
PyAPI_DATA(PyTypeObject) PyBaseObject_Type;
PyAPI_DATA(PyTypeObject) PySuper_Type;




PyAPI_FUNC(int) PyType_Ready(PyTypeObject *);
PyAPI_FUNC(PyObject *) PyType_GenericAlloc(PyTypeObject *, Py_ssize_t);
PyAPI_FUNC(PyObject *) PyType_GenericNew(PyTypeObject *,
            PyObject *, PyObject *);
PyAPI_FUNC(PyObject *) _PyType_Lookup(PyTypeObject *, PyObject *);


PyAPI_FUNC(int) PyObject_Print(PyObject *, FILE *, int);
PyAPI_FUNC(void) _PyObject_Dump(PyObject *);
PyAPI_FUNC(PyObject *) PyObject_Repr(PyObject *);
PyAPI_FUNC(PyObject *) _PyObject_Str(PyObject *);
PyAPI_FUNC(PyObject *) PyObject_Str(PyObject *);



PyAPI_FUNC(int) PyObject_Compare(PyObject *, PyObject *);
PyAPI_FUNC(PyObject *) PyObject_RichCompare(PyObject *, PyObject *, int);
PyAPI_FUNC(int) PyObject_RichCompareBool(PyObject *, PyObject *, int);
PyAPI_FUNC(PyObject *) PyObject_GetAttrString(PyObject *, const char *);
PyAPI_FUNC(int) PyObject_SetAttrString(PyObject *, const char *, PyObject *);
PyAPI_FUNC(int) PyObject_HasAttrString(PyObject *, const char *);
PyAPI_FUNC(PyObject *) PyObject_GetAttr(PyObject *, PyObject *);
PyAPI_FUNC(int) PyObject_SetAttr(PyObject *, PyObject *, PyObject *);
PyAPI_FUNC(int) PyObject_HasAttr(PyObject *, PyObject *);
PyAPI_FUNC(PyObject **) _PyObject_GetDictPtr(PyObject *);
PyAPI_FUNC(PyObject *) PyObject_SelfIter(PyObject *);
PyAPI_FUNC(PyObject *) PyObject_GenericGetAttr(PyObject *, PyObject *);
PyAPI_FUNC(int) PyObject_GenericSetAttr(PyObject *,
           PyObject *, PyObject *);
PyAPI_FUNC(long) PyObject_Hash(PyObject *);
PyAPI_FUNC(int) PyObject_IsTrue(PyObject *);
PyAPI_FUNC(int) PyObject_Not(PyObject *);
PyAPI_FUNC(int) PyCallable_Check(PyObject *);
PyAPI_FUNC(int) PyNumber_Coerce(PyObject **, PyObject **);
PyAPI_FUNC(int) PyNumber_CoerceEx(PyObject **, PyObject **);

PyAPI_FUNC(void) PyObject_ClearWeakRefs(PyObject *);


extern int _PyObject_SlotCompare(PyObject *, PyObject *);







PyAPI_FUNC(PyObject *) PyObject_Dir(PyObject *);



PyAPI_FUNC(int) Py_ReprEnter(PyObject *);
PyAPI_FUNC(void) Py_ReprLeave(PyObject *);


PyAPI_FUNC(long) _Py_HashDouble(double);
PyAPI_FUNC(long) _Py_HashPointer(void*);
# 701 "object.h"
PyAPI_FUNC(void) Py_IncRef(PyObject *);
PyAPI_FUNC(void) Py_DecRef(PyObject *);







PyAPI_DATA(PyObject) _Py_NoneStruct;
# 720 "object.h"
PyAPI_DATA(PyObject) _Py_NotImplementedStruct;
# 734 "object.h"
PyAPI_DATA(int) _Py_SwappedOp[];
# 846 "object.h"
PyAPI_FUNC(void) _PyTrash_deposit_object(PyObject*);
PyAPI_FUNC(void) _PyTrash_destroy_chain(void);
PyAPI_DATA(int) _PyTrash_delete_nesting;
PyAPI_DATA(PyObject *) _PyTrash_delete_later;
