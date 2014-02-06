import redis
import rediscluster
cluster = {
         # node names
         'nodes' : { # masters
                     'node_1' : {'host' : '192.168.1.109', 'port' : 6379},
                     'node_2' : {'host' : '192.168.1.109', 'port' : 6380},
                   }
    }

r = rediscluster.StrictRedisCluster(cluster=cluster, db=0)
r.set('foo1', 'bar')
print r.get('foo1')
print "foo at",r.getnodefor('foo')
#print dir(r)

