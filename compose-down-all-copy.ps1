Write-Output "Deteniendo todos los servicios..."

docker compose -f ".\AdminBD\Equipo 4 - Empleados\Empleados\docker-compose.yml" down -v
docker compose -f ".\AdminBD\Equipo 3 - Citas\citas\docker-compose.yml" down -v
docker compose -f ".\AdminBD\Equipo 2 - Pacientes\pacientes\docker-compose.yml" down -v
docker compose -f ".\AdminBD\Equipo 1 - Hospitales\hospital_proyecto\docker-compose.yml" down -v
docker compose -f ".\AdminBD\DataWarehouse\docker-compose.yml" down -v

Write-Output "Todos los servicios han sido detenidos."
