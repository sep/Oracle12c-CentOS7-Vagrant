#!/usr/bin/python
sysctlFile = open('/etc/security/limits.conf', 'a')
sysctlFile.write('oracle soft nproc 2047\n')
sysctlFile.write('oracle hard nproc 16384\n')
sysctlFile.write('oracle soft nofile 1024\n')
sysctlFile.write('oracle hard nofile 65536\n')
sysctlFile.write('kernel.shmmni = 4096\n')
sysctlFile.close()