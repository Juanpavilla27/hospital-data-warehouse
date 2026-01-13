#!/bin/bash
echo "🟡 Ejecutando restauración..."

if [ -d /data/db ] && [ ! -d /data/db/gestion_empleados ]; then
  echo "🟡 Restaurando backup gestion_empleados desde /backup/gestion_empleados..."
  mongorestore --db gestion_empleados --dir /backup/gestion_empleados
  echo "✅ Restauración completada."
else
  echo "📂 La base gestion_empleados ya existe. No se restaura nada."
fi
