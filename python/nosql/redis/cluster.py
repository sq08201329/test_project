import redis 
import rediscluster
cluster = {
         # node names
         'nodes' : { # masters
                     'node_1' : {'host' : '127.0.0.1', 'port' : 63791},
                     'node_2' : {'host' : '127.0.0.1', 'port' : 63792},
                   }
    }

r = rediscluster.StrictRedisCluster(cluster=cluster, db=0)
r.set('foo1', 'bar')
print r.get('foo1')
print "foo at",r.getnodefor('foo')
#print dir(r)

