#!/bin/bash

DB_NAME = "base_datos"
DB_USER = "pablohm"
BACKUP_USER = "pablohm"
BACKUP_DIR = "/home/$BACKUP_USER"
TIMESTAMP = $(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME = "backup_cliente_${TIMESTAMP}.tar.gz"
SQL_FILE = "volcado_bd${DB_NAME}_${TIMESTAMP}.sql"

echo "Iniciando backup"

echo "Generando volcado de la BD"

mysqldump -u ${DB_USER}} -P ${DB_NAME} > ${BACKUP_DIR}/${SQL_FILE}

if [$? -eq 0]; then
	echo "Volcado de BD generado exitosamente: ${SQL_FILE}"
else
	echo "ERROR: Fallo en el volcado"
	exit 1
fi

echo "Comprimiendo volcados"

tar -czvf ${BACKUP_DIR}/${ARCHIVO_NAME} \ ${BACKUP_DIR}/${SQL_FILE} \ /home/${BACKUP_USER}/.bash_history \ /home/${BACKUP_USER}/.mysql_history

if [$? -eq 0]; then
	echo "Archivo de backup creado y comprimido exitosamente: ${ARCHIVE_NAME}"
else
	echo "ERROR: fallo la compresion con tar"
	exit 1
fi

echo "Eliminando archivo SQL temporal sin comprimir"

rm ${BACKUP_DIR}/${SQL_FILE}

echo "backup finalizado"

