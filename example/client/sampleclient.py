#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim: set fileencoding=utf-8 :
#
# Author:   Makoto Shimazu <makoto.shimaz@gmail.com>
# URL:      https://github.com/Pizaid
# License:  2-Clause BSD License
# Created:  2014-08-09
#

import sys
sys.path.append('gen-py')

from Pizaid import ControllerService
from Pizaid.ttypes import *

from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol

try:
    transport = TSocket.TSocket('localhost', 9090)
    transport = TTransport.TBufferedTransport(transport)
    protocol = TBinaryProtocol.TBinaryProtocol(transport)
    client = ControllerService.Client(protocol)
    transport.open()

#    print client.network_get_ipv4()
#    print client.storage_names()
#    print client.storage_join("main", "/dev/sda")
#    print client.storage_capacity_kb("main")
#    print client.storage_usage_kb("main")
#    print client.storage_usage_percent("main")
    print client.storage_devs("unused")
    print client.storage_dev_id("/dev/sda")
    print client.storage_dev_size("/dev/sda")
    print client.storage_dev_port("/dev/sda")

except Thrift.TException, tx:
    print '%s' % (tx.message)
