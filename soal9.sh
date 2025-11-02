# Worker Elendil
lynx -dump http://10.81.1.2:8001
curl -s http://10.81.1.2:8001/api/airings | head -20

# Worker Isildur
lynx -dump http://10.81.1.3:8002
curl -s http://10.81.1.3:8002/api/airings | head -20

# Worker Anarion
lynx -dump http://10.81.1.4:8003
curl -s http://10.81.1.4:8003/api/airings | head -20
