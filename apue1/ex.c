int main(int __argc, const char * __agrv[])
{
	int * __p = (int *)__argc;
	(*__p) = 9999;
	if ((*__p) == 9999)
		return 5;
	return	(*__p);
}
