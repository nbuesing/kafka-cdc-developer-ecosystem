#!/bin/sh

key_schema=$(cat <<EOF
{
  "type": "record",
  "name": "T001W",
  "namespace": "key.SOURCEDB.CDCKAFKA_MAIN",
  "fields": [
    {
      "name": "MANDT",
      "type": {
        "type": "string",
        "logicalType": "CHARACTER",
        "dbColumnName": "MANDT",
        "length": 3
      },
      "default": ""
    },
    {
      "name": "WERKS",
      "type": {
        "type": "string",
        "logicalType": "VARCHAR",
        "dbColumnName": "WERKS",
        "length": 4
      },
      "default": ""
    }
  ]
}
EOF
)


value_schema=$(cat <<EOF
{
  "type": "record",
  "name": "T001W",
  "namespace": "value.SOURCEDB.CDCKAFKA_MAIN",
  "fields": [
    {
      "name": "MANDT",
      "type": {
        "type": "string",
        "logicalType": "CHARACTER",
        "dbColumnName": "MANDT",
        "length": 3
      },
      "default": ""
    },
    {
      "name": "WERKS",
      "type": {
        "type": "string",
        "logicalType": "VARCHAR",
        "dbColumnName": "WERKS",
        "length": 4
      },
      "default": ""
    },
    {
      "name": "NAME1",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "NAME1",
          "length": 30
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "BWKEY",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "BWKEY",
          "length": 4
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "KUNNR",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "KUNNR",
          "length": 10
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "LIFNR",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "LIFNR",
          "length": 10
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "FABKL",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "FABKL",
          "length": 2
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "NAME2",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "NAME2",
          "length": 30
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "STRAS",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "STRAS",
          "length": 30
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "PFACH",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "PFACH",
          "length": 10
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "PSTLZ",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "PSTLZ",
          "length": 10
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "ORT01",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "ORT01",
          "length": 25
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "EKORG",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "EKORG",
          "length": 4
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "VKORG",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "VKORG",
          "length": 4
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "CHAZV",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "CHAZV",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "KKOWK",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "KKOWK",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "KORDB",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "KORDB",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "BEDPL",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "BEDPL",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "LAND1",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "LAND1",
          "length": 3
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "REGIO",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "REGIO",
          "length": 3
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "COUNC",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "COUNC",
          "length": 3
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "CITYC",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "CITYC",
          "length": 4
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "ADRNR",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "ADRNR",
          "length": 10
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "IWERK",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "IWERK",
          "length": 4
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "TXJCD",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "TXJCD",
          "length": 15
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "VTWEG",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "VTWEG",
          "length": 2
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "SPART",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "SPART",
          "length": 2
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "SPRAS",
      "type": [
        {
          "type": "string",
          "logicalType": "CHARACTER",
          "dbColumnName": "SPRAS",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "WKSOP",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "WKSOP",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "AWSLS",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "AWSLS",
          "length": 6
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "CHAZV_OLD",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "CHAZV_OLD",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "VLFKZ",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "VLFKZ",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "BZIRK",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "BZIRK",
          "length": 6
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "ZONE1",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "ZONE1",
          "length": 10
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "TAXIW",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "TAXIW",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "BZQHL",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "BZQHL",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "LET01",
      "type": [
        {
          "type": "int",
          "logicalType": "DECIMAL",
          "dbColumnName": "LET01",
          "precision": 3,
          "scale": 0
        },
        "null"
      ],
      "default": 0
    },
    {
      "name": "LET02",
      "type": [
        {
          "type": "int",
          "logicalType": "DECIMAL",
          "dbColumnName": "LET02",
          "precision": 3,
          "scale": 0
        },
        "null"
      ],
      "default": 0
    },
    {
      "name": "LET03",
      "type": [
        {
          "type": "int",
          "logicalType": "DECIMAL",
          "dbColumnName": "LET03",
          "precision": 3,
          "scale": 0
        },
        "null"
      ],
      "default": 0
    },
    {
      "name": "TXNAM_MA1",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "TXNAM_MA1",
          "length": 16
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "TXNAM_MA2",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "TXNAM_MA2",
          "length": 16
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "TXNAM_MA3",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "TXNAM_MA3",
          "length": 16
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "BETOL",
      "type": [
        {
          "type": "int",
          "logicalType": "DECIMAL",
          "dbColumnName": "BETOL",
          "precision": 3,
          "scale": 0
        },
        "null"
      ],
      "default": 0
    },
    {
      "name": "J_1BBRANCH",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "J_1BBRANCH",
          "length": 4
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "VTBFI",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "VTBFI",
          "length": 2
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "FPRFW",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "FPRFW",
          "length": 3
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "ACHVM",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "ACHVM",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "DVSART",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "DVSART",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "NODETYPE",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "NODETYPE",
          "length": 3
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "NSCHEMA",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "NSCHEMA",
          "length": 4
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "PKOSA",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "PKOSA",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "MISCH",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "MISCH",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "MGVUPD",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "MGVUPD",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "VSTEL",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "VSTEL",
          "length": 4
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "MGVLAUPD",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "MGVLAUPD",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "SOURCING",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "SOURCING",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "MGVLAREVAL",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "MGVLAREVAL",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "OILIVAL",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "OILIVAL",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "OIHVTYPE",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "OIHVTYPE",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "OIHCREDIPI",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "OIHCREDIPI",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "STORETYPE",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "STORETYPE",
          "length": 1
        },
        "null"
      ],
      "default": ""
    },
    {
      "name": "DEP_STORE",
      "type": [
        {
          "type": "string",
          "logicalType": "VARCHAR",
          "dbColumnName": "DEP_STORE",
          "length": 4
        },
        "null"
      ],
      "default": ""
    }
  ]
}
EOF
)


PAYLOAD=$(cat <<EOF
{"MANDT":"010","WERKS":"1187"}|{"MANDT": "010", "WERKS": "Z703", "NAME1": {"string": "Autosuture Brazil Fixed Asset"}, "BWKEY": {"string": "Z703"}, "KUNNR": {"string": ""}, "LIFNR": {"string": ""}, "FABKL": {"string": "BR"}, "NAME2": {"string": "Logical DC"}, "STRAS": {"string": "Distrito Industrial"}, "PFACH": {"string": ""}, "PSTLZ": {"string": "13280-000"}, "ORT01": {"string": "VINHEDO"}, "EKORG": {"string": "P200"}, "VKORG": {"string": ""}, "CHAZV": {"string": ""}, "KKOWK": {"string": ""}, "KORDB": {"string": ""}, "BEDPL": {"string": ""}, "LAND1": {"string": "BR"}, "REGIO": {"string": "SP"}, "COUNC": {"string": ""}, "CITYC": {"string": ""}, "ADRNR": {"string": "0009068776"}, "IWERK": {"string": "Z395"}, "TXJCD": {"string": "SP 3556701"}, "VTWEG": {"string": ""}, "SPART": {"string": ""}, "SPRAS": {"string": "E"}, "WKSOP": {"string": ""}, "AWSLS": {"string": ""}, "CHAZV_OLD": {"string": ""}, "VLFKZ": {"string": ""}, "BZIRK": {"string": ""}, "ZONE1": {"string": ""}, "TAXIW": {"string": ""}, "BZQHL": {"string": ""}, "LET01": {"int": 0}, "LET02": {"int": 0}, "LET03": {"int": 0}, "TXNAM_MA1": {"string": ""}, "TXNAM_MA2": {"string": ""}, "TXNAM_MA3": {"string": ""}, "BETOL": {"int": 0}, "J_1BBRANCH": {"string": "1703"}, "VTBFI": {"string": ""}, "FPRFW": {"string": ""}, "ACHVM": {"string": ""}, "DVSART": {"string": ""}, "NODETYPE": {"string": ""}, "NSCHEMA": {"string": "0001"}, "PKOSA": {"string": ""}, "MISCH": {"string": ""}, "MGVUPD": {"string": "X"}, "VSTEL": {"string": ""}, "MGVLAUPD": {"string": "2"}, "SOURCING": {"string": ""}, "MGVLAREVAL": {"string": ""}, "OILIVAL": {"string": ""}, "OIHVTYPE": {"string": ""}, "OIHCREDIPI": {"string": ""}, "STORETYPE": {"string": ""}, "DEP_STORE": {"string": ""}}
EOF
)


echo $PAYLOAD |
kafka-avro-console-producer \
	--broker-list localhost:19092 \
	--property schema.registry.url="http://localhost:8081" \
	--topic mysql.inventory.T001W \
	--property value.schema="${value_schema}" \
	--property key.schema="${key_schema}" \
        --property parse.key=true \
        --property key.separator=\|
