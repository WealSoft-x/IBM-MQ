#!/bin/sh
# キューマネージャ作成
crtmqm QM1
crtmqm QM2

# キューマネージャ起動
strmqm QM1
strmqm QM2

# リスナーの作成
echo "def listener(LISTENER) trptype(tcp) port(1414) control(qmgr)" | runmqsc QM1
echo "def listener(LISTENER) trptype(tcp) port(1415) control(qmgr)" | runmqsc QM2

# リスナー起動
echo "START LISTENER(LISTENER)" | runmqsc QM1
echo "START LISTENER(LISTENER)" | runmqsc QM2

# チャネル作成
echo "DEF CHL('QM1.TO.QM2') CHLTYPE(SDR) CONNAME('localhost(1415)') XMITQ('Q1') REPLACE" | runmqsc QM1
echo "DEF CHL('QM1.TO.QM2') CHLTYPE(RCVR) REPLACE" | runmqsc QM2

# キュー作成
# QM1
echo "DEF QL('Q1') USAGE(XMITQ) REPLACE" | runmqsc QM1
echo "DEF QR('QR1') RNAME('Q2') RQMNAME('QM2') XMITQ('Q1')" | runmqsc QM1

# QM2
echo "DEF QL('Q2') REPLACE" | runmqsc QM2

# チャネル起動(RCVから起動)
echo "STA CHL('QM1.TO.QM2')" | runmqsc QM2
echo "STA CHL('QM1.TO.QM2')" | runmqsc QM1

# リモートキューへPUTすることで、XMIQTに伝搬し、チャネルがXMIQを拾いリモートへ伝送する
# /opt/mqm/samp/bin/amqsput QR1 QM1

tail -f /dev/null
