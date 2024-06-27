# IBM-MQ

## リモート伝送確認

キューマネージャ「QM1」のリモートキュー「QR1」にメッセージを PUT すると、キューマネージャ「QM2」のローカルキュー「Q2」にメッセージが PUT される。

### 実施方法

- docker を起動
  ```bash
  docker-compose up -d
  ```
- コンテナの中に入る
  ```bash
  docker exec -it ibmmq bash
  ```
- キューにメッセージを PUT  
   以下コマンドを実行する。
  ```bash
  /opt/mqm/samp/bin/amqsput QR1 QM1
  ```
- キューデータ件数を確認
  - MQ コンソールを起動
    ```bash
    runmqsc MQ2
    ```
  - キュー情報を確認
    ```bash
    DIS Q(Q2) CURDEPTH
    ```
    CURDEPTH の件数が PUT 時の件数となっていること

## 環境イメージ
![image](https://github.com/WealSoft-x/IBM-MQ/assets/103173507/16780809-b51b-4bf0-8682-617519eaf7ac)

## できるとよいこと
- キュー、チャネルの各プロパティに対する意味合いの理解
- MQMDのプロパティ理解

## 参考サイト

- リモート伝送関連  
  https://qiita.com/motuneko253/items/5ff42f7a69aa6dde6089#%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%82%AD%E3%83%A5%E3%83%BC%E4%BD%9C%E6%88%90

- MQ コマンド関連  
  https://qiita.com/legitwhiz/items/057d1075e5e78e556052
