import redis
r = redis.Redis('localhost',6379,0)
print dir(r)
