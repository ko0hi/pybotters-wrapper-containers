# pybotters-wrapper-containers

pybotters-wrapperで使う用のDocker containerたちです。

```bash
docker-compose up -d
```

環境一覧。

- `pbw-influxdb`: InfluxDBコンテナ
- `pbw-grafana`: grafanaコンテナ（`pbw-influxdb`を自動設定）


環境変数一覧

| 環境変数名                   | 用途                     | デフォルト |
|:------------------------|:-----------------------|:-----|
| PBW_INFLUXDB_NAME | InfluxDBのコンテナ及びホスト名 | pbw-influxdb |
| PBW_INFLUXDB_PORT | InfluxDBのポート番号 | 8086 |
| PBW_INFLUXDB_INIT_MODE  | InfluxDBの初期化モード        | setup |
| PBW_INFLUXDB_USERNAME   | InfluxDBのユーザー名         | admin |
| PBW_INFLUXDB_PASSWORD   | InfluxDBのパスワード         | password |
| PBW_INFLUXDB_ORG        | InfluxDBのorganization名 | pbw |
| PBW_INFLUXDB_BUCKET     | InfluxDBのバケット名         | pbw |
| PBW_INFLUXDB_ADMIN_TOKEN| InfluxDBのAdmin token   | pbw |
| PBW_GRAFANA_NAME | Grafanaのコンテナ及びホスト名 | pbw-grafana |
| PBW_GRAFANA_PORT | Grahanaのポート番号 | 8085 |


