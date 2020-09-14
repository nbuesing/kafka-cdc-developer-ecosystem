#!/bin/sh

key_schema=$(cat <<EOF
{
  "type": "record",
  "name": "Key",
  "namespace": "mysql.inventory.MSKU",
  "fields": [
    {
      "name": "MATNR",
      "type": "string"
    },
    {
      "name": "WERKS",
      "type": "string"
    },
    {
      "name": "CHARG",
      "type": "string"
    },
    {
      "name": "SOBKZ",
      "type": "string"
    },
    {
      "name": "KUNNR",
      "type": "string"
    },
    {
      "name": "MANDT",
      "type": "string"
    }
  ],
  "connect.name": "mysql.inventory.MSKU.Key"
}
EOF
)


value_schema=$(cat <<EOF
{
  "type": "record",
  "name": "Envelope",
  "namespace": "mysql.inventory.MSKU",
  "fields": [
    {
      "name": "before",
      "type": [
        "null",
        {
          "type": "record",
          "name": "Value",
          "fields": [
            {
              "name": "MANDT",
              "type": "string"
            },
            {
              "name": "MATNR",
              "type": "string"
            },
            {
              "name": "WERKS",
              "type": "string"
            },
            {
              "name": "CHARG",
              "type": "string"
            },
            {
              "name": "SOBKZ",
              "type": "string"
            },
            {
              "name": "KUNNR",
              "type": "string"
            },
            {
              "name": "LFGJA",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 0,
                  "precision": 4,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "0",
                    "connect.decimal.precision": "4"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            },
            {
              "name": "LFMON",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 0,
                  "precision": 2,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "0",
                    "connect.decimal.precision": "2"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            },
            {
              "name": "KUSPR",
              "type": [
                "null",
                "string"
              ],
              "default": null
            },
            {
              "name": "KULAB",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 3,
                  "precision": 13,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "3",
                    "connect.decimal.precision": "13"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            },
            {
              "name": "KUINS",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 3,
                  "precision": 13,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "3",
                    "connect.decimal.precision": "13"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            },
            {
              "name": "KUVLA",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 3,
                  "precision": 13,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "3",
                    "connect.decimal.precision": "13"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            },
            {
              "name": "KUVIN",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 3,
                  "precision": 13,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "3",
                    "connect.decimal.precision": "13"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            },
            {
              "name": "KUILL",
              "type": [
                "null",
                "string"
              ],
              "default": null
            },
            {
              "name": "KUILQ",
              "type": [
                "null",
                "string"
              ],
              "default": null
            },
            {
              "name": "KUVLL",
              "type": [
                "null",
                "string"
              ],
              "default": null
            },
            {
              "name": "KUVLQ",
              "type": [
                "null",
                "string"
              ],
              "default": null
            },
            {
              "name": "KUFLL",
              "type": [
                "null",
                "string"
              ],
              "default": null
            },
            {
              "name": "KUFLQ",
              "type": [
                "null",
                "string"
              ],
              "default": null
            },
            {
              "name": "KUDLL",
              "type": [
                "null",
                {
                  "type": "int",
                  "connect.version": 1,
                  "connect.name": "io.debezium.time.Date"
                }
              ],
              "default": null
            },
            {
              "name": "KUEIN",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 3,
                  "precision": 13,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "3",
                    "connect.decimal.precision": "13"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            },
            {
              "name": "KUVEI",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 3,
                  "precision": 13,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "3",
                    "connect.decimal.precision": "13"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            },
            {
              "name": "ERSDA",
              "type": [
                "null",
                {
                  "type": "int",
                  "connect.version": 1,
                  "connect.name": "io.debezium.time.Date"
                }
              ],
              "default": null
            },
            {
              "name": "KUJIN",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 0,
                  "precision": 4,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "0",
                    "connect.decimal.precision": "4"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            },
            {
              "name": "KURUE",
              "type": [
                "null",
                "string"
              ],
              "default": null
            },
            {
              "name": "KUUML",
              "type": [
                "null",
                {
                  "type": "bytes",
                  "scale": 3,
                  "precision": 13,
                  "connect.version": 1,
                  "connect.parameters": {
                    "scale": "3",
                    "connect.decimal.precision": "13"
                  },
                  "connect.name": "org.apache.kafka.connect.data.Decimal",
                  "logicalType": "decimal"
                }
              ],
              "default": null
            }
          ],
          "connect.name": "mysql.inventory.MSKU.Value"
        }
      ],
      "default": null
    },
    {
      "name": "after",
      "type": [
        "null",
        "Value"
      ],
      "default": null
    },
    {
      "name": "source",
      "type": {
        "type": "record",
        "name": "Source",
        "namespace": "io.debezium.connector.mysql",
        "fields": [
          {
            "name": "version",
            "type": "string"
          },
          {
            "name": "connector",
            "type": "string"
          },
          {
            "name": "name",
            "type": "string"
          },
          {
            "name": "ts_ms",
            "type": "long"
          },
          {
            "name": "snapshot",
            "type": [
              {
                "type": "string",
                "connect.version": 1,
                "connect.parameters": {
                  "allowed": "true,last,false"
                },
                "connect.default": "false",
                "connect.name": "io.debezium.data.Enum"
              },
              "null"
            ],
            "default": "false"
          },
          {
            "name": "db",
            "type": "string"
          },
          {
            "name": "table",
            "type": [
              "null",
              "string"
            ],
            "default": null
          },
          {
            "name": "server_id",
            "type": "long"
          },
          {
            "name": "gtid",
            "type": [
              "null",
              "string"
            ],
            "default": null
          },
          {
            "name": "file",
            "type": "string"
          },
          {
            "name": "pos",
            "type": "long"
          },
          {
            "name": "row",
            "type": "int"
          },
          {
            "name": "thread",
            "type": [
              "null",
              "long"
            ],
            "default": null
          },
          {
            "name": "query",
            "type": [
              "null",
              "string"
            ],
            "default": null
          }
        ],
        "connect.name": "io.debezium.connector.mysql.Source"
      }
    },
    {
      "name": "op",
      "type": "string"
    },
    {
      "name": "ts_ms",
      "type": [
        "null",
        "long"
      ],
      "default": null
    }
  ],
  "connect.name": "mysql.inventory.MSKU.Envelope"
}
EOF
)


PAYLOAD=$(cat <<EOF
{"MATNR":"00681490482165","WERKS":"1187","CHARG":"0137755W","SOBKZ":"W","KUNNR":"0001106662","MANDT":"010"}|{"before":{"mysql.inventory.MSKU.Value":{"MANDT":"010","MATNR":"00681490482165","WERKS":"1187","CHARG":"0137755W","SOBKZ":"W","KUNNR":"0001106662","LFGJA":{"bytes":"\u0002"},"LFMON":{"bytes":"\u0002"},"KUSPR":{"string":""},"KULAB":{"bytes":"\u0007Ð"},"KUINS":{"bytes":"\u0000"},"KUVLA":{"bytes":"\u0000"},"KUVIN":{"bytes":"\u0000"},"KUILL":{"string":""},"KUILQ":{"string":""},"KUVLL":{"string":""},"KUVLQ":{"string":""},"KUFLL":{"string":""},"KUFLQ":{"string":""},"KUDLL":null,"KUEIN":{"bytes":"\u0000"},"KUVEI":{"bytes":"\u0000"},"ERSDA":{"int":18262},"KUJIN":{"bytes":"\u0002"},"KURUE":{"string":""},"KUUML":{"bytes":"\u0000"}}},"after":{"mysql.inventory.MSKU.Value":{"MANDT":"010","MATNR":"00681490482165","WERKS":"1187","CHARG":"0137755W","SOBKZ":"W","KUNNR":"0001106662","LFGJA":{"bytes":"\u0002"},"LFMON":{"bytes":"\u0002"},"KUSPR":{"string":""},"KULAB":{"bytes":"\u0003è"},"KUINS":{"bytes":"\u0000"},"KUVLA":{"bytes":"\u0000"},"KUVIN":{"bytes":"\u0000"},"KUILL":{"string":""},"KUILQ":{"string":""},"KUVLL":{"string":""},"KUVLQ":{"string":""},"KUFLL":{"string":""},"KUFLQ":{"string":""},"KUDLL":null,"KUEIN":{"bytes":"\u0000"},"KUVEI":{"bytes":"\u0000"},"ERSDA":{"int":18262},"KUJIN":{"bytes":"\u0002"},"KURUE":{"string":""},"KUUML":{"bytes":"\u0000"}}},"source":{"version":"1.0.0.Final","connector":"mysql","name":"mysql","ts_ms":1580147696000,"snapshot":{"string":"false"},"db":"inventory","table":{"string":"MSKU"},"server_id":111111,"gtid":null,"file":"mysql-bin.000003","pos":57993338,"row":33,"thread":{"long":17},"query":null},"op":"u","ts_ms":{"long":1580147696525}}
EOF
)


echo $PAYLOAD |
kafka-avro-console-producer \
	--broker-list localhost:19092 \
	--property schema.registry.url="http://localhost:8081" \
	--topic mysql.inventory.MSKU \
	--property value.schema="${value_schema}" \
	--property key.schema="${key_schema}" \
        --property parse.key=true \
        --property key.separator=\|
