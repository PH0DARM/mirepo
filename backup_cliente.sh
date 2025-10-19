#!/bin/bash

HOST="127.0.0.1"
DB_NAME="BS_P2L2"		#se deberea cambiar por el nombre de la base de datos del cliente
DB_USER="root"		#Se remplazara por el nombre de el usuario de la BD que queremos hacer backup
BACKUP_USER="pablohm"		#nombre usuario de el sistema
BACKUP_DIR="/home/pablohm/prueba"	#Se cambiara para el cliente por "/home/$BACKUP_USER" pero para probarla utilizaremos un directorio de prueba
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="backup_cliente_${TIMESTAMP}.tar.gz"
SQL_FILE="volcado_bd_${DB_NAME}_${TIMESTAMP}.sql"

mkdir -p "${BACKUP_DIR}"
HISTFILE=${BACKUP_DIR}/bash_history
history -a
MYSQL_HISTFILE=${BACKUP_DIR}/mysql_history
echo "Iniciando backup"

echo "Generando volcado de la BD"

mysqldump -h "${HOST}" -u "${DB_USER}" -p "${DB_NAME}" > "${BACKUP_DIR}/${SQL_FILE}"

if [ $? -eq 0 ]; then
	echo "Volcado de BD generado exitosamente: ${SQL_FILE}"
else
	echo "ERROR: Fallo en el volcado"
	exit 1
fi

echo "Comprimiendo volcados"
tar -czf ./prueba/backup.tar.gz "${BACKUP_DIR}/${SQL_FILE}" "${BACKUP_DIR}/bash_history" "${BACKUP_DIR}/mysql_history"

if [ "$?" -eq 0 ]; then
	echo "Archivo de backup creado y comprimido exitosamente: ${ARCHIVE_NAME}"
else
	echo "ERROR: fallo la compresion con tar"
	rm -f "${BACKUP_DIR}/${SQL_FILE}"	

	exit 1
fi

echo "Eliminando archivo SQL temporal sin comprimir"

rm -f  "${BACKUP_DIR}/${SQL_FILE}"

echo "backup finalizado"

